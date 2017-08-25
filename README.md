# Work In Progress

Replacing the current MQTT broker with RabbitMQ.

# Table of Contents

 * `Dockerfile`: The important thing.
 * `utils/`: A collection of Ruby scripts for debugging and testing.

# Build

```

sudo docker build -t some-rabbit .

```

# Run (Fish Shell Users)

```

sudo docker run                       \
  -p 15672:15672                      \
  -p 5672:5672                        \
  -p 3002:15675                       \
  -p 8883:8883                        \
  -p 1883:1883                        \
  --hostname some-rabbit              \
  --name some-rabbit                  \
  -v (pwd)/conf:/etc/rabbitmq         \
  -v (pwd)/rabbitmq:/var/lib/rabbitmq \
  some-rabbit

```

# Teardown

```
sudo docker rm some-rabbit
```

# Debug (Bash)

```
sudo docker exec -i -t some-rabbit /bin/bash
```

# TODO (By Priority):

 * [Link configuration file to a volume or something?](https://stackoverflow.com/a/42003732/1064917). See: [example conf](https://github.com/rabbitmq/rabbitmq-server/blob/stable/docs/rabbitmq.config.example). Stored in `/etc/rabbitmq/rabbitmq.config` right now.
 * [rabbitmq_auth_backend_http](https://www.rabbitmq.com/community-plugins.html#auth)
 * Update `default_user_permissions` in conf
 * Delete `guest` user accounts
 * [MQTT](https://www.rabbitmq.com/mqtt.html)
 * [TLS/SSL](http://www.rabbitmq.com/ssl.html)
   * Integrate an endpoint for this onto the [API](https://github.com/FarmBot/Farmbot-Web-App)
