@echo off
setlocal enabledelayedexpansion

:: ===========================
:: Load settings from conf file
:: ===========================
if not exist "settings.conf" (
    echo ERROR: settings.conf not found in this folder.
    pause
    exit /b
)

for /f "usebackq tokens=1* delims==" %%a in ("settings.conf") do (
    set "%%a=%%b"
)

:: ===========================
:: Normalize drive letter and remote
:: ===========================
:: Remove trailing colon from drive if present
set "driveLetter=%drive%"
if "%driveLetter:~-1%"==":" set "driveLetter=%driveLetter:~0,-1%"

:: Remove trailing colon from remote if present
set "remoteName=%remote%"
if "%remoteName:~-1%"==":" set "remoteName=%remoteName:~0,-1%"

:: Validate required settings
if "%driveLetter%"=="" (
    echo ERROR: Drive not set in settings.conf
    pause
    exit /b
)
if "%remoteName%"=="" (
    echo ERROR: Remote not set in settings.conf
    pause
    exit /b
)

:: ===========================
:: Interactive command menu
:: ===========================
:menu
cls
echo ================================
echo        Rclone Manager Command Menu
echo ================================
echo Type one of the following commands:
echo mount             - Mount the remote (with Web GUI)
echo reconnect         - Reconnect a remote
echo unmount           - Unmount the drive
echo refresh           - Forget + refresh VFS cache
echo exit              - Exit the application
echo ================================
set /p CMD=Enter command: 

:: Parse command
if /i "%CMD%"=="exit" exit /b
if /i "%CMD%"=="mount" goto mount
if /i "%CMD%"=="reconnect" goto reconnect
if /i "%CMD%"=="unmount" goto unmount
if /i "%CMD%"=="refresh" goto refresh_cache

echo Unknown command: %CMD%
pause
goto menu

:: ===========================
:: Mount + Web GUI
:: ===========================
:mount
echo Mounting %remoteName% to %driveLetter%: with Web GUI...

:: Build mount command
set "MOUNT_CMD=rclone mount %remoteName%: %driveLetter%: --vfs-cache-mode=%vfs_cache_mode% --transfers=%transfers% --bwlimit=%bwlimit% --dir-cache-time=%dir_cache_time% --poll-interval=%poll_interval% --buffer-size=%buffer_size% --rc --rc-web-gui --rc-addr=%rc_addr% --rc-user=%rc_user% --rc-pass=%rc_pass%"

:: Ask user if they want logs in CMD
set /p LOG_OPTION=Show logs in CMD? (y/N): 
if /i "%LOG_OPTION%"=="y" (
    start "" cmd /k %MOUNT_CMD%
) else (
    start "" cmd /c %MOUNT_CMD%
)

echo Rclone mount + Web GUI started.
echo Open http://%rc_addr% in your browser.
pause
goto menu

:: ===========================
:: Reconnect
:: ===========================
:reconnect
set /p remoteInput=Enter remote to reconnect (e.g. cloud or cloud:): 
:: Normalize trailing colon
if "%remoteInput:~-1%"==":" set "remoteInput=%remoteInput:~0,-1%"

set "RECONNECT_CMD=rclone config reconnect %remoteInput%:"
start "" cmd /k %RECONNECT_CMD%
pause
goto menu

:: ===========================
:: Unmount
:: ===========================
:unmount
echo Unmounting %driveLetter%...
for /f "tokens=2" %%i in ('wmic process where "name='rclone.exe' and commandline like '%%%driveLetter%%:%'" get ProcessId ^| findstr /r "[0-9]"') do (
    taskkill /PID %%i /F
)
echo Done.
pause
goto menu

:: ===========================
:: Refresh VFS cache
:: ===========================
:refresh_cache
echo Refreshing VFS cache for %remoteName%...

:: Forget old cache
rclone rc vfs/forget --rc-user=%rc_user% --rc-pass=%rc_pass%

:: Refresh cache
rclone rc vfs/refresh --rc-user=%rc_user% --rc-pass=%rc_pass%

echo VFS cache refreshed.
pause
goto menu