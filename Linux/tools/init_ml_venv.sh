#!/bin/bash

CUDA_V="${1:-128}"

if [ ! -d "venv" ]; then
    python -m venv venv
fi

source venv/bin/activate

pip install torch torchvision \
    --index-url "https://mirrors.nju.edu.cn/pytorch/whl/cu$CUDA_V"

pip install tqdm
pip install numpy pandas
pip install matplotlib seaborn pillow
pip install opencv-python scipy scikit-learn scikit-image
# pip install transformers diffusers
