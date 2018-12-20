#!/bin/bash
set -e
set -o pipefail

MLP_HOST_OUTPUT_DIR=`pwd`/output
sudo mkdir -p $MLP_HOST_OUTPUT_DIR

sudo docker build . -f Dockerfile.rocm -t rocm-image-classification
sudo docker run -v /data:/data \
-v $MLP_HOST_OUTPUT_DIR:/output -v /proc:/host_proc --device=/dev/kfd/ --device=/dev/dri/ \
-t rocm-image-classification:latest /root/run_helper_8xMI.sh 2>&1 | sudo tee output.txt
