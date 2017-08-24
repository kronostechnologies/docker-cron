# docker-cron

#### Build

`docker build -t docker-cron .`

#### Usage

Run cronjobs using a mounted volume at /etc/cron.d/

```
docker run --rm \
-v $(pwd)/sample.cron:/etc/cron.d/sample.cron \
-it docker-cron
```

Create docker image to run cronjobs

```
cat <<EOF > Dockerfile-example
FROM docker-cron
COPY ./sample.cron /etc/cron.d/sample.cron
EOF

docker build -f Dockerfile-example -t cron-example .
docker run --rm -it cron-example
```



#### Debug

```
docker run --rm -it docker-cron /bin/bash
```
