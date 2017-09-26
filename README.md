# docker-cron

#### Build

```Shell
docker build -t docker-cron .
```

#### Usage

###### Run cronjobs using a mounted volume at /etc/cron.d/

```Shell
docker run --rm \
-v $(pwd)/sample.cron:/etc/cron.d/sample.cron \
-it docker-cron
```

###### Create a docker image to run cronjobs

```Dockerfile
cat <<EOF > Dockerfile-example
FROM docker-cron
COPY ./sample.cron /etc/cron.d/sample.cron
EOF
```

```Shell
docker build -f Dockerfile-example -t cron-example .
docker run --rm -it cron-example
```

###### Integrate cron in another image

```Dockerfile
ADD https://github.com/kronostechnologies/docker-cron/releases/download/latest/docker-cron /usr/local/bin/docker-cron
RUN chmod +x /usr/local/bin/docker-cron && docker-cron setup

CMD [ "docker-cron run" ]
```

###### Symlink a cronjob file on container start

```Shell
$ docker run --rm \
-v $(pwd)/jobs/:/jobs/:ro \
-e CRONLINKER_ENVIRONMENT=dev \
-e CRONLINKER_SITE=docker \
-it docker-cron sh -c "docker-cron link && docker-cron run"
```
outputs
```
cronlinker: CRONLINKER_PATH: undefined variable, using default (/jobs)
cronlinker: CRONLINKER_ENVIRONMENT: defined as dev
cronlinker: CRONLINKER_SITE: defined as docker
cronlinker: CRONLINKER_FILE: defined as '/jobs/dev/docker'
cronlinker: success: linked '/jobs/dev/docker' to /etc/cron.d/jobs
Sep 26 22:13:12 1d5811c0a08a cron.info /usr/sbin/crond[28]: (CRON) INFO (running with inotify support)
```

```Shell
$ tree jobs
jobs
└── dev
    ├── docker
    └── legacy
```

