@echo off
title Restaurando Sistema...
setlocal

echo [+] Eliminando archivos temporales de la broma...
rd /s /q "%TEMP%\PrankProject" 2>nul

echo [+] Restaurando sonidos originales de Windows...
:: Restaurar sonido de conexion USB
reg add "HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current" /ve /t REG_SZ /d "C:\Windows\media\Windows Connect.wav" /f
:: Restaurar sonido de desconexion USB
reg add "HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current" /ve /t REG_SZ /d "C:\Windows\media\Windows Disconnect.wav" /f

echo [+] Restaurando nombre original de la Papelera...
:: Borramos la entrada personalizada para que use el nombre por defecto
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /f 2>nul

echo [+] Reiniciando interfaz para aplicar cambios...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo [!] Los sonidos y nombres han vuelto a la normalidad.
echo [!] IMPORTANTE: El fondo de pantalla debes cambiarlo tu manualmente:
echo     Click derecho en Escritorio -> Personalizar -> Fondo.
echo.
pause