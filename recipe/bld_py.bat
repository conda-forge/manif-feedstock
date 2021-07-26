set "CC=clang-cl.exe"
set "CXX=clang-cl.exe"
set

mkdir build%CONDA_PY%
cd build%CONDA_PY%

:: Install the C++ related files in a random prefix so they are ignored,
:: as they are already packaged by the manif packge in bld_cxx.bat
:: Python bindings are installed outside CMAKE_INSTALL_PREFIX via the 
:: DETECT_ACTIVE_PYTHON_SITEPACKAGES option
cmake ^
    -G "NMake Makefiles" ^
    -DCMAKE_INSTALL_PREFIX=.\install ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_TESTING=OFF ^
    -DBUILD_EXAMPLES=OFF ^
    -DUSE_SYSTEM_WIDE_TL_OPTIONAL=ON ^
    -DBUILD_PYTHON_BINDINGS:BOOL=ON ^
    -DPython3_EXECUTABLE:PATH=%PYTHON% ^
    -DPython3_LIBRARY:PATH=%PREFIX%\libs\python%CONDA_PY%.lib ^
    -DDETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON ^
    %SRC_DIR%
type CMakeCache.txt
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

