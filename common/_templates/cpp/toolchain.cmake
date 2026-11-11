set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(CMAKE_HOST_APPLE)
  # Homebrew版LLVM
  execute_process(COMMAND brew --prefix llvm
                  OUTPUT_VARIABLE LLVM_PREFIX
                  OUTPUT_STRIP_TRAILING_WHITESPACE)
  set(CMAKE_C_COMPILER   "${LLVM_PREFIX}/bin/clang"   CACHE STRING "")
  set(CMAKE_CXX_COMPILER "${LLVM_PREFIX}/bin/clang++" CACHE STRING "")
  set(CMAKE_OSX_DEPLOYMENT_TARGET "27.2" CACHE STRING "")
  set(CMAKE_EXE_LINKER_FLAGS_INIT
      "-L${LLVM_PREFIX}/lib/c++ -Wl,-rpath,${LLVM_PREFIX}/lib/c++")
else()
  # Arch
  set(CMAKE_C_COMPILER   clang   CACHE STRING "")
  set(CMAKE_CXX_COMPILER clang++ CACHE STRING "")
  set(CMAKE_EXE_LINKER_FLAGS_INIT "-fuse-ld=lld")
endif()

set(CMAKE_CXX_FLAGS_INIT "-stdlib=libc++")
set(CMAKE_EXE_LINKER_FLAGS_INIT "${CMAKE_EXE_LINKER_FLAGS_INIT} -stdlib=libc++")
