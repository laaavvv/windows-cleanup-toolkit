@echo off
title Windows Cleanup Toolkit - by laaavvv
color 0B

:: ====================================================================================================================
::   Windows Cleanup Toolkit
::   Author  : laaavvv
::   GitHub  : github.com/laaavvv
::   Version : 1.0
:: ====================================================================================================================

:: ====================================================================================================================
:: Administrator Privilege Check
:: ====================================================================================================================
echo Checking administrator permissions...
net session >nul 2>&1
if %errorLevel% == 0 (
    echo [OK] Administrator privileges granted.
    echo.
) else (
    echo [ERROR] Insufficient permissions.
    echo Please right-click this file and select "Run as administrator".
    pause
    exit /b 1
)

:MENU
cls
color 0B
echo.
echo  ====================================================================================================================
echo    Windows Cleanup Toolkit  ^|  by laaavvv, github.com/laaavvv
echo  ====================================================================================================================
echo.
echo    [1]  Temp File Cleanup
echo         Removes temporary files, browser cache, logs and junk from the system.       
echo.
echo    [2]  Registry, Event Logs ^& Disk Cleanup
echo         Remove registry trash, clears Windows Event Logs and launches the built-in Disk Cleanup tool (cleanmgr)            
echo.
echo    [3]  Full Cleanup  (Option 1 + Option 2)
echo         Runs both cleanups in sequence.
echo.
echo    [0]  Exit
echo.
echo  ====================================================================================================================
set /p CHOICE="  Select an option [0-3]: "

if "%CHOICE%"=="1" goto TEMP_CLEANUP
if "%CHOICE%"=="2" goto REG_CLEANUP
if "%CHOICE%"=="3" goto FULL_CLEANUP
if "%CHOICE%"=="0" goto EXIT

echo.
echo  [!] Invalid option. Please try again.
timeout /t 2 >nul
goto MENU


:: ====================================================================================================================
:: OPTION 1 - Temp File Cleanup
:: ====================================================================================================================
:TEMP_CLEANUP
cls
color 0B
echo.
echo  ====================================================================================================================
echo    [1] Temp File Cleanup  ^|  by laaavvv
echo  ====================================================================================================================
echo.

REM --- CLOSING CLEANUP PROGRAMS ---
echo  [*] Closing cleanup-related programs...
taskkill /F /IM "ccleaner64.exe" >NUL 2>&1
taskkill /F /IM "ccleaner.exe" >NUL 2>&1
echo      [OK] Done.

REM --- CLEANING C:\Windows\SystemTemp ---
echo  [*] Cleaning C:\Windows\SystemTemp...
takeown /A /R /D Y /F C:\Windows\SystemTemp >NUL 2>&1
icacls C:\Windows\SystemTemp /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s C:\Windows\SystemTemp >NUL 2>&1
md C:\Windows\SystemTemp >NUL 2>&1
echo      [OK] Done.

REM --- USER AND SYSTEM TEMP FOLDERS ---
echo  [*] Cleaning user and system temp folders...
takeown /A /R /D Y /F C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1
icacls C:\Users\%USERNAME%\AppData\Local\Temp\ /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1
md C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1

takeown /A /R /D Y /F C:\windows\temp >NUL 2>&1
icacls C:\windows\temp /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s c:\windows\temp >NUL 2>&1
md c:\windows\temp >NUL 2>&1
echo      [OK] Done.

REM --- LOG FILES AND SYSTEM CACHE ---
echo  [*] Cleaning log files and Windows cache...
del c:\windows\logs\cbs\*.log >NUL 2>&1
del C:\Windows\Logs\MoSetup\*.log >NUL 2>&1
del C:\Windows\Panther\*.log /s /q >NUL 2>&1
del C:\Windows\inf\*.log /s /q >NUL 2>&1
del C:\Windows\logs\*.log /s /q >NUL 2>&1
del C:\Windows\SoftwareDistribution\*.log /s /q >NUL 2>&1
del C:\Windows\Microsoft.NET\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\SettingSync\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\"Terminal Server Client"\Cache\*.bin /s /q >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\ >NUL 2>&1
echo      [OK] Done.

REM --- WINDOWS UPDATE FILES ---
echo  [*] Cleaning Windows Update download cache...
for %%F in ("C:\Windows\SoftwareDistribution\Download\*") do (
    del "%%F" /q /f >NUL 2>&1
    rd "%%F" /s /q >NUL 2>&1
) >NUL 2>&1

for %%A in ("%localappdata%\Microsoft\Windows\INetCache\IE\*") do (
    del "%%A" /q /f >NUL 2>&1
    rd "%%A" /s /q >NUL 2>&1
) >NUL 2>&1
echo      [OK] Done.

REM --- BROWSER CLEANUP ---
echo  [*] Cleaning web browser caches...

REM EDGE
taskkill /F /IM "msedge.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\GrShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\ShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 1"\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\"Profile 2"\Storage\ext\ >NUL 2>&1

REM FIREFOX
taskkill /F /IM "firefox.exe" >NUL 2>&1
set parentfolder=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles\
for /f "tokens=*" %%a in ('"dir /b "%parentfolder%"|findstr ".*\.default-release""') do set folder=%%a
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\entries\*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.bin >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.lz* >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\index*.* >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.little >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\*.log /s /q >NUL 2>&1

REM VIVALDI
taskkill /F /IM "vivaldi.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\GrShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\ShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 1"\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\"Profile 2"\Storage\ext\ >NUL 2>&1

REM BRAVE
taskkill /F /IM "brave.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\GrShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\ShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 1"\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\"Profile 2"\Storage\ext\ >NUL 2>&1

REM CHROME
taskkill /F /IM "chrome.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\GrShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\ShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 1"\Storage\ext\ >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\"Profile 2"\Storage\ext\ >NUL 2>&1

REM --- RECYCLE BIN ---
echo  [*] Emptying the Recycle Bin...
powershell Clear-RecycleBin -Force >NUL 2>&1
echo      [OK] Done.

echo.
echo  ====================================================================================================================
echo    [1] Temp File Cleanup - COMPLETED
echo  ====================================================================================================================
echo.
goto END_PROMPT


:: ====================================================================================================================
:: OPTION 2 - Registry, Event Logs & Disk Cleanup
:: ====================================================================================================================
:REG_CLEANUP
cls
color 0B
echo.
echo  ====================================================================================================================
echo    [2] Registry, Event Logs ^& Disk Cleanup  ^|  by laaavvv
echo  ====================================================================================================================
echo.

echo  [*] Step 1: Applying registry configuration to silence system sounds...
(
echo Windows Registry Editor Version 5.00
echo.
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MailBeep\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MailBeep\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MessageNudge\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MessageNudge\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.IM\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.IM\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Mail\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Mail\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Proximity\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Proximity\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Reminder\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Reminder\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.SMS\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.SMS\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\ProximityConnection\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\ProximityConnection\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOnSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOnSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubSleepSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubSleepSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\MisrecoSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\MisrecoSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\PanelSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\PanelSound\.current]
) > "%temp%\wct_temp_reg.reg"

regedit.exe /s "%temp%\wct_temp_reg.reg"
del "%temp%\wct_temp_reg.reg"
echo      [OK] Registry keys applied.
echo.

echo  [*] Step 2: Opening Windows Disk Cleanup...
start "" cleanmgr.exe
echo      [OK] Disk Cleanup launched in the background.
echo.

echo  [*] Step 3: Clearing Windows Event Logs...
powershell.exe -ExecutionPolicy Bypass -Command "Get-EventLog -LogName * | ForEach-Object { Clear-EventLog $_.Log }"
echo      [OK] Event Logs cleared successfully.
echo.

echo  ====================================================================================================================
echo    [2] Registry, Event Logs ^& Disk Cleanup - COMPLETED
echo  ====================================================================================================================
echo.
goto END_PROMPT


:: ====================================================================================================================
:: OPTION 3 - Full Cleanup (Option 1 + Option 2)
:: ====================================================================================================================
:FULL_CLEANUP
cls
color 0B
echo.
echo  ====================================================================================================================
echo    [3] Full Cleanup  ^|  by laaavvv
echo  ====================================================================================================================
echo.
echo  Running Option 1: Temp File Cleanup...
echo  --------------------------------------------------------------------------------------------------------------------

REM --- Inline execution of Option 1 ---
taskkill /F /IM "ccleaner64.exe" >NUL 2>&1
taskkill /F /IM "ccleaner.exe" >NUL 2>&1

echo  [*] Cleaning C:\Windows\SystemTemp...
takeown /A /R /D Y /F C:\Windows\SystemTemp >NUL 2>&1
icacls C:\Windows\SystemTemp /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s C:\Windows\SystemTemp >NUL 2>&1
md C:\Windows\SystemTemp >NUL 2>&1

echo  [*] Cleaning user and system temp folders...
takeown /A /R /D Y /F C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1
icacls C:\Users\%USERNAME%\AppData\Local\Temp\ /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1
md C:\Users\%USERNAME%\AppData\Local\Temp\ >NUL 2>&1
takeown /A /R /D Y /F C:\windows\temp >NUL 2>&1
icacls C:\windows\temp /grant administrators:F /T /C >NUL 2>&1
rmdir /q /s c:\windows\temp >NUL 2>&1
md c:\windows\temp >NUL 2>&1

echo  [*] Cleaning log files and Windows cache...
del c:\windows\logs\cbs\*.log >NUL 2>&1
del C:\Windows\Logs\MoSetup\*.log >NUL 2>&1
del C:\Windows\Panther\*.log /s /q >NUL 2>&1
del C:\Windows\inf\*.log /s /q >NUL 2>&1
del C:\Windows\logs\*.log /s /q >NUL 2>&1
del C:\Windows\SoftwareDistribution\*.log /s /q >NUL 2>&1
del C:\Windows\Microsoft.NET\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\WebCache\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\SettingSync\*.log /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp /s /q >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\"Terminal Server Client"\Cache\*.bin /s /q >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\INetCache\ >NUL 2>&1

for %%F in ("C:\Windows\SoftwareDistribution\Download\*") do (
    del "%%F" /q /f >NUL 2>&1
    rd "%%F" /s /q >NUL 2>&1
) >NUL 2>&1
for %%A in ("%localappdata%\Microsoft\Windows\INetCache\IE\*") do (
    del "%%A" /q /f >NUL 2>&1
    rd "%%A" /s /q >NUL 2>&1
) >NUL 2>&1

echo  [*] Cleaning browser caches...
taskkill /F /IM "msedge.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\f*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Cache\index. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\"Service Worker"\ScriptCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\GrShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\ShaderCache\GPUCache\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Microsoft\Edge\"User Data"\Default\Storage\ext\ >NUL 2>&1
taskkill /F /IM "firefox.exe" >NUL 2>&1
set parentfolder=C:\Users\%USERNAME%\AppData\Local\Mozilla\Firefox\Profiles\
for /f "tokens=*" %%a in ('"dir /b "%parentfolder%"|findstr ".*\.default-release""') do set folder=%%a
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\entries\*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\startupCache\*.bin >NUL 2>&1
del C:\Users\%USERNAME%\AppData\local\Mozilla\Firefox\Profiles\%folder%\cache2\*.log /s /q >NUL 2>&1
taskkill /F /IM "vivaldi.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\"Service Worker"\CacheStorage\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Vivaldi\"User Data"\Default\GPUCache\ >NUL 2>&1
taskkill /F /IM "brave.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\BraveSoftware\Brave-Browser\"User Data"\Default\GPUCache\ >NUL 2>&1
taskkill /F /IM "chrome.exe" >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\data*. >NUL 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\Cache\f*. >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\"Service Worker"\Database\ >NUL 2>&1
rmdir /q /s C:\Users\%USERNAME%\AppData\Local\Google\Chrome\"User Data"\Default\GPUCache\ >NUL 2>&1
powershell Clear-RecycleBin -Force >NUL 2>&1

echo      [OK] Temp cleanup done.
echo.
echo  Running Option 2: Registry, Event Logs ^& Disk Cleanup...
echo  --------------------------------------------------------------------------------------------------------------------

(
echo Windows Registry Editor Version 5.00
echo.
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
echo [-HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
echo [HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
) > "%temp%\wct_temp_reg.reg"

regedit.exe /s "%temp%\wct_temp_reg.reg"
del "%temp%\wct_temp_reg.reg"
echo  [*] Registry keys applied.

start "" cleanmgr.exe
echo  [*] Disk Cleanup launched in the background.

powershell.exe -ExecutionPolicy Bypass -Command "Get-EventLog -LogName * | ForEach-Object { Clear-EventLog $_.Log }"
echo  [*] Event Logs cleared.

echo.
echo  ====================================================================================================================
echo    [3] Full Cleanup - COMPLETED
echo  ====================================================================================================================
echo.
goto END_PROMPT


:: ====================================================================================================================
:: END PROMPT - Return to menu or exit
:: ====================================================================================================================
:END_PROMPT
echo  Would you like to return to the main menu?
set /p RETURN="  [Y] Yes  /  [N] Exit: "
if /i "%RETURN%"=="Y" goto MENU
if /i "%RETURN%"=="N" goto EXIT
goto END_PROMPT


:: ====================================================================================================================
:: EXIT
:: ====================================================================================================================
:EXIT
cls
color 0B
echo.
echo  ====================================================================================================================
echo    Windows Cleanup Toolkit  ^|  by laaavvv, github.com/laaavvv
echo    Thank you for using this tool.
echo  ====================================================================================================================
echo.
timeout /t 3 >nul
exit
