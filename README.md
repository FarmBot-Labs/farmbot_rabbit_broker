# Work In Progress

Replacing the current MQTT broker with RabbitMQ.

# Running

```
sudo docker run        \
  -p 15672:15672       \
  --hostname my-rabbit \
  --name some-rabbit   \
  rabbitmq:3.6.11-management
```

# TODO:

 * [MQTT](https://www.rabbitmq.com/mqtt.html)
 * [TLS/SSL](http://www.rabbitmq.com/ssl.html)
 * [rabbitmq_auth_backend_http](https://www.rabbitmq.com/community-plugins.html#auth)
   * Integrate an endpoint for this onto the [API](https://github.com/FarmBot/Farmbot-Web-App)
