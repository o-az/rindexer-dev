set shell := ["bash", "-uc"]
set positional-arguments
set dotenv-load
set export

pre:
  sudo chown -R $USER .

default: pre

init:
  test -f .env || cp .env.example .env

[group("docker")]
build-rindexer:
  docker buildx build \
    --file='./Dockerfile' . \
    --platform='linux/amd64' \
    --tag='rindexer' \
    --label='rindexer' \
    --progress='plain' \
    --no-cache \
    --build-arg="PROJECT_PATH=$PROJECT_PATH"

[group("docker")]
run-rindexer:
  docker run \
    -it \
    --rm \
    --pull='never' \
    --publish-all \
    --platform='linux/amd64' \
    --name='rindexer' \
    --label='rindexer' \
    'rindexer:latest' \
    --env="DATABASE_URL=$DATABASE_URL" \
    --env="POSTGRES_PASSWORD=$POSTGRES_PASSWORD"

[group("docker")]
build-postgres:
  docker buildx build \
    --file='./database/Dockerfile' ./database \
    --tag='rindexer-postgres' \
    --label='rindexer-postgres' \
    --progress='plain' \
    --no-cache \
    --build-arg="PORT=5440"

[group("docker")]
run-postgres:
  docker run \
    -it \
    --rm \
    --detach \
    --pull='never' \
    --publish='5440:5432' \
    --name='rindexer-postgres' \
    --label='rindexer-postgres' \
    'rindexer-postgres:latest'

[group("docker")]
run-rindexer-command *command:
  docker run \
    -it \
    --rm \
    --pull='never' \
    --name='rindexer' \
    --platform='linux/amd64' \
    --publish-all \
    --env="DATABASE_URL=$DATABASE_URL" \
    --env="POSTGRES_PASSWORD=$POSTGRES_PASSWORD" \
    --label='rindexer' \
    'rindexer:latest' \
    {{command}}

[group("railway")]
wipe-db-volume:
  curl --request POST \
    --url 'https://backboard.railway.app/graphql/v2' \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer $RAILWAY_API_TOKEN" \
    --data-raw '"query": "mutation { volumeInstanceWipe(volumeInstanceId: \"52c4d03d-6a64-42fe-b294-289be808e713\") }"'

[group("graphql")]
health:
  curl --request POST \
    --url 'http://localhost:3001/graphql' \
    --header 'Content-Type: application/json' \
    --data-raw '{"query":"query HealthQuery { nodeId __typename }"}'

#### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ####

# https://docs.sqlfluff.com/en/stable/gettingstarted.html
[group("lint")]
lint-sql:
  sqlfluff lint . --dialect=postgres

[group("lint")]
format:
  biome format . \
    --log-level="info" \
    --log-kind="pretty" \
    --error-on-warnings \
    --diagnostic-level="info" \
    --write

[group("lint")]
lint:
  biome lint . \
    --log-level="info" \
    --log-kind="pretty" \
    --error-on-warnings \
    --diagnostic-level="info" \
    --write \
    --unsafe

[group("lint")]
format-nix:
	nixfmt *.nix --width=100 --verify

[group("lint")]
fmt: format format-nix
[group("lint")]
fml: fmt lint lint-sql

# does both format and lint checks
[group("lint-check")]
lint-check:
  biome check . \
    --log-level="info" \
    --log-kind="pretty" \
    --error-on-warnings \
    --diagnostic-level="info"

[group("lint-check")]
format-nix-check:
  nixfmt *.nix --width=100 --check

[group("lint-check")]
fmt-check: format-nix-check
[group("lint-check")]
fml-check: fmt-check lint-check
