# lsb-vanilla-init
All in one Land Sand Boat Init for creating the Environment.

# Build
Build The Container
```bash
$ docker buildx build --build-arg LSB_BRANCH=base -t lsb-vanilla-init:latest -f Dockerfile.init .
```
Use the Container from CLI
```bash
$ docker run -it -v ./lsb/ffxi:/opt/ffxi ffxi-vanilla-lsb-init:latest
```
Use the Container in compose.yml
```yaml
--- 
version: '3.1'

services:

  # Grab all the Resources:
  init:
    image: ghcr.io/melinko2003/lsb-vanilla-init:latest
    restart: "no"
    volumes:
      - ./lsb/ffxi:/opt/ffxi
```
