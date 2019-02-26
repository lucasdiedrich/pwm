FROM openjdk:8-jre-alpine

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

ENV RELDATE=2019-02-07T13_56_10Z \
    ARCHIVE=pwm-onejar-1.8.0-SNAPSHOT.jar \
    MYSQL_DRIVER_VERSION=8.0.15 \
    POSTGRES_DRIVER_VERSION=42.2.5 \
    MONGODB_DRIVER_VERSION=3.9.1 \
    MARIADB_DRIVER_VERSION=2.4.0 \
    PWM_APPLICATIONPATH=/usr/share/pwm/ \
    PWM_LIBSPATH=/usr/share/pwm/libs/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget"

# Install additional packages
RUN apk add --update --no-cache $PACKAGES && \
    mkdir -p $PWM_APPLICATIONPATH $PWM_LIBSPATH $SUPERVISOR_PATH && \
    cd $PWM_APPLICATIONPATH && \
    wget https://www.pwm-project.org/artifacts/pwm/${RELDATE}/${ARCHIVE} && \
    cd $PWM_LIBSPATH && \
    wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/${MYSQL_DRIVER_VERSION}/mysql-connector-java-${MYSQL_DRIVER_VERSION}.jar && \
    wget https://jdbc.postgresql.org/download/postgresql-${POSTGRES_DRIVER_VERSION}.jar && \
    wget https://oss.sonatype.org/content/repositories/releases/org/mongodb/mongo-java-driver/${MONGODB_DRIVER_VERSION}/mongo-java-driver-${MONGODB_DRIVER_VERSION}.jar && \
    wget https://downloads.mariadb.com/Connectors/java/connector-java-${MARIADB_DRIVER_VERSION}/mariadb-java-client-${MARIADB_DRIVER_VERSION}.jar && \
    rm -rf /var/cache/apk/*

COPY files/ /
WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
