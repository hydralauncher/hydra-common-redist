@echo off
:: Request admin privileges if not already elevated
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -Command "Start-Process -WindowStyle hidden '%~f0' -Verb RunAs"
    exit
)

:: Change to the script’s directory
cd /d "%~dp0"

:: Define log file path
set LOG_FILE=%TEMP%\common_redist_install.log

:: Clear log file
> %LOG_FILE% echo.

:: Install .NET Framework 4.0
if exist dotNetFx40_Full_setup.exe (
    echo Installing .NET Framework 4.0 >> %LOG_FILE%
    dotNetFx40_Full_setup.exe /q /norestart /log dotnet_install.log
)

:: Install DirectX
if exist dxwebsetup.exe (
    echo Installing DirectX >> %LOG_FILE%
    dxwebsetup.exe /Q
)

:: Install OpenAL
if exist oalinst.exe (
    echo Installing OpenAL >> %LOG_FILE%
    oalinst.exe /silent
)

:: Install Visual C++ Redistributables (2015-2019)
if exist vcredist_2015-2019_x64.exe (
    echo Installing Visual C++ Redistributable 2015-2019 ^(x64^) >> %LOG_FILE%
    vcredist_2015-2019_x64.exe /quiet /norestart
)
if exist vcredist_2015-2019_x86.exe (
    echo Installing Visual C++ Redistributable 2015-2019 ^(x86^) >> %LOG_FILE%
    vcredist_2015-2019_x86.exe /quiet /norestart
)

:: Install older Visual C++ Redistributables
if exist vcredist_x64.exe (
    echo Installing Visual C++ Redistributable ^(x64^) >> %LOG_FILE%
    vcredist_x64.exe /quiet /norestart
)
if exist vcredist_x86.exe (
    echo Installing Visual C++ Redistributable ^(x86^) >> %LOG_FILE%
    vcredist_x86.exe /quiet /norestart
)

:: Install XNA Framework 4.0
if exist xnafx40_redist.msi (
    echo Installing XNA Framework 4.0 >> %LOG_FILE%
    msiexec /i xnafx40_redist.msi /quiet /norestart
)

echo Installation complete >> %LOG_FILE%
pause