
# Используем официальный образ PostgreSQL
FROM postgres:16.2

# Установка переменных окружения
ENV POSTGRES_USER=postgres
ENV POSTGRES_PASSWORD=postgres
ENV POSTGRES_DB=postgres

# Копируем скрипт инициализации базы данных
COPY init.sql /docker-entrypoint-initdb.d/

# Объявляем порт, на котором будет доступна база данных
EXPOSE 5432
