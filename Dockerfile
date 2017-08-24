FROM debian:jessie-slim
MAINTAINER sysadmin@kronostechnologies.com

ENV DEBIAN_FRONTEND=noninteractive

# Install
RUN sed -i "s/jessie main/jessie main contrib non-free/" /etc/apt/sources.list \
&& echo "deb http://deb.debian.org/debian/ experimental main" > /etc/apt/sources.list.d/experimental.list

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
cronie \
busybox-syslogd \
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /etc/cron.*/*

# cronie
# - do not send emails (-m off)
# - redirect stdout to syslog (-s)
RUN sed -i 's|DAEMON_ARGS=""|DAEMON_ARGS="-m off -s"|' /etc/default/cronie

# busybox-syslogd
# - do not save log to file (-O /dev/null)
RUN sed -i 's|SYSLOG_OPTS="-C128"|SYSLOG_OPTS="-C128 -O /dev/null"|' /etc/default/busybox-syslogd

RUN touch /etc/default/locale

COPY ./bin/ /usr/bin/
CMD run

