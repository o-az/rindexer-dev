<!-- [![Deploy on Railway](https://railway.app/button.svg)]() -->

<!-- #### [railway.app](https://railway.app?referralCode=eD4laT) template to deploy [rindexer](https://rindexer.xyz) -->

### Run `rindexer` anywhere docker is supported

#### Prerequisites

- [just](https://github.com/casey/just)
- [docker](https://docs.docker.com/get-docker/) (if you're on a mac, [orbstack.dev](https://orbstack.dev) will make your life 100x better)

Quickstart:

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
