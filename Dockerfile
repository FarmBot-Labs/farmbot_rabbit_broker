FROM rabbitmq:3.6.11-management

COPY ./rabbitmq_auth_backend_jwt.ez /plugins/rabbitmq_auth_backend_jwt.ez
COPY ./base64url-0.0.1.ez  /plugins/base64url-0.0.1.ez
COPY ./jwt-0.1.3.ez  /plugins/jwt-0.1.3.ez
COPY ./jsx-2.8.2.ez  /plugins/jsx-2.8.2.ez

RUN rabbitmq-plugins enable --offline rabbitmq_auth_backend_jwt

EXPOSE 4369 5671 5672 25672 15671 15672

CMD ["rabbitmq-server"]
