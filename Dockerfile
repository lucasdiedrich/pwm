FROM openjdk:11-jre-slim

LABEL maintainer="Lucas G. Diedrich <lucas.diedrich@gmail.com>"

COPY files/ /

ENV RELDATE=v2_0_3 \
    ARCHIVE=pwm-onejar-2.0.3.jar \
    PWM_PATH=/usr/share/pwm/ \
    SUPERVISOR_PATH=/run/supervisord \
    PACKAGES="supervisor wget" \
    JAVA_OPTS="-server -Xmx3g -Xms3g -Xlog:gc:file=/config/logs/gc.log:time,uptime,level,tags:filecount=10,filesize=10M"

RUN apt update; apt install $PACKAGES -y && \
    mkdir -p $PWM_PATH $SUPERVISOR_PATH && \
    cd $PWM_PATH && \
    chmod +x /usr/bin/start-pwm.sh && \
    wget https://github.com/pwm-project/pwm/releases/download/${RELDATE}/${ARCHIVE} && \
    rm -rf /var/cache/apk/*

WORKDIR /config
VOLUME [ "/config" ]

EXPOSE 8443
CMD ["/usr/bin/supervisord", "--nodaemon", "-c", "/etc/supervisord.conf"]
