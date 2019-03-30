#!/usr/bin/env bash

home_dir=/home/listener

mkdir -p $home_dir/log
(TZ=UTC date)>>$home_dir/log/listener.log 2>&1
python3 $home_dir/Client_Simple.py
