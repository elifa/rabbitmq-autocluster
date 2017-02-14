FROM aweber/rabbitmq-autocluster

ENV ERL_INETRC="/var/lib/rabbitmq/.inetrc"

ADD .inetrc /var/lib/rabbitmq/.inetrc

RUN rabbitmq-plugins --offline disable autocluster && \
    rm /usr/lib/rabbitmq/plugins/autocluster*

ADD plugins/* /usr/lib/rabbitmq/plugins/

RUN rabbitmq-plugins --offline enable \
    autocluster \
    rabbitmq_stomp
    
EXPOSE 61613