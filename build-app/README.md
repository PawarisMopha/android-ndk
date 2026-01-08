### How to use termux-ndk to build android app

Download the `android-ndk` and `android-sdk` from [release](https://github.com/Lzhiyong/termux-ndk/releases)
```bash
# install openjdk-25
pkg install openjdk-25

# install gradle
pkg install gradle

```

Add a `local.properties` file to the root of the project as below
```local.properties
# modify the local.properties file
# although ndk.dir has been deprecated, but it still works
sdk.dir=/path/to/android-sdk
ndk.dir=/path/to/android-ndk
cmake.dir=/path/to/cmake
# for example:
sdk.dir=/data/data/com.termux/files/home/opt/android-sdk
ndk.dir=/data/data/com.termux/files/home/opt/android-ndk-r29
cmake.dir=/data/data/com.termux/files/home/opt/android-sdk/cmake
```
Modify the `project/build.gradle.kts` file
```build.gradle.kts
// set the Android gradle plugin version 
plugins {
    id("com.android.application") version "8.10.0" apply false
    id("com.android.library") version "8.10.0" apply false
    id("org.jetbrains.kotlin.android") version "2.3.0" apply false
}
```
Modify the project `app/build.gradle.kts` file
```build.gradle.kts

android {
    // set the build tools version
    buildToolsVersion = "35.0.0"
    
    externalNativeBuild {
        cmake {
            path("src/main/cpp/CMakeLists.txt")
            // specify the cmake version
            version = "4.2.1"
        }
    }
}
```

Execute the `gradle build` command to start building the android app, when building for the first time, 
the exec format error will occur, because the aapt2 is x86_64 architecture not aarch64, so we need to replace it

```bash
# replace the aapt2 with your own
# note: it's /path/to not /path/to/aapt2
find ~/.gradle -name 'aapt2-*-linux.jar' -type f | xargs -I{} jar -uvf {} -C /path/to aapt2
```
If an error occurs during the build app, this may be a network problem, please execute the `gradle build` again or execute the `gradle build --info` for more information.

**** 

### Building termux-app with termux
```gradle.properties
# clone the termux-app
git clone --depth=1 https://github.com/termux/termux-app

# add a local.properties file
sdk.dir=/path/to/android-sdk 
ndk.dir=/path/to/android-ndk 
cmake.dir=/path/to/cmake

# modify gradle.properties file 
minSdkVersion=24
targetSdkVersion=28
ndkVersion=29.0.14206865
compileSdkVersion=35
buildToolsVersion=35.0.0

# modify the build.gradle file
# termux-app/app/build.gradle 
# terminal-emulator/build.gradle 
# terminal-view/build.gradle 
# termux-shared/build.gradle
# set the buildToolsVersion
android {
    ...
    compileSdkVersion project.properties.compileSdkVersion.toInteger()
    // set the build tools version
    buildToolsVersion project.properties.buildToolsVersion.toString()
    ...
}

# start building
gradle assembleDebug

```
<div align="left">
    <img src="./screenshot/build_termux_app1.jpg" width="50%" /><img src="./screenshot/build_termux_app2.jpg" width="50%" />
</div>

**** 
### Building example
```bash
# GL2
cd GL2 && gradle installDebug

# GL3
cd GL3 && gradle installDebug

```
<div align="left">
    <img src="./GL3/gles3.jpg" width="50%" /><img src="./GL2/gles2.jpg" width="50%" />
</div>

**** 

### Known issues
Using proot or chroot linux is not recommended, this may have some problems, the building speed is much slower than the native Termux.
