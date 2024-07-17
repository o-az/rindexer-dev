# syntax = docker/dockerfile:1
ARG POSTGRES_VERSION=latest
FROM postgres:${POSTGRES_VERSION}

ARG PORT=5440

ENV POSTGRES_USER="postgres"
ENV POSTGRES_DATABASE="postgres"
ENV POSTGRES_PASSWORD="rindexer"
ENV POSTGRES_PORT=${PORT}

RUN apt-get update --yes \
  && apt-get install --yes --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# Copy initialization scripts
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE ${POSTGRES_PORT}
