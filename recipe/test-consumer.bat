@echo on
cl /nologo test-consumer.c /I"%LIBRARY_INC%\harfbuzz" "%LIBRARY_LIB%\harfbuzz.lib" /Fe:hb-consumer.exe
if errorlevel 1 exit /b 1
hb-consumer.exe test\api\fonts\Inconsolata-Regular.abc.ttf
if errorlevel 1 exit /b 1
hb-shape test\api\fonts\Inconsolata-Regular.abc.ttf abc
if errorlevel 1 exit /b 1
