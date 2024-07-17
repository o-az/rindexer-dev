set shell := ["bash", "-uc"]
set positional-arguments
set dotenv-load
set export

pre:
  sudo chown -R $USER .

default: pre

[group("docker")]
build:
  docker buildx build \
    --file='./Dockerfile' . \
    --platform='linux/amd64' \
    --build-arg PORT='5173' \
    --build-arg NODE_ENV='production' \
    --tag='rindexer-railway' \
    --label='rindexer-railway' \
    --progress='plain' \
    --no-cache

[group("docker")]
run:
  docker run \
    --rm \
    -it \
    --name='rindexer-railway' \
    --platform='linux/amd64' \
    --publish-all \
    --env='PORT=5173' \
    --env='NODE_ENV=production' \
    --label='rindexer-railway' \
    'rindexer-railway:latest'

#### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ####

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
fml: fmt lint

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
