#!/bin/bash

if [ $# -eq 0 ]; then
  gpu_id=0
else
  gpu_id=$1
fi

set -x
set -e

export PYTHONUNBUFFERED="True"

LOG="experiments/logs/rcnn_caffenet_ho_pfc_ip0_s.txt.`date +'%Y-%m-%d_%H-%M-%S'`"
exec &> >(tee -a "$LOG")
echo Logging output to "$LOG"

time ./fast-rcnn/tools/train_net.py --gpu $gpu_id \
  --solver ./models/rcnn_caffenet_ho_pfc_s/solver_ip.prototxt \
  --weights ./data/imagenet_models/CaffeNet.v2.ho.caffemodel \
  --imdb hico_det_train2015 \
  --cfg ./experiments/cfgs/rcnn_ho_ip0_s.yml \
  --iters 150000
