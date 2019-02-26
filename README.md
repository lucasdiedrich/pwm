# pwm
Lighteweight and updated PWM Password Manager container. This container uses the onejar version of the PWM Project. 
Any questions about the PWM Project should be search [here](https://github.com/pwm-project/pwm).

## How to use

```bash
docker run --name pwm \
           -p 8443:8443 \
           -v /etc/localtime:/etc/localtime \
           -v ./config:/config \
           -d lucasdiedrich/pwm
```

## Special Volumes

|  Volume  | Info |
|:------:|:-------:|
| /config  | All config files used by PWM|
| /etc/localtime  | To set container clock as the host clock |

## LIBS Version

These are the version of the package used by the container.

|  NAME  | Info | 
|:------:|:-------:|
|   PWM Version  | pwm-onejar-1.8.0-SNAPSHOT.jar |
|   RELEASE_DATE |  2019-02-07T13_56_10Z | 
|   MYSQL_DRIVER_VERSION  | 8.0.15 | 
|   POSTGRES_DRIVER_VERSION | 42.2.5 |
|   MONGODB_DRIVER_VERSION  | 3.9.1  |
|   MARIADB_DRIVER_VERSION  | 2.4.0 | 

## References

This project contains part of code taken or similar from [fjudith container Dockerfile](https://hub.docker.com/r/fjudith/pwm/dockerfile).

## License

MIT © [Lucas Diedrich](https://github.com/lucasdiedrich)
