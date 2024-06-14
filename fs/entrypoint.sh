#!/bin/sh
set -e

gomplate --file /etc/crontab.tpl --out /etc/crontab

exec supercronic -passthrough-logs /etc/crontab
