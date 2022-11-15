FROM alpine:latest
RUN apk --update add curl openjdk8-jre-base tzdata

ARG PUID=1000
ARG PGID=1000

RUN addgroup -g $PGID -S suwayomi && adduser -u $PUID -S suwayomi -G suwayomi

USER suwayomi

COPY --chown=$PUID:$PGID /Tachidesk suwayomi/Tachidesk

RUN curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server/releases/latest | grep -o "https.*jar") -o /suwayomi/Tachidesk/tachidesk_latest.jar

EXPOSE 4567
VOLUME ["/suwayomi/.local/share/Tachidesk/"]
CMD ["/bin/sh", "/suwayomi/Tachidesk/startup.sh"]