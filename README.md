# docker-cron

#### Build

```Shell
docker build -t docker-cron .
```

#### Usage

Run cronjobs using a mounted volume at /etc/cron.d/

```Shell
docker run --rm \
-v $(pwd)/sample.cron:/etc/cron.d/sample.cron \
-it docker-cron
```

Create a docker image to run cronjobs

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



#### Debug

```Shell
docker run --rm -it docker-cron /bin/bash
```
