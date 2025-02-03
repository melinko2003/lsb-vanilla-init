# docker buildx build --build-arg LSB_BRANCH=base -t ffxi-vanilla-lsb-init:latest -f Dockerfile.init .
# syntax=docker/dockerfile:1
FROM alpine:latest AS build

ARG LSB_BRANCH=base 

ADD entrypoint.sh /opt/entrypoint.sh

RUN sed -E -i "s/base/$LSB_BRANCH/" /opt/entrypoint.sh

RUN chmod +x /opt/entrypoint.sh

FROM ubuntu:latest
COPY --from=build /opt /opt

ENV GIT_DISCOVERY_ACROSS_FILESYSTEM=1
# docker run -it -v ./lsb/ffxi:/opt/ffxi ffxi-vanilla-lsb-init:latest
CMD [ "/opt/entrypoint.sh" ]