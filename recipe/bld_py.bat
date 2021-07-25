set

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
    -DDETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON ^
    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

