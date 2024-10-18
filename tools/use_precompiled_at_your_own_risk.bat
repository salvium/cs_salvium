setlocal

for %%I in ("%~dp0.") do set "TOOLS_DIR=%%~fI"

set "PROJECT_DIR=%TOOLS_DIR%\.."

set "OUTPUTS_DIR=%PROJECT_DIR%\precompiled"
set "LIBS_PACKAGE_DIR=%PROJECT_DIR%\cs_monero_flutter_libs"
set "ANDROID_LIBS_DIR=%LIBS_PACKAGE_DIR%\android\src\main\jniLibs"
set "IOS_LIBS_DIR=%LIBS_PACKAGE_DIR%\ios\Frameworks"
set "MACOS_LIBS_DIR=%LIBS_PACKAGE_DIR%\macos\Frameworks"
set "LINUX_LIBS_DIR=%LIBS_PACKAGE_DIR%\linux\lib"
set "WINDOWS_LIBS_DIR=%LIBS_PACKAGE_DIR%\windows\lib"

rem Check and copy Android libraries
if exist "%OUTPUTS_DIR%\android\jniLibs" (
  rmdir /s /q "%ANDROID_LIBS_DIR%"
  xcopy /e /i "%OUTPUTS_DIR%\android\jniLibs" "%ANDROID_LIBS_DIR%"
)

rem Check and copy iOS libraries
if exist "%OUTPUTS_DIR%\ios\Frameworks" (
  rmdir /s /q "%IOS_LIBS_DIR%"
  xcopy /e /i "%OUTPUTS_DIR%\ios\Frameworks" "%IOS_LIBS_DIR%"
)

rem Check and copy macOS libraries
if exist "%OUTPUTS_DIR%\macos\Frameworks" (
  rmdir /s /q "%MACOS_LIBS_DIR%"
  xcopy /e /i "%OUTPUTS_DIR%\macos\Frameworks" "%MACOS_LIBS_DIR%"
)

rem Check and copy Linux libraries
if exist "%OUTPUTS_DIR%\linux" (
  rmdir /s /q "%LINUX_LIBS_DIR%"
  xcopy /e /i "%OUTPUTS_DIR%\linux" "%LINUX_LIBS_DIR%"
)

rem Check and copy Windows libraries
if exist "%OUTPUTS_DIR%\windows" (
  rmdir /s /q "%WINDOWS_LIBS_DIR%"
  xcopy /e /i "%OUTPUTS_DIR%\windows" "%WINDOWS_LIBS_DIR%"
)

