This is currently a shameless fork of https://github.com/docker-library/rabbitmq/tree/master/3.6/debian


# running
```bash
export DOCKER_NAME localrabbit
docker run -d --hostname $DOCKER_NAME --name $DOCKER_NAME rabbitmq:3
```

# stopping
```bash
docker stop $DOCKER_NAME
```


# shell
```bash
docker exec -it $DOCKER_NAME
```

# logs
```bash
docker logs $DOCKER_NAME
```
