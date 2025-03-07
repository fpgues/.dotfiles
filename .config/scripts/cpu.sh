#!/bin/bash

#awk -v CONVFMT='%.2f' '/cpu MHz/ {print $4 " MHz"}' /proc/cpuinfo | head -n 1


awk -v CONVFMT='%.2f' '/cpu MHz/ {print $4/1000 "GHz"}' /proc/cpuinfo | head -n 1
