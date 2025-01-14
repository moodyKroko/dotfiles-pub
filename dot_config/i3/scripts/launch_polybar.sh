#!/bin/bash

# terminal all running bar instances
killall -q polybar

# wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do
sleep 1; done

# launch bar and bar2
polybar moody &
