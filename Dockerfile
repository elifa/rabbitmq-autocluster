FROM aweber/rabbitmq-autocluster

ENV ERL_INETRC="/var/lib/rabbitmq/.inetrc"

ADD .inetrc /var/lib/rabbitmq/.inetrc
ADD rabbitmq.config /usr/lib/rabbitmq/etc/rabbitmq/rabbitmq.config

USER root

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.4/community" > /etc/apk/repositories && \
    apk add --no-cache "erlang-hipe=18.3.2-r0" && \
    rabbitmq-plugins --offline disable autocluster && \
    rm /usr/lib/rabbitmq/plugins/autocluster*

ADD plugins/* /usr/lib/rabbitmq/plugins/

RUN rabbitmq-plugins --offline enable \
    autocluster \
    rabbitmq_stomp
    
EXPOSE 61613