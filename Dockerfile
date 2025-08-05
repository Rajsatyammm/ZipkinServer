# Stage 1: Build
FROM maven:3.9.6-eclipse-temurin-17-alpine as builder
LABEL authors="raj"

WORKDIR /app

COPY . .

# Combine into a single RUN command for efficiency
RUN mvn clean install -DskipTests

# Stage 2: Run
FROM maven:3.9.6-eclipse-temurin-17-alpine as runner

WORKDIR /app

# Copy the jar from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Set environment variable (no spaces around '=')
ENV server.port=8890

# Use ENTRYPOINT for better override behavior in container orchestration
ENTRYPOINT ["java", "-jar", "app.jar"]
