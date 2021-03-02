FROM openjdk:15-jdk-slim-buster

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

COPY files/ /

ENV RELDATE=2021-02-26T00_15_08Z \
    ARCHIVE=pwm-onejar-2.0.0-SNAPSHOT.jar \
    PWM_PATH=/usr/share/pwm/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget" \
    JAVA_OPTS="-server -Xmx1g -Xms1g"

RUN apk add --update --no-cache $PACKAGES && \
    mkdir -p $PWM_PATH $SUPERVISOR_PATH && \
    cd $PWM_PATH && \
    chmod +x /usr/bin/start-pwm.sh && \
    wget https://www.pwm-project.org/artifacts/pwm/build/${RELDATE}/${ARCHIVE} && \
    rm -rf /var/cache/apk/*

WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
