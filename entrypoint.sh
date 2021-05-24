#!/bin/sh

quit() {
    /usr/bin/tmux kill-session -t rt
}

trap 'quit' SIGINT SIGSTOP SIGTERM SIGKILL

#exec su-exec $PUID:$PGID 
/usr/bin/tmux new-session -s rt -d /usr/bin/rtorrent

while :; do sleep 1; done