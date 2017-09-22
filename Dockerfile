FROM rabbitmq:3.6.11-management

ADD jwt_plugin/plugins /plugins

RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_web_mqtt rabbit_auth_backend_jwt

EXPOSE 4369 5671 5672 25672 15671 15672 15675

CMD ["rabbitmq-server"]
