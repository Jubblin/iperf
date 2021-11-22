FROM alpine:3.14.2

LABEL maintainer="Richard Worwood"

# build intial apk binary cache and install iperf
RUN apk add --no-cache iperf \
    && adduser -S iperf

USER iperf

# Expose the default iperf2 server port
EXPOSE 5001/tcp 5001/udp

# entrypoint allows you to pass your arguments to the container at runtime
# very similar to a binary you would run. For example, in the following
# docker run -it <IMAGE> --help' is like running 'iperf --help'
ENTRYPOINT ["iperf"]

# Health check floods log window quite a bit.
# If needed you can change/disable health check when starting container.
# See Docker run reference documentation for more information.
HEALTHCHECK CMD iperf -n 1 -c 127.0.0.1 || exit 1
