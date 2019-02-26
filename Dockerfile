FROM openjdk:8-jre-alpine

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

ENV RELDATE=2019-02-07T13_56_10Z \
    ARCHIVE=pwm-onejar-1.8.0-SNAPSHOT.jar \
    MYSQL_DRIVER_VERSION=8.0.15 \
    POSTGRES_DRIVER_VERSION=42.2.5 \
    MONGODB_DRIVER_VERSION=3.9.1 \
    MARIADB_DRIVER_VERSION=2.4.0 \
    PWM_APPLICATIONPATH=/usr/share/pwm/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget"

# Install additional packages
RUN apk add --update --no-cache $PACKAGES && \
    mkdir -p $PWM_APPLICATIONPATH $SUPERVISOR_PATH && \
    cd $PWM_APPLICATIONPATH && \
    wget https://www.pwm-project.org/artifacts/pwm/${RELDATE}/${ARCHIVE} && \
    rm -rf /var/cache/apk/*

COPY files/ /
WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
