# Redis Docker Image

Custom image based on alpine with s6-overlay. 

[![Github Build Status](https://img.shields.io/github/actions/workflow/status/imoize/docker-redis/build.yml?color=458837&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=build&logo=github)](https://github.com/imoize/docker-redis/actions?workflow=build)
[![GitHub](https://img.shields.io/static/v1.svg?color=3C79F5&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=imoize&message=GitHub&logo=github)](https://github.com/imoize/docker-redis)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=3C79F5&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=imoize&message=GitHub%20Package&logo=github)](https://github.com/imoize/docker-redis/pkgs/container/redis)
[![Docker Pulls](https://img.shields.io/docker/pulls/imoize/redis.svg?color=3C79F5&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/imoize/redis)

## Supported Architectures

Multi-platform available trough docker manifest. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list).

Simply pulling using `latest` tag should retrieve the correct image for your arch.

The architectures supported by this image:

| Architecture | Available |
| :----: | :----: |
| x86-64 | ✅ |
| arm64 | ✅ |

## Usage

Here are some example to help you get started creating a container, easiest way to setup is using docker-compose or use docker cli.

- **docker-compose (recommended)**

```yaml
---
version: "3.9"
services:
  redis:
    image: imoize/redis:latest
    container_name: redis
    environment:
      - PUID=1001
      - PGID=1001
      - TZ=Asia/Jakarta
      - ALLOW_EMPTY_PASSWORD=yes
    restart: always
```

- **docker cli**

```bash
docker run -d \
  --name=redis \
  -e PUID=1001 \
  -e PGID=1001 \
  -e TZ=Asia/Jakarta \
  -e ALLOW_EMPTY_PASSWORD=yes \
  --restart always \
  imoize/redis:latest
```

## Available environment variables:

| Name                      | Description                                            | Default Value |
| ------------------------- | ------------------------------------------------------ | ------------- |
| PUID                      | User UID                                               |               |
| PGID                      | Group GID                                              |               |
| TZ                        | Specify a timezone see this [list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List).       | UTC          |
| S6_VERBOSITY              | Controls the verbosity of s6-rc. See [this.](https://github.com/just-containers/s6-overlay?tab=readme-ov-file#customizing-s6-overlay-behaviour)    | 1             |
| ALLOW_EMPTY_PASSWORD      | Allow password-less access                             | no            |
| REDIS_PASSWORD            | Setting the server password on first run.              |               |
| EXTRA_FLAGS               | Add extra command-line flags to redis-server startup.  |               |

**NOTE:** The at sign (@) is not supported for REDIS_PASSWORD

## Configuration

### Environment variables

When you start the redis image, you can adjust the configuration of the instance by passing one or more environment variables either on the `docker-compose` file or on the `docker run` command line. Please note that some variables are only considered when the container is started for the first time. If you want to add a new environment variable:

- **for `docker-compose` add the variable name and value:**

```yaml
redis:
    ...
    environment:
      - PUID=1001
      - ALLOW_EMPTY_PASSWORD=yes
    ...
```

- **for manual execution add a `-e` option with each variable and value:**

```bash
  docker run -d \
  -e PUID=1001 \
  -e ALLOW_EMPTY_PASSWORD=yes \
  imoize/redis:latest
```

### EXTRA_FLAGS Usage

You can pass extra cmd via environment.

```yaml
redis:
    ...
    environment:
      - PUID=1001
      - ALLOW_EMPTY_PASSWORD=yes
      - EXTRA_FLAGS="--maxmemory 128mb --maxmemory-policy allkeys-lru"
    ...
```

### Docker Secrets Support

You can append __FILE (double underscore) to REDIS_PASSWORD. It will be REDIS_PASSWORD__FILE.

```yaml
services:
  redis:
      ...
      environment:
        - PUID=1001
        - ALLOW_EMPTY_PASSWORD=no
        - REDIS_PASSWORD__FILE="/run/secrets/redis_password"
      secrets:
        - redis_password

secrets:
  redis_password:
    external: true
      ...
```

## User / Group Identifiers

For example: `PUID=1001` and `PGID=1001`, to find yours user `id` and `gid` type `id <your_username>` in terminal.
```bash
  $ id your_username
    uid=1001(user) gid=1001(group) groups=1001(group)
```

## Tips / Info

* Shell access whilst the container is running:
```console
docker exec -it redis /bin/bash
```
* To monitor the logs of the container in realtime:
```console
docker logs -f redis
```
* Container version number:
```console
docker inspect -f '{{ index .Config.Labels "build_version" }}' redis
```
* Image version number:
```console
docker inspect -f '{{ index .Config.Labels "build_version" }}' imoize/redis:latest
```

## Upgrade this image

We recommend that you follow these steps to upgrade your container.

#### Step 1: Get the updated image

```console
docker pull imoize/redis:latest
```

or if you're using Docker Compose, update the value of the image property to
`imoize/redis:latest`.

#### Step 2: Stop currently running container

Stop the currently running container using this command.

```console
docker stop redis
```

or using Docker Compose:

```console
docker-compose stop redis
```

#### Step 3: Remove currently running container

Remove the currently running container using this command.

```console
docker rm -v redis
```

or using Docker Compose:

```console
docker-compose rm -v redis
```

#### Step 4: Run the new image

Re-create your container from the new image.

```console
docker run --name redis imoize/redis:latest
```

or using Docker Compose:

```console
docker-compose up -d redis
```

#### Step 5: Remove the old dangling images

You can also remove the old dangling images.

```console
docker image prune
```

## Contributing

We'd love for you to contribute to this container. You can submitting a [pull request](https://github.com/imoize/docker-redis/pulls) with your contribution.

## Issues

If you encountered a problem running this container, you can create an [issue](https://github.com/imoize/docker-redis/issues).
