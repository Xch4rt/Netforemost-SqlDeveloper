FROM postgres:12.4

ENV POSTGRES_USER=admin
ENV POSTGRES_PASSWORD=SuperSecurePassword
ENV POSTGRES_DB=surveysdb

COPY ./initdb /docker-entrypoint-initdb.d/

EXPOSE 5432
