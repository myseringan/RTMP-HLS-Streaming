#!/bin/bash
# Usage: ./ffmpeg-usb.sh <stream_key> <device>
STREAM_KEY=$1
DEVICE=$2
ffmpeg -f v4l2 -i $DEVICE -c:v libx264 -f flv rtmp://<server_ip>/live/$STREAM_KEY
