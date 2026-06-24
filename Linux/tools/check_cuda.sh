python - <<'PY'
import sys, torch

print("Python:", sys.version.replace("\n", " "))
print("PyTorch:", torch.__version__)
print("CUDA available:", torch.cuda.is_available())

if not torch.cuda.is_available():
    print("[FAIL] PyTorch 当前不能使用 CUDA")
    sys.exit(1)

print("CUDA version used by PyTorch:", torch.version.cuda)
print("cuDNN version:", torch.backends.cudnn.version())
print("GPU count:", torch.cuda.device_count())

for i in range(torch.cuda.device_count()):
    print(f"GPU {i}:", torch.cuda.get_device_name(i))

x = torch.randn(2048, 2048, device="cuda")
y = torch.randn(2048, 2048, device="cuda")
z = x @ y
torch.cuda.synchronize()

print("Tensor device:", z.device)
print("Result mean:", z.mean().item())
print("[OK] PyTorch CUDA works")
PY
