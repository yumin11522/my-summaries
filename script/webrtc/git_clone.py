# -*- coding: utf-8 -*-
from genericpath import exists
import os
import shutil

projects = [
r"https://chromium.googlesource.com/external/webrtc",
r"https://chromium.googlesource.com/chromium/src/base",
r"https://chromium.googlesource.com/chromium/src/build",
r"https://chromium.googlesource.com/chromium/src/buildtools",
r"https://chromium.googlesource.com/external/github.com/gradle/gradle",
r"https://chromium.googlesource.com/chromium/src/ios",
r"https://chromium.googlesource.com/chromium/src/testing",
r"https://chromium.googlesource.com/chromium/src/third_party",
r"https://chromium.googlesource.com/chromium/llvm-project/cfe/tools/clang-format",
r"https://chromium.googlesource.com/chromium/llvm-project/libcxx",
r"https://chromium.googlesource.com/chromium/llvm-project/libcxxabi",
r"https://chromium.googlesource.com/external/llvm.org/libunwind",
r"https://chromium.googlesource.com/android_ndk",
r"https://chromium.googlesource.com/android_tools",
r"https://chromium.googlesource.com/external/github.com/google/auto",
r"https://chromium.googlesource.com/catapult",
r"https://chromium.googlesource.com/external/github.com/google/compact_enc_det",
r"https://chromium.googlesource.com/external/colorama",
r"https://chromium.googlesource.com/chromium/tools/depot_tools",
r"https://chromium.googlesource.com/chromium/third_party/errorprone",
r"https://chromium.googlesource.com/chromium/third_party/ffmpeg",
r"https://chromium.googlesource.com/chromium/deps/findbugs",
r"https://chromium.googlesource.com/chromium/src/freetype2",
r"https://chromium.googlesource.com/external/github.com/harfbuzz/harfbuzz",
r"https://chromium.googlesource.com/external/github.com/google/gtest-parallel",
r"https://chromium.googlesource.com/external/github.com/google/googletest",
r"https://chromium.googlesource.com/chromium/deps/icu",
r"https://chromium.googlesource.com/external/jsr-305",
r"https://chromium.googlesource.com/external/github.com/open-source-parsers/jsoncpp",
r"https://chromium.googlesource.com/external/junit",
r"https://chromium.googlesource.com/chromium/llvm-project/compiler-rt/lib/fuzzer",
r"https://chromium.googlesource.com/chromium/deps/libjpeg_turbo",
r"https://chromium.googlesource.com/chromium/deps/libsrtp",
r"https://chromium.googlesource.com/webm/libvpx",
r"https://chromium.googlesource.com/libyuv/libyuv",
r"https://chromium.googlesource.com/linux-syscall-support",
r"https://chromium.googlesource.com/external/mockito/mockito",
r"https://chromium.googlesource.com/chromium/deps/nasm",
r"https://chromium.googlesource.com/external/github.com/cisco/openh264",
r"https://chromium.googlesource.com/external/github.com/kennethreitz/requests",
r"https://chromium.googlesource.com/external/robolectric",
r"https://chromium.googlesource.com/chromium/third_party/ub-uiautomator",
r"https://chromium.googlesource.com/external/github.com/sctplab/usrsctp",
r"https://chromium.googlesource.com/chromium/deps/yasm/binaries",
r"https://chromium.googlesource.com/chromium/deps/yasm/patched-yasm",
r"https://chromium.googlesource.com/chromium/src/tools",
r"https://chromium.googlesource.com/infra/luci/client-py",
r"https://boringssl.googlesource.com/boringssl"]

root = os.getcwd()
for pro in projects:
    dir_name = pro.split("/")[-1]
    print(dir_name)
    if os.path.exists(dir_name) and os.path.isdir(dir_name):
        os.chdir(root + r"/" + dir_name)
        succ = 0 # os.system("git pull")
        if succ != 0:
            print("pull project:%s failed, exitCode:%s" % (pro,succ))
            break
        else:
            if pro.find('https://chromium.googlesource.com') >= 0 or pro.find('https://boringssl.googlesource.com') >= 0:
                git_path = pro.replace(r'https://chromium.googlesource.com', r'http://git.rdapp.com/numax/chromiumsrc')
                git_path = git_path.replace(r'https://boringssl.googlesource.com', r'http://git.rdapp.com/numax/chromiumsrc')
                print("commit to private git repository " + git_path + r".git")
                succ = os.system(r"git remote set-url origin " + git_path + r".git")
                if succ == 0:
                    succ = os.system(r"git push")
                    if succ != 0:
                        print("*****************error git push to git*******************")
                        break
                else:
                    print("*****************error change git url path*******************")
                    break

        os.chdir(root)
    else:
        succ = os.system("git clone " + pro + r".git")
        if succ != 0:
            print("git clone project:%s failed, exitCode:%s" % (pro,succ))
		
print("successfully! build nms finished!!")
