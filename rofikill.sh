#!/usr/bin/env bash

kill $(ps -ax -o pid,comm | rofi -dmenu -p "KILL" | awk "{ print $1 }")
