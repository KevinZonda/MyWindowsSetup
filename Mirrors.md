# Mirror Settings for Mainland China

> Generally, if you are in Suzhou, Jiangsu, China or Shanghai, China, I suggest
> use **NJU** or **Aliyun's mirrors**, instead of USTC, SJTU or TUNA, for best perofrmance.
> PKU's mirror also has rich throughout bandwidth.

**Python/PyPI:**

```sh
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
pip config set global.index-url https://mirrors.nju.edu.cn/pypi/web/simple
pip config set global.index-url https://mirrors.pku.edu.cn/pypi/web/simple
```

**Go:**

```pwsh
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

**NPM:**

```pwsh
pnpm config set registry "https://registry.npmmirror.com"
npm config set registry "https://registry.npmmirror.com"
```

**PyTorch:**

```sh
pip3 install torch torchvision \
    --index-url https://mirrors.nju.edu.cn/pytorch/whl/cu126 \
    --extra-index-url https://mirrors.nju.edu.cn/pypi/web/simple
```

**MSYS:**
```sh
sed -i "s#https\?://mirror.msys2.org/#https://mirror.nju.edu.cn/msys2/#g" /etc/pacman.d/mirrorlist*
```

**Ubuntu DEB:**
- <https://help.mirror.nju.edu.cn/ubuntu/?mirror=NJU>

**LaTeX/CTAN:**
- <https://mirror.nju.edu.cn/CTAN/systems/texlive/>


**Docker** `/etc/docker/daemon.json`:

> You may want to use Aliyun ACR or similar product.

```json
{
  "registry-mirrors": ["https://docker.1ms.run"]
}
```

FlashAttn2

```sh
VERSION=2.8.3.post1 # or 2.7.4.post1
TORCH_VERSION=2.8 # or 2.6
ABI=TRUE # in ['TRUE', 'FALSE]
PY_VERSION=312

echo https://github.com/Dao-AILab/flash-attention/releases/download/v${VERSION}/flash_attn-${VERSION}+cu12torch${TORCH_VERSION}cxx11abi${ABI}-cp${PY_VERSION}-cp${PY_VERSION}-linux_x86_64.whl
```

e.g., 2.8.3.post1 (cuda12 + python312 + torch2.8): <https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3.post1/flash_attn-2.8.3.post1+cu12torch2.8cxx11abiTRUE-cp312-cp312-linux_x86_64.whl>