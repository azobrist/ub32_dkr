#!/bin/bash
if [ $# -ne 1 ]; then
	echo "enter version"
	exit 1
fi

docker build -t avid_buildbox:v$1 .
