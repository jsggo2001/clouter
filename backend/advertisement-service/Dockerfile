FROM gradle:7.4-jdk11-alpine AS builder
WORKDIR /app
# 그래들 파일이 변경되었을 때만 새롭게 의존패키지 다운로드 받게함.
COPY build.gradle settings.gradle /app/
RUN gradle clean build -x test --parallel --continue > /dev/null 2>&1 || true
# 빌더 이미지에서 애플리케이션 빌드
COPY ./ ./
RUN gradle build -x test --parallel

FROM openjdk:11-jdk
WORKDIR /app
# ARG JAR_FILE=/build/libs/*.jar
COPY --from=builder /app/build/libs/*.jar /app/AdvertisementService.jar
ENTRYPOINT ["java", "-jar", "AdvertisementService.jar"]