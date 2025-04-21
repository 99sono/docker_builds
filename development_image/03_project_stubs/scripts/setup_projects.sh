#!/bin/bash
# Script to set up minimal project stubs without dependencies

# Create main project directories
mkdir -p /home/developer/dev/{java,node,python}

# Java projects
for i in 01 02; do
    PROJECT_DIR="/home/developer/dev/java/dummy_java_project$i"
    mkdir -p "$PROJECT_DIR/src/main/java" "$PROJECT_DIR/src/test/java"
    
    # Create minimal pom.xml
    cat > "$PROJECT_DIR/pom.xml" << EOL
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>dummy-java-project$i</artifactId>
    <version>1.0.0</version>
</project>
EOL

    # Create minimal Main.java
    cat > "$PROJECT_DIR/src/main/java/Main.java" << EOL
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from dummy project $i");
    }
}
EOL
done

# Node.js projects
for i in 01 02; do
    PROJECT_DIR="/home/developer/dev/node/dummy_node_project$i"
    mkdir -p "$PROJECT_DIR"
    
    # Create minimal package.json
    cat > "$PROJECT_DIR/package.json" << EOL
{
    "name": "dummy-node-project$i",
    "version": "1.0.0",
    "private": true
}
EOL

    # Create minimal index.js
    cat > "$PROJECT_DIR/index.js" << EOL
console.log('Hello from dummy project $i');
EOL
done

# Python projects
for i in 01 02; do
    PROJECT_DIR="/home/developer/dev/python/dummy_python_project$i"
    mkdir -p "$PROJECT_DIR"
    
    # Create empty requirements.txt
    touch "$PROJECT_DIR/requirements.txt"
    
    # Create minimal main.py
    cat > "$PROJECT_DIR/main.py" << EOL
def main():
    print("Hello from dummy project $i")

if __name__ == "__main__":
    main()
EOL
done

# Create workspace README
cat > /home/developer/dev/README.md << EOL
# Development Workspace

This workspace contains minimal project stubs for different development environments:

## Java Projects
- \`java/dummy_java_project01\`: Basic Java project stub 1
- \`java/dummy_java_project02\`: Basic Java project stub 2

## Node.js Projects
- \`node/dummy_node_project01\`: Basic Node.js project stub 1
- \`node/dummy_node_project02\`: Basic Node.js project stub 2

## Python Projects
- \`python/dummy_python_project01\`: Basic Python project stub 1
- \`python/dummy_python_project02\`: Basic Python project stub 2

Each project is a minimal stub without dependencies. Add dependencies and additional configuration as needed for your specific use case.
EOL

# Set correct ownership and permissions
chown -R developer:developer /home/developer/dev
find /home/developer/dev -type d -exec chmod 755 {} \;
find /home/developer/dev -type f -exec chmod 644 {} \;