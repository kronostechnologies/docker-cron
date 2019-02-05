FROM debian:stretch-slim
MAINTAINER sysadmin@kronostechnologies.com

ENV DEBIAN_FRONTEND=noninteractive

COPY ./bin/ /usr/bin/

RUN docker-cron setup

CMD docker-cron run
