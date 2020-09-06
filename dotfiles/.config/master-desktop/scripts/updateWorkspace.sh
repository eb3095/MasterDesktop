#!/bin/bash

xdotool key $1
echo "PING" | netcat -c 127.0.0.1 62001 &
echo "PING" | netcat -c 127.0.0.1 62002 &
echo "PING" | netcat -c 127.0.0.1 62003 &
echo "PING" | netcat -c 127.0.0.1 62004 &
echo "PING" | netcat -c 127.0.0.1 62005 &
echo "PING" | netcat -c 127.0.0.1 62006 &
echo "PING" | netcat -c 127.0.0.1 62007 &
echo "PING" | netcat -c 127.0.0.1 62008 &
echo "PING" | netcat -c 127.0.0.1 62009 &
echo "PING" | netcat -c 127.0.0.1 62010 &
echo "PING" | netcat -c 127.0.0.1 62011 &
echo "PING" | netcat -c 127.0.0.1 62012 &
