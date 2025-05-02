# Step 1: 빌드
FROM gradle:8.5-jdk17 AS builder
WORKDIR /app
COPY . .
RUN gradle clean bootJar --no-daemon

# Step 2: 실행용 이미지
FROM eclipse-temurin:17-jdk-slim
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
