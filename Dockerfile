FROM alpine:3.14.2

LABEL maintainer="Richard Worwood"

ARG UID="1000"
ARG GID="1000"

RUN apk update && \
    apk add iperf && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /opt/iperf && \
    addgroup --g "${GID}" -S iperf && \
    adduser -h /opt/iperf -s /bin/sh -u "${UID}" -G iperf -S iperf && \
    cd /opt/iperf && \
    chown iperf:iperf -R /opt/iperf

EXPOSE 5001/udp
EXPOSE 5001/tcp


USER "iperf"
WORKDIR /opt/iperf

ENTRYPOINT [ "/usr/bin/iperf" ]
