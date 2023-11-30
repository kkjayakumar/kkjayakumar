# Use a base image with Java and Maven installed
FROM maven:3.8.4-openjdk-11-slim AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project's pom.xml and other necessary files
COPY pom.xml /app/
COPY src /app/src/

# Build the application using Maven
RUN mvn clean package

# Create a new lightweight image to deploy the application
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/your-application.jar /app/your-application.jar

# Expose the port if your application runs on a specific port
# EXPOSE <port_number>

# Command to run the application
CMD ["java", "-jar", "your-application.jar"]
