#!/usr/bin/env bash

mkdir -p ~/log
(TZ=UTC date)>>~/log/listener.log 2>&1
python3 ~/Client_Simple.py
