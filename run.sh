#!/bin/sh

docker build -t solutions-enabler9 . && docker run -p 9191:8080 solutions-enabler9