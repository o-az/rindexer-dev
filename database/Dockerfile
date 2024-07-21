# syntax = docker/dockerfile:1
ARG POSTGRES_VERSION=latest
FROM postgres:${POSTGRES_VERSION}

ARG PORT=5440

ENV POSTGRES_PORT=${PORT}
ENV POSTGRES_USERNAME="postgres"
ENV POSTGRES_DATABASE="postgres"
ENV POSTGRES_PASSWORD="rindexer"

RUN apt-get update --yes \
  && apt-get install --yes --no-install-recommends \
  && apt-get autoremove --yes \
  && apt-get clean --yes \
  && rm -rf /var/lib/apt/lists/*

# Copy initialization scripts
COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE ${POSTGRES_PORT}
