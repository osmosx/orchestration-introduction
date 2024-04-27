# Stage 1: Сборка приложения
FROM maven:3.8.4-jdk-8 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файлы сборки
COPY .mvn .mvn
COPY mvnw pom.xml ./
RUN mvn -B dependency:go-offline

# Копируем исходный код
COPY src ./src

# Собираем приложение
RUN mvn -B package -DskipTests

# Stage 2: Запуск приложения в отдельном контейнере
FROM openjdk:8-jdk-alpine

# Копируем собранное приложение из предыдущего стейджа
COPY --from=build /app/target/*.jar /app/app.jar
COPY wait-for-it.sh .

# Ожидаем, пока база данных PostgreSQL будет доступна
RUN apk add --no-cache bash
RUN chmod +x wait-for-it.sh

# Запускаем приложение
CMD ["./wait-for-it.sh", "-t", "60", "postgres:5432", "--", \
     "./wait-for-it.sh", "-t", "60", "rabbitmq:5672", "--", \
     "./wait-for-it.sh", "-t", "60", "session-service:8081", "--", \
     "./wait-for-it.sh", "-t", "60", "hotel-service:8082", "--", \
     "./wait-for-it.sh", "-t", "60", "booking-service:8083", "--", \
     "./wait-for-it.sh", "-t", "60", "payment-service:8084", "--", \
     "./wait-for-it.sh", "-t", "60", "loyalty-service:8085", "--", \
     "./wait-for-it.sh", "-t", "60", "report-service:8086", "--", \
     "java", "-jar", "/app/app.jar"]
