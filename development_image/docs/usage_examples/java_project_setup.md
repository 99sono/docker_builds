# Java Project Setup Guide

## Prerequisites
- Docker development environment is running
- SSH key has been uploaded to container
- Java 17 and Maven 3.9.6 are pre-installed

## Step 1: Create New Java Project

### Option A: Spring Boot Project
```bash
# SSH into container
ssh developer@localhost -p 2222

# Create Spring Boot project
cd /home/developer/dev
curl https://start.spring.io/starter.zip \
  -d dependencies=web,data-jpa,h2 \
  -d javaVersion=17 \
  -d bootVersion=3.2.0 \
  -d groupId=com.example \
  -d artifactId=demo \
  -d name=demo \
  -o demo.zip

unzip demo.zip && rm demo.zip
cd demo
```

### Option B: Maven Archetype
```bash
# SSH into container
ssh developer@localhost -p 2222

# Create Maven project
cd /home/developer/dev
mvn archetype:generate \
  -DgroupId=com.example \
  -DartifactId=my-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DinteractiveMode=false
```

## Step 2: IntelliJ IDEA Integration

### IntelliJ Remote SSH
1. Open IntelliJ IDEA
2. Go to **File → Remote Development → SSH**
3. Add new connection:
   - Host: `localhost`
   - Port: `2222`
   - User: `developer`
   - Key file: Your private key
4. Connect and open `/home/developer/dev/your-project`

## Step 3: Build and Run

### Maven Commands
```bash
# Build project
mvn clean compile

# Run tests
mvn test

# Package application
mvn package

# Run Spring Boot app
mvn spring-boot:run
```

### Hot Reload Development
```bash
# Install Spring Boot DevTools (already in pom.xml)
# Changes will auto-reload
mvn spring-boot:run
```

## Step 4: Debugging Setup

### IntelliJ Remote Debugging
1. Add to `pom.xml`:
```xml
<plugin>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-maven-plugin</artifactId>
    <configuration>
        <jvmArguments>
            -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005
        </jvmArguments>
    </configuration>
</plugin>
```

2. Run with debug:
```bash
mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"
```

3. IntelliJ → Run → Edit Configurations → Remote JVM Debug

## Step 5: Database Setup

### H2 Database (Development)
```bash
# Already included in Spring Boot starter
# Access at: http://localhost:8080/h2-console
```

### PostgreSQL (Production-like)
```bash
# Install PostgreSQL client
sudo apt update && sudo apt install postgresql-client

# Connect to external database
psql -h your-db-host -U your-user -d your-database
```

## Step 6: Testing

### Unit Tests
```bash
# Run all tests
mvn test

# Run specific test
mvn test -Dtest=YourTestClass

# Run with coverage
mvn jacoco:prepare-agent test jacoco:report
```

### Integration Tests
```bash
# Run integration tests
mvn verify

# Run specific integration test
mvn verify -Dit.test=YourIntegrationTest
```

## Step 7: IDE Configuration Files

### VS Code Settings
Create `.vscode/settings.json`:
```json
{
    "java.configuration.updateBuildConfiguration": "interactive",
    "java.compile.nullAnalysis.mode": "automatic",
    "java.format.settings.url": "https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml"
}
```

### IntelliJ IDEA Files
- `.idea/` directory will be created automatically
- Import as Maven project
- Enable auto-import for dependencies

## Common Issues and Solutions

### Issue: Maven Dependencies Not Found
```bash
# Clear local repository
rm -rf ~/.m2/repository
mvn clean install
```

### Issue: Port Already in Use
```bash
# Check port usage
lsof -i :8080
# Kill process or use different port
mvn spring-boot:run -Dserver.port=8081
```

### Issue: Memory Issues
```bash
# Increase heap size
export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=256m"
```

## Next Steps
- Add Docker Compose for database services
- Configure CI/CD pipeline
- Add monitoring and logging
- Set up production deployment
