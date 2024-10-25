@echo off
:: Überprüfen, ob ZeroTier im 32-Bit oder 64-Bit Verzeichnis installiert ist
set "zerotier_path=C:\Program Files (x86)\ZeroTier\One"
if exist "C:\Program Files\ZeroTier\One\zerotier_desktop_ui.exe" (
    set "zerotier_path=C:\Program Files\ZeroTier\One"
)

set "zerotier_ui=%zerotier_path%\zerotier_desktop_ui.exe"
set "zerotier_cli=%zerotier_path%\zerotier-cli.bat"

:: Netzwerk-ID
set "network_id=93afae59630b0813"

:: Überprüfen, ob ZeroTier bereits läuft
tasklist /FI "IMAGENAME eq zerotier_desktop_ui.exe" 2>NUL | find /I "zerotier_desktop_ui.exe" > NUL
if "%ERRORLEVEL%" NEQ "0" (
    echo Starte ZeroTier...
    start "" "%zerotier_ui%" 2>NUL
    timeout /t 5 > NUL  :: Warte 5 Sekunden, um sicherzustellen, dass ZeroTier gestartet ist
)

:: Mit dem Netzwerk beitreten
echo Verbinde mit dem ZeroTier-Netzwerk (ID: %network_id%)...
start /B "" "%zerotier_cli%" join %network_id% 2>NUL

:: Erfolgsnachricht ausgeben
echo Verbindung wird hergestellt. Bitte warten...
pause > NUL
