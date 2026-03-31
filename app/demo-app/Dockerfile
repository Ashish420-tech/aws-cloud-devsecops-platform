# Use lightweight Java runtime
FROM eclipse-temurin:17-jdk-jammy


# Set working directory
WORKDIR /app

# Copy jar file
COPY target/demo-app-1.0-SNAPSHOT.jar app.jar

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
