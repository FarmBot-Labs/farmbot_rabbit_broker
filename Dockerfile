FROM rabbitmq:3.6.11-management

COPY ./auth_backend_http-3.6.8.ez /plugins/rabbitmq_auth_backend_http-3.6.8.ez
RUN rabbitmq-plugins enable --offline rabbitmq_auth_backend_http

EXPOSE 4369 5671 5672 25672 15671 15672

CMD ["rabbitmq-server"]
