# UiTM-PTAR-eLibrary-System

## Summary of the Checklist:

1.  **Java Classes/Servlets:**
    * **Location:** Always inside `src/main/java/com/student/app/`.
    * **Requirement:** Must have the `@WebServlet("/path")` annotation to be reachable via browser.

2.  **HTML/JSP/CSS Pages:**
    * **Location:** Always inside `src/main/webapp/`.
    * **Access:** These are accessed directly by filename (e.g., `http://localhost:8080/StudentWebApp/index.jsp`).

---

## Command snippets

> [!note]create new project: 
```bash
mvn archetype:generate -DgroupId=com.library.app -DartifactId=UITMPTARELibrarySystem -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false

```

> [!note]compile and run project:
```bash
mvn clean cargo:run

```

> [!note]compile project:
```bash
mvn compile

```

> [!note]build:
```bash
mvn clean package

```

---

## Code snippets

> [!NOTE]pom.xml file template
```xml
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
 
  <groupId>com.library.app</groupId>
  <artifactId>UITMPTARELibrarySystem</artifactId>
  <packaging>war</packaging>
  <version>1.0-SNAPSHOT</version>
 
  <properties>
    <maven.compiler.source>17</maven.compiler.source>
    <maven.compiler.target>17</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
  </properties>

  <dependencies>
    <dependency>
      <groupId>jakarta.servlet</groupId>
      <artifactId>jakarta.servlet-api</artifactId>
      <version>5.0.0</version>
      <scope>provided</scope>
    </dependency>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.13.2</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
 
  <build>
    <finalName>UITMPTARELibrarySystem</finalName>
    <plugins>
      <plugin>
        <groupId>org.codehaus.cargo</groupId>
        <artifactId>cargo-maven3-plugin</artifactId>
        <version>1.10.7</version>
        <configuration>
          <container>
            <containerId>tomcat10x</containerId>
            <type>embedded</type>
          </container>
          <configuration>
            <properties>
              <cargo.servlet.port>8080</cargo.servlet.port>
            </properties>
          </configuration>
        </configuration>
      </plugin>
    </plugins>
  </build>
</project>

```

