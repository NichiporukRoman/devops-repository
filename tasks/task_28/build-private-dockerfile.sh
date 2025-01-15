#!/bin/bash
yc storage s3api get-object --bucket private-task-28 --key index.html ./index.html
docker build . -t priv