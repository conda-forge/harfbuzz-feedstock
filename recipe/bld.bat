@ECHO ON

:: By default Meson tries to run glib-mkenums with the %BUILD_PREFIX% Python, which fails.
:: In order to override this, we need to use a Meson machine file, because otherwise
:: Meson prioritizes the results from the glib-2.0 pkg-config file, which don't work.
echo [binaries] >native_file.txt
echo glib-mkenums = ['%PREFIX%\python.exe', '%LIBRARY_PREFIX%\bin\glib-mkenums'] >>native_file.txt

meson setup builddir %MESON_ARGS% ^
    --backend=ninja ^
    --native-file=native_file.txt ^
    --wrap-mode=nofallback ^
    -Dbenchmark=disabled ^
    -Dcairo=enabled ^
    -Dcoretext=auto ^
    -Dcpp_std=c++17 ^
    -Ddocs=disabled ^
    -Dfreetype=enabled ^
    -Dgdi=auto ^
    -Dglib=enabled ^
    -Dgobject=enabled ^
    -Dgraphite2=enabled ^
    -Dicu=enabled ^
    -Dintrospection=enabled ^
    -Dtests=disabled
if errorlevel 1 exit 1

ninja -v -C builddir -j %CPU_COUNT%
if errorlevel 1 exit 1

ninja -C builddir install -j %CPU_COUNT%
if errorlevel 1 exit 1

del %LIBRARY_PREFIX%\bin\*.pdb
