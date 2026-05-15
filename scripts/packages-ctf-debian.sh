#!/usr/bin/env bash
set -euo pipefail

sudo apt update

sudo apt install -y \
    nmap \
    netcat-openbsd \
    socat \
    gobuster \
    ffuf \
    sqlmap \
    john \
    binwalk \
    exiftool \
    python3 \
    python3-pip \
    python3-venv \
    pipx \
    gdb \
    strace \
    ltrace \
    file \
    radare2 \
    tcpdump \
    whois \
    dnsutils \
    wordlists

