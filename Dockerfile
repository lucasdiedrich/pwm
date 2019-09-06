FROM openjdk:8-jre-alpine

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

ENV RELDATE=2019-08-05T00_11_43Z \
    ARCHIVE=pwm-onejar-2.0.0-SNAPSHOT.jar \
    PWM_PATH=/usr/share/pwm/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget"

RUN apk add --update --no-cache $PACKAGES && \
    mkdir -p $PWM_PATH $SUPERVISOR_PATH && \
    cd $PWM_PATH && \
    wget https://www.pwm-project.org/artifacts/pwm/build/${RELDATE}/${ARCHIVE} && \
    rm -rf /var/cache/apk/*

COPY files/ /
WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
