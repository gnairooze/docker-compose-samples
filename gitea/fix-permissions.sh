#!/bin/sh
chmod 700 /data/ssh
chmod 600 /data/ssh/*
exec /usr/bin/entrypoint "$@"
