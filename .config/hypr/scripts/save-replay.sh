#!/bin/sh -e

notify-send -t 1500 -u low -- "GPU Screen Recorder" "Replay saved" && sleep 0.5 && killall -SIGUSR1 gpu-screen-recorder
