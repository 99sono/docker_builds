#!/bin/bash
# setup_java.sh
#
# This script installs the requested OpenJDK and configures it as the system default.
#
# The Debian/Ubuntu 'default-java' symlink is managed by the java-common package
# and often points to a hardcoded version for the specific OS release.
# Simply using 'update-alternatives' is not enough to update this symlink.
# This script manually updates 'default-java' to point to the newly installed JDK.

set -e

JDK_VERSION="25"
JDK_DIR="/usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64"

echo "Installing OpenJDK ${JDK_VERSION}..."
apt-get update && apt-get install -y \
    openjdk-${JDK_VERSION}-jdk \
    maven \
    && apt-get clean \
    && rm -rf /tmp/* /var/tmp/*

echo "Configuring alternatives for java and javac..."
update-alternatives --set java /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64/bin/java
update-alternatives --set javac /usr/lib/jvm/java-${JDK_VERSION}-openjdk-amd64/bin/javac

echo "Updating default-java symlink to point to Java ${JDK_VERSION}..."
if [ -d "$JDK_DIR" ]; then
    ln -sfn "$JDK_DIR" /usr/lib/jvm/default-java
else
    echo "Error: Directory $JDK_DIR does not exist."
    exit 1
fi

echo "Java ${JDK_VERSION} setup complete."
