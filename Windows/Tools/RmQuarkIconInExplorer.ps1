$quark = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{6FCBEFA0-DD11-4EB0-A87D-46DAF26BF2B7}"
if (Test-Path $quark) {
    Remove-Item -Path $quark -Recurse -Force
    Write-Output "夸克盘符已删除"
} else {
    Write-Output "未找到指定盘符，请尝试方案一手动查找"
}
