FROM rabbitmq:3.6.11-management
RUN apt-get update && apt-get install -y \
    --no-install-recommends \
    curl;
RUN curl -O https://bintray.com/rabbitmq/community-plugins/download_file?file_path=rabbitmq_auth_backend_http-3.6.8.ez -o /plugins/rabbitmq_auth_backend_http-3.6.8.ez; echo "whoop";
RUN rabbitmq-plugins enable --offline rabbitmq_management
EXPOSE 4369 5671 5672 25672 15671 15672

CMD ["rabbitmq-server"]
