#!/bin/bash
# Usage: ./ffmpeg-picam.sh <stream_key>
STREAM_KEY=$1
ffmpeg -f video4linux2 -i /dev/video0 -c:v libx264 -f flv rtmp://<server_ip>/live/$STREAM_KEY
