#!/bin/sh
echo "💽 $(df -h | awk '/\/dev\/sdd4/ {print $4}')"
