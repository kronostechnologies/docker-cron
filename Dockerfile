FROM debian:buster-slim
MAINTAINER na-qc@equisoft.com

ENV DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/main$/main contrib non-free/g' /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian/ experimental main" > /etc/apt/sources.list.d/experimental.list && \
    apt update && apt install -y apt-transport-https lsb-release ca-certificates && \
    apt install -y --no-install-recommends busybox-syslogd cronie && apt clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* && \
    sed -i 's|SYSLOG_OPTS="-C128"|SYSLOG_OPTS="-C128 -O /dev/null"|' /etc/default/busybox-syslogd && \
    touch /etc/default/locale
COPY ./bin/ /usr/bin/

RUN docker-cron setup

CMD docker-cron run
