<!-- #### [railway.app](https://railway.app?referralCode=eD4laT) template to deploy [rindexer](https://rindexer.xyz) -->

### Run `rindexer` anywhere docker is supported

### Prerequisites

- [just](https://github.com/casey/just)
- [docker](https://docs.docker.com/get-docker/) (if you're on a mac, [orbstack.dev](https://orbstack.dev) will make your life 100x better)

### Quickstart

- initialize (this command copies `.env.example` to `.env`)

  ```bash
  just init
  ```

- database (postgres):

  build image

  ```bash
  just build-postgres
  ```

  run container

  ```bash
  just run-postgres
  ```

- `rindexer`:

  build image

  ```bash
  just build-rindexer
  ```

  run container

  ```bash
  just run-rindexer
  ```

- profit 🎉

### deployment

you need two things:

- an environment/server/whatever capable of running docker containers (almost all providers),
- a postgres database.

#### railway

##### one click deployment

TODO: add template url

[![Deploy on Railway](https://railway.app/button.svg)]()

##### manual deployment

- create a project on [railway.app](https://railway.app?referralCode=eD4laT),
- add a postgres database and a volume to the database,
- create a new empty service,
- grab a `RAILWAY_TOKEN`, `RAILWAY_SERVICE_ID`, and `RAILWAY_PROJECT_ID` from the railway cli,
- install the railway cli (`bun add --global @railway/cli@latest`),
- login to railway (`railway login`),
- link the project you created (`railway link`),
- run the following commands:

  ```bash
  # TODO: add the commands
  ```
