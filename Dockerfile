FROM openjdk:8-jre-alpine

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

ENV RELDATE=2019-03-16T03_43_58Z \
    ARCHIVE=pwm-onejar-1.8.0-SNAPSHOT.jar \
    PWM_PATH=/usr/share/pwm/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget"

RUN apk add --update --no-cache $PACKAGES && \
    mkdir -p $PWM_PATH $SUPERVISOR_PATH && \
    cd $PWM_PATH && \
    wget https://www.pwm-project.org/artifacts/pwm/${RELDATE}/${ARCHIVE} && \
    rm -rf /var/cache/apk/*

COPY files/ /
WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
