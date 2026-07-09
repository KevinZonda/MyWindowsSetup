#!/bin/bash

CUDA_V="${1:-128}"

echo "Installing torch by cu$CUDA_V"

pip uninstall torch torchvision
pip install torch torchvision \
    --index-url "https://mirrors.nju.edu.cn/pytorch/whl/cu$CUDA_V" \
    --extra-index-url https://mirrors.nju.edu.cn/pypi/web/simple
