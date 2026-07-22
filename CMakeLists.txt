cmake_minimum_required(VERSION 3.10)
project(hello-android CXX)

set(CMAKE_CXX_STANDARD 11)

# สั่งให้บิวด์ไฟล์โค้ด main.cpp ออกมาเป็นโปรแกรมชื่อ hello_main
add_executable(hello_main main.cpp)
