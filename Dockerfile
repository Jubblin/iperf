FROM alpine:3.14.2

LABEL maintainer="Richard Worwood"

ARG UID="1000"
ARG GID="1000"

RUN apk add  --no-cache iperf && \
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

# Health check floods log window quite a bit.
# If needed you can change/disable health check when starting container.
# See Docker run reference documentation for more information.
HEALTHCHECK CMD iperf -n 1 -c 127.0.0.1 || exit 1