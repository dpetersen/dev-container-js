# dev-container-js

[![Docker Hub](https://img.shields.io/badge/docker-ready-blue.svg)](https://registry.hub.docker.com/u/dpetersen/dev-container-js/)
[![](https://badge.imagelayers.io/dpetersen/dev-container-js.svg)](https://imagelayers.io/?images=dpetersen%2Fdev-container-js:latest,dpetersen%2Fdev-container-base:latest 'Get your own badge on imagelayers.io')

A container, based on [dev-container-base](https://github.com/dpetersen/dev-container-base), for developing Javascript applications.

## Usage

The base container starts an SSH server, so you can read more about that in [its README](https://github.com/dpetersen/dev-container-base). This container assumes that your `GOPATH` will be `/home/dev/gopath`. You'll probably want to volume mount a directory for this, so your changes are easy to get to if you shut down the container.

I usually start it with something like (assuming `$GOPATH` is `~/gopath`):

```bash
docker run -d \
  -e AUTHORIZED_GH_USERS="dpetersen" \
  -p 0.0.0.0:31981:22 \
  -v $(pwd):/home/dev/app \
  dpetersen/dev-container-js:latest
```

It has a couple of bootstrapping scripts in the home directory. One is for installing angular-cli, since I can't remember the command. Second starts xvfb and should be run in the background if you are running tests that require Chromedriver (which is the reason this image is so enormous).

I'd advise you to set up an SSH alias as [explained here](https://github.com/dpetersen/dev-container-base#connecting).

## Development

Helpful reminders on how to build, tag, and push this can be found in [the Development section](https://github.com/dpetersen/dev-container-base#development) of the other image.
