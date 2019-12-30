#!/usr/bin/env bash

kill $(ps -ax -o pid,comm | rofi -dmenu | awk "{ print $1 }")
