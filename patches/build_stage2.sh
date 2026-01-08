#!/bin/bash

# This script was originally auto-generated from llvm-toolchain/llvm_android/build.py
# I've made some modifications to enable static compilation using Zig
# Statically compile the llvm-toolchain using Zig and musl libc on a Linux-aarch64 host
# Set the CMAKE_CROSSCOMPILING=TRUE, when compiling on Linux-x86 host
# In fact, when statically compiling, you can remove the runtimes

TOOLCHAIN=$HOME/opt/zig-as-llvm

cmake -G Ninja \
    -DCMAKE_C_COMPILER=$TOOLCHAIN/bin/cc \
    -DCMAKE_CXX_COMPILER=$TOOLCHAIN/bin/c++ \
    -DCMAKE_ASM_COMPILER=$TOOLCHAIN/bin/cc \
    -DCMAKE_LINKER=$TOOLCHAIN/bin/ld \
    -DCMAKE_OBJCOPY=$TOOLCHAIN/bin/objcopy \
    -DCMAKE_AR=$TOOLCHAIN/bin/ar \
    -DCMAKE_RANLIB=$TOOLCHAIN/bin/ranlib \
    -DCMAKE_STRIP=$TOOLCHAIN/bin/strip \
    -DCMAKE_C_FLAGS='-static -fPIC -Wno-unused-command-line-argument -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    -DCMAKE_CXX_FLAGS='-static -fPIC -Wno-unused-command-line-argument -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    -DCMAKE_EXE_LINKER_FLAGS='-static -fuse-ld=lld -Wl,--hash-style=both' \
    -DLLVM_TARGETS_TO_BUILD='AArch64;ARM;BPF;RISCV;WebAssembly;X86' \
    -DLLVM_ENABLE_PROJECTS='bolt;clang;clang-tools-extra;lld;lldb;polly' \
    -DCMAKE_INSTALL_PREFIX=$HOME/proj/llvm-toolchain/out/stage2-install \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DCMAKE_BUILD_TYPE=MinSizeRel \
    -DCMAKE_SYSTEM_NAME=Linux \
    -DCMAKE_CROSSCOMPILING=FALSE \
    -DCMAKE_LINK_DEPENDS_USE_LINKER=FALSE \
    -DLLVM_BUILTIN_TARGETS=aarch64-unknown-linux-musl \
    -DLLVM_DEFAULT_TARGET_TRIPLE=aarch64-unknown-linux-musl \
    -DCLANG_DEFAULT_LINKER=lld \
    -DCLANG_DEFAULT_OBJCOPY=llvm-objcopy \
    -DLLVM_ENABLE_ZLIB=FORCE_ON \
    -DLLVM_ENABLE_ZSTD=FORCE_ON \
    -DLLVM_USE_STATIC_ZSTD=ON \
    -DCLANG_ENABLE_ARCMT=OFF \
    -DLIBCLANG_BUILD_STATIC=ON \
    -DCMAKE_SKIP_INSTALL_RPATH=TRUE \
    -DLLVM_BUILD_STATIC=ON \
    -DLLVM_BUILD_LLVM_DYLIB=OFF \
    -DLLVM_LINK_LLVM_DYLIB=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DLLDB_BUILD_SHARED=OFF \
    -DLLVM_INCLUDE_BENCHMARKS=OFF \
    -DLLVM_BUILD_BENCHMARKS=OFF \
    -DLLVM_INCLUDE_EXAMPLES=OFF \
    -DLLVM_BUILD_EXAMPLES=OFF \
    -DLLVM_BUILD_TESTS=OFF \
    -DLLVM_BUILD_TOOLS=ON \
    -DLLVM_INCLUDE_TESTS=OFF \
    -DCLANG_INCLUDE_TESTS=OFF \
    -DCLANG_BUILD_TESTS=OFF \
    -DLLVM_TOOL_C_TEST_BUILD=OFF \
    -DCLANG_TOOL_CLANG_IMPORT_TEST_BUILD=OFF \
    -DCLANG_TOOL_APINOTES_TEST_BUILD=OFF \
    -DCLANG_TOOL_ARCMT_TEST_BUILD=OFF \
    -DCLANG_TOOL_C_ARCMT_TEST_BUILD=OFF \
    -DCLANG_TOOL_C_INDEX_TEST_BUILD=OFF \
    -DLLVM_PARALLEL_LINK_JOBS=4 \
    -DLLVM_ENABLE_PIC=OFF \
    -DLLVM_ENABLE_LIBCXX=OFF \
    -DLLVM_ENABLE_LLVM_LIBC=OFF \
    -DLLVM_ENABLE_UNWIND_TABLES=OFF \
    -DLLVM_ENABLE_EH=OFF \
    -DLLVM_ENABLE_RTTI=OFF \
    -DLLVM_ENABLE_LTO=OFF \
    -DLLVM_ENABLE_TERMINFO=OFF \
    -DLLVM_ENABLE_MODULES=OFF \
    -DLLVM_ENABLE_PEDANTIC=OFF \
    -DLLVM_ENABLE_FFI=OFF \
    -DLLVM_ENABLE_LIBPFM=OFF \
    -DLLVM_ENABLE_LIBEDIT=OFF \
    -DLLVM_ENABLE_LIBXML2=OFF \
    -DLLVM_ENABLE_CURL=OFF \
    -DLLVM_ENABLE_THREADS=ON \
    -DLLVM_VERSION_SUFFIX= \
    -DLLVM_PROFDATA_FILE=$HOME/proj/llvm-toolchain/out/r563880.profdata \
    -DPython3_LIBRARY=$HOME/proj/llvm-toolchain/prebuilts/python/linux-x86/lib/libpython3.12.a \
    -DPython3_LIBRARIES=$HOME/proj/llvm-toolchain/prebuilts/python/linux-x86/lib/libpython3.12.a \
    -DPython3_INCLUDE_DIR=$HOME/proj/llvm-toolchain/prebuilts/python/linux-x86/include/python3.12 \
    -DPython3_INCLUDE_DIRS=$HOME/proj/llvm-toolchain/prebuilts/python/linux-x86/include/python3.12 \
    -DPython3_EXECUTABLE=$HOME/proj/llvm-toolchain/prebuilts/python/linux-x86/bin/python3.12 \
    -DZLIB_INCLUDE_DIR=$HOME/proj/llvm-toolchain/out/lib/libz-aarch64-unknown-linux-musl-install/include \
    -DZLIB_LIBRARY=$HOME/proj/llvm-toolchain/out/lib/libz-aarch64-unknown-linux-musl-install/lib/libz.a \
    -DLIBXML2_INCLUDE_DIR=$HOME/proj/llvm-toolchain/out/lib/libxml2-aarch64-unknown-linux-musl-install/include/libxml2 \
    -DLIBXML2_LIBRARY=$HOME/proj/llvm-toolchain/out/lib/libxml2-aarch64-unknown-linux-musl-install/lib/libxml2.a \
    -Dzstd_LIBRARY=$HOME/proj/llvm-toolchain/out/lib/libzstd-aarch64-unknown-linux-musl-install/lib/libzstd.a \
    -Dzstd_INCLUDE_DIR=$HOME/proj/llvm-toolchain/out/lib/libzstd-aarch64-unknown-linux-musl-install/include \
    -DLLDB_ENABLE_LUA=OFF \
    -DSWIG_EXECUTABLE=$HOME/proj/llvm-toolchain/out/lib/swig-aarch64-unknown-linux-musl-install/bin/swig \
    -DLLDB_ENABLE_PYTHON=ON \
    -DLLDB_EMBED_PYTHON_HOME=OFF \
    -DLLDB_ENABLE_LZMA=ON \
    -DLLVM_ENABLE_LZMA=FORCE_ON \
    -DLLVM_USE_STATIC_LZMA=ON \
    -DLIBLZMA_INCLUDE_DIR=$HOME/proj/llvm-toolchain/out/lib/liblzma-aarch64-unknown-linux-musl-install/include \
    -DLIBLZMA_LIBRARY=$HOME/proj/llvm-toolchain/out/lib/liblzma-aarch64-unknown-linux-musl-install/lib/liblzma.a \
    -DLLDB_ENABLE_LIBEDIT=ON \
    -DLibEdit_INCLUDE_DIRS=$HOME/proj/llvm-toolchain/out/lib/libedit-aarch64-unknown-linux-musl-install/include \
    -DLibEdit_LIBRARIES=$HOME/proj/llvm-toolchain/out/lib/libedit-aarch64-unknown-linux-musl-install/lib/libedit.a \
    -DLLDB_ENABLE_LIBXML2=ON \
    -DLLDB_ENABLE_CURSES=ON \
    -DLLDB_INCLUDE_TESTS=OFF \
    -DCURSES_INCLUDE_DIRS='/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/include;/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/include/ncurses' \
    -DCURSES_LIBRARIES='/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libncurses.a;/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libform.a;/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libpanel.a' \
    -DPANEL_LIBRARIES='/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libncurses.a;/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libform.a;/home/proj/llvm-toolchain/out/lib/libncurses-aarch64-unknown-linux-musl-install/lib/libpanel.a' \
    -DCLANG_VENDOR='Android (dev, +pgo, -bolt, +lto, -mlgo, based on r563880c)' \
    -DCLANG_REPOSITORY_STRING='https://android.googlesource.com/toolchain/llvm-project' \
    -DBUG_REPORT_URL='https://github.com/android-ndk/ndk/issues' \
    '-DLLVM_ENABLE_RUNTIMES=compiler-rt;libcxx;libcxxabi;libunwind' \
    '-DLLVM_RUNTIME_TARGETS=aarch64-unknown-linux-musl' \
    -DCMAKE_SYSROOT=$HOME/proj/llvm-toolchain/prebuilts/build-tools/sysroots/aarch64-unknown-linux-musl \
    -DLLVM_BUILD_RUNTIME=ON \
    -DLIBCXX_ENABLE_STATIC=ON \
    -DLIBCXX_ENABLE_SHARED=OFF \
    -DLIBCXXABI_ENABLE_STATIC=ON \
    -DLIBCXXABI_ENABLE_SHARED=OFF \
    -DLIBCXXABI_USE_LLVM_UNWINDER=ON \
    -DCOMPILER_SUPPORTS_UNWIND_TABLES=ON \
    -DLIBUNWIND_ENABLE_STATIC=ON \
    -DLIBUNWIND_ENABLE_SHARED=OFF \
    -DCOMPILER_RT_BUILD_LIBFUZZER=ON \
    -DLIBCXX_USE_COMPILER_RT=TRUE \
    -DLIBCXX_HAS_MUSL_LIBC=TRUE \
    -DLIBCXXABI_USE_COMPILER_RT=TRUE \
    -DLIBUNWIND_USE_COMPILER_RT=TRUE \
    -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
    -DLIBCXX_HAS_RT_LIB=FALSE \
    -DLIBCXX_HAS_PTHREAD_LIB=FALSE \
    -DLIBCXXABI_HAS_PTHREAD_LIB=FALSE \
    -DLIBUNWIND_HAS_DL_LIB=FALSE \
    -DLIBUNWIND_HAS_PTHREAD_LIB=FALSE \
    -DRUNTIMES_aarch64-unknown-linux-musl_LIBCXX_INCLUDE_BENCHMARKS=OFF \
    '-DBUILTINS_aarch64-unknown-linux-musl_CMAKE_C_FLAGS=-static -fPIC -D_LIBCPP_HAS_MUSL_LIBC -D_LARGEFILE64_SOURCE=1 -D_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT=1 -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    '-DBUILTINS_aarch64-unknown-linux-musl_CMAKE_CXX_FLAGS=-static -fPIC -D_LIBCPP_HAS_MUSL_LIBC -D_LARGEFILE64_SOURCE=1 -Wno-unused-command-line-argument -D_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT=1 -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    '-DBUILTINS_aarch64-unknown-linux-musl_CMAKE_EXE_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    '-DBUILTINS_aarch64-unknown-linux-musl_CMAKE_SHARED_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    '-DBUILTINS_aarch64-unknown-linux-musl_CMAKE_MODULE_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    -DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_SYSROOT=$HOME/proj/llvm-toolchain/prebuilts/build-tools/sysroots/aarch64-unknown-linux-musl \
    -DBUILTINS_aarch64-unknown-linux-musl_CMAKE_PLATFORM_NO_VERSIONED_SONAME=ON \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_USE_COMPILER_RT=TRUE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_HAS_MUSL_LIBC=TRUE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXXABI_USE_COMPILER_RT=TRUE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBUNWIND_USE_COMPILER_RT=TRUE \
    -DBUILTINS_aarch64-unknown-linux-musl_COMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
    -DBUILTINS_aarch64-unknown-linux-musl_CMAKE_LINK_DEPENDS_USE_LINKER=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_HAS_RT_LIB=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_HAS_PTHREAD_LIB=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXXABI_HAS_PTHREAD_LIB=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBUNWIND_HAS_DL_LIB=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBUNWIND_HAS_PTHREAD_LIB=FALSE \
    -DBUILTINS_aarch64-unknown-linux-musl_LLVM_DEFAULT_TARGET_TRIPLE=aarch64-unknown-linux-musl \
    -DBUILTINS_aarch64-unknown-linux-musl_CMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DBUILTINS_aarch64-unknown-linux-musl_LLVM_ENABLE_LIBCXX=ON \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXXABI_USE_LLVM_UNWINDER=ON \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXXABI_ENABLE_STATIC_UNWINDER=ON \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_HAS_ATOMIC_LIB=NO \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_ENABLE_ABI_LINKER_SCRIPT=OFF \
    -DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_ENABLE_STATIC_ABI_LIBRARY=ON \
    '-DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_TEST_COMPILER_FLAGS=-static -fPIC -D_LIBCPP_HAS_MUSL_LIBC -D_LARGEFILE64_SOURCE=1 -Wno-unused-command-line-argument -D_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT=1 -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    '-DBUILTINS_aarch64-unknown-linux-musl_LIBCXX_TEST_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    -DBUILTINS_aarch64-unknown-linux-musl_SANITIZER_ALLOW_CXXABI=OFF \
    '-DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_C_FLAGS=-static -fPIC -D_LIBCPP_HAS_MUSL_LIBC -D_LARGEFILE64_SOURCE=1 -D_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT=1 -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    '-DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_CXX_FLAGS=-static -fPIC -D_LIBCPP_HAS_MUSL_LIBC -D_LARGEFILE64_SOURCE=1 -Wno-unused-command-line-argument -D_LIBCPP_AVAILABILITY_HAS_NO_VERBOSE_ABORT=1 -Wno-profile-instr-out-of-date -Wno-profile-instr-unprofiled' \
    '-DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_EXE_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    '-DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_SHARED_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    '-DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_MODULE_LINKER_FLAGS=-static -fuse-ld=lld -Wl,--hash-style=both' \
    -DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_PLATFORM_NO_VERSIONED_SONAME=ON \
    -DRUNTIMES_aarch64-unknown-linux-musl_LIBCXX_USE_COMPILER_RT=TRUE \
    -DRUNTIMES_aarch64-unknown-linux-musl_LIBCXX_HAS_MUSL_LIBC=TRUE \
    -DRUNTIMES_aarch64-unknown-linux-musl_LIBCXXABI_USE_COMPILER_RT=TRUE \
    -DRUNTIMES_aarch64-unknown-linux-musl_LIBUNWIND_USE_COMPILER_RT=TRUE \
    -DRUNTIMES_aarch64-unknown-linux-musl_COMPILER_RT_USE_BUILTINS_LIBRARY=TRUE \
    -DRUNTIMES_aarch64-unknown-linux-musl_CMAKE_LINK_DEPENDS_USE=FALSE \
    $HOME/proj/llvm-toolchain/out/llvm-project/llvm
