FROM alpine

LABEL version="1.0"

ARG PUID=1000
ARG PGID=1000
ARG RTORRENT_PORT=51745
ARG RTORRENT_DHT_PORT=51750
ARG RTORRENT_SCGI_PORT=5000

ENV PUID=$PUID PGID=$PGID

RUN addgroup --gid $PGID rtorrent && \
    adduser --system --shell /bin/ash --home /home/rtorrent --uid $PUID --ingroup rtorrent rtorrent && \
    apk add --no-cache  rtorrent \
                        ts \
                        tmux && \
    mkdir /session && \
    mkdir /downloads && \
    mkdir /torrents && \
    mkdir /logs && \
    chown -R rtorrent:rtorrent /session /downloads /torrents /logs /home/rtorrent

COPY --chown=rtorrent:rtorrent entrypoint.sh /

VOLUME /session /downloads /torrents /logs /home/rtorrent

EXPOSE $RTORRENT_SCGI_PORT $RTORRENT_DHT_PORT $RTORRENT_DHT_PORT/udp $RTORRENT_PORT

USER rtorrent

ENTRYPOINT ["/entrypoint.sh"]