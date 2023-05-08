git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

set DEPOT_TOOLS=

fetch --nohooks webrtc

set https_proxy=http://127.0.0.1:10809
set http_proxy=http://127.0.0.1:10809
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
gclient sync -D
cd src
Windows: gn gen out/Default --args="use_custom_libcxx=false use_custom_libcxx_for_host=false treat_warnings_as_errors=false rtc_use_h264=true ffmpeg_branding=\"Chrome\""
Linux: gn gen out/Default --args="treat_warnings_as_errors=false"
ninja -C out/Default webrtc

## 打开浏览器调试日志
	浏览器命令：chrome.exe --enable-logging --v=1 --vmodule=*/webrtc/*=1
	日志路径：  C:\Users\xiongqimin\AppData\Local\Google\Chrome\User Data