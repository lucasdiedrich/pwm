#!/bin/sh

java ${JAVA_OPTS} -jar /usr/share/pwm/pwm-onejar*.jar -applicationPath /config > /var/log/start-pwm.log
