FROM alpine:latest
RUN apk --update add curl openjdk8-jre-base tzdata

ARG UNAME=root
ARG PUID=1000
ARG PGID=1000

RUN groupadd -g $PUID -o $UNAME
RUN useradd -m -u $PUID -g $PGID -o -s /bin/bash $UNAME
USER $UNAME
COPY --chown=$PUID:$PGID /Tachidesk $UNAME/Tachidesk

RUN curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server/releases/latest | grep -o "https.*jar") -o /$UNAME/Tachidesk/tachidesk_latest.jar

EXPOSE 4567
VOLUME ["/$UNAME/.local/share/Tachidesk/"]
CMD ["/bin/sh", "/$UNAME/Tachidesk/startup.sh"]