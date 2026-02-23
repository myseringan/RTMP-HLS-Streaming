# RTMP → HLS Streaming Platform

**Live video streaming pipeline: Raspberry Pi camera → RTMP → Nginx → HTML5 HLS Player**

[![Raspberry Pi](https://img.shields.io/badge/Raspberry_Pi-Source-C51A4A?style=flat-square&logo=raspberrypi)](https://www.raspberrypi.com/)
[![Nginx](https://img.shields.io/badge/Nginx-RTMP/HLS-009639?style=flat-square&logo=nginx)](https://nginx.org/)
[![FFmpeg](https://img.shields.io/badge/FFmpeg-Encoder-007808?style=flat-square&logo=ffmpeg)](https://ffmpeg.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)](LICENSE)

---

## Overview

A complete live streaming system. A Raspberry Pi captures video from a USB camera or PiCam, encodes it with FFmpeg, and pushes an RTMP stream to an Nginx server. The server converts RTMP to HLS segments, which are played in any browser via an HTML5 player.

**What it does:**

* Captures video from USB camera or Raspberry Pi Camera Module
* Encodes and streams via RTMP using FFmpeg
* Converts RTMP → HLS on Nginx server with auto-cleanup
* Plays live stream in any browser with hls.js
* LED status indicator on Raspberry Pi (network connectivity)
* Deployable web player via GitHub Pages

---

## Architecture

```
┌──────────────┐     RTMP      ┌──────────────┐     HLS      ┌──────────────┐
│ Raspberry Pi │ ─────────────►│ Nginx Server │ ────────────►│   Browser    │
│              │               │              │              │              │
│ USB Camera   │  ffmpeg push  │ RTMP Module  │  .m3u8/.ts   │ hls.js       │
│ or PiCam     │               │ HLS Output   │              │ HTML5 Video  │
└──────────────┘               └──────────────┘              └──────────────┘
```

---

## Project Structure

```
RTMP-HLS-Streaming/
├── rpi/
│   ├── ffmpeg-usb.sh         # Stream from USB camera
│   ├── ffmpeg-picam.sh       # Stream from PiCam module
│   └── led_status.py         # Network status LED indicator
│
├── server/
│   ├── nginx/
│   │   └── rtmp.conf         # Nginx RTMP + HLS config
│   └── scripts/
│       └── rotate_hls.sh     # Auto-cleanup old HLS segments
│
├── web/
│   └── index.html            # HTML5 HLS player (hls.js)
│
└── README.md
```

---

## Quick Start

### 1. Server Setup

```bash
sudo apt update
sudo apt install -y nginx libnginx-mod-rtmp
sudo mkdir -p /var/www/html/stream
sudo chown -R www-data:www-data /var/www/html/stream
sudo cp server/nginx/rtmp.conf /etc/nginx/conf.d/
sudo systemctl restart nginx
```

### 2. Raspberry Pi

**USB Camera:**
```bash
bash rpi/ffmpeg-usb.sh stream1 /dev/video0
```

**PiCam Module:**
```bash
bash rpi/ffmpeg-picam.sh stream1
```

**Network LED indicator:**
```bash
python3 rpi/led_status.py
```

### 3. Watch

Open the web player or use any HLS-compatible player:
```
http://<server_ip>/stream/stream1.m3u8
```

---

## Tech Stack

| Component | Technology | Description |
|-----------|------------|-------------|
| Source | Raspberry Pi + Camera | Video capture (USB or CSI) |
| Encoder | FFmpeg | H.264 encoding, RTMP push |
| Server | Nginx + RTMP Module | RTMP ingest, HLS conversion |
| Player | HTML5 + hls.js | Browser-based live playback |
| Status | Python + GPIO | LED network indicator |

---

## Configuration

**Nginx RTMP** (`server/nginx/rtmp.conf`):
- RTMP listen port: 1935
- HLS output directory: `/var/www/html/stream/`
- HLS fragment length: configurable
- Auto-cleanup of old `.ts` segments

**FFmpeg** encoding parameters are tunable in the shell scripts (resolution, bitrate, framerate).

---

## Author

**Temur Eshmurodov** — [@myseringan](https://github.com/myseringan)

## License

MIT License — free to use and modify.
