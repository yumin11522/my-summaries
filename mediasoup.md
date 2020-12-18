### mediasoup windows编译
- 设置VisualStudio MSBuild路径：`set MSBUILD=“C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe”`

- 设置GYP VisualStudio 版本，`set GYP_MSVS_VERSION=2019`

- 设置mediasoup-worker可执行程序路径：`set MEDIASOUP_WORKER_BIN=D:\open-sources\webrtc\mediasoup\mediasoup\worker\\out\Debug\\mediasoup-worker.exe`

- node --inspect server.js //不指定调试端口，默认9229
- node --inspect=9999 server.js //指定调试端口