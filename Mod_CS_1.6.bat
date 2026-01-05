setlocal enabledelayedexpansion

:: ------------ CONFIGURACION -----------
set "urlImagen=https://lorahentai.com/wp-content/uploads/2024/09/sokka-se-folla-a-su-hermana-avatar-la-leyenda-de-aang-anime.jpg"
set "urlSonido=https://raw.githubusercontent.com/lucashorminoguez/Prank/main/audio/onii%%20chan.wav"

::Descarga con TLS 1.2/1.3 (GitHub lo exige) y el link corregido
echo [+] Descargando sonido desde tu repo...
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%urlSonido%' -OutFile '%sndPath%' -UserAgent 'Mozilla/5.0'"

::Verif de seguridad
if not exist "%sndPath%" (
    echo [!] ERROR: El sonido no se descargo. Revisa que el nombre en GitHub sea 'onii chan.wav'
) else (
    echo [+] Sonido descargado correctamente.
)

set "folder=%TEMP%\PrankProject"
set "imgPath=%folder%\wallpaper.jpg"
set "sndPath=%folder%\onichan.wav"

if not exist "%folder%" mkdir "%folder%"

echo [+] Descargando recursos (puede tardar)...
:: El "disfraz" para que las webs no bloqueen el script:
set "UA=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"

powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%urlImagen%' -OutFile '%imgPath%' -UserAgent '%UA%'"
powershell -Command "Invoke-WebRequest -Uri '%urlSonido%' -OutFile '%sndPath%' -UserAgent '%UA%'"

:: ----- CAMBIO FONDO DE PANTALLA ---------------------
echo [+] Aplicando nuevo fondo de escritorio...
powershell -Command "Add-Type -TypeDefinition 'using System.Runtime.InteropServices; public class Wallpaper { [DllImport(\"user32.dll\", CharSet = CharSet.Auto)] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }'; [Wallpaper]::SystemParametersInfo(20, 0, '%imgPath%', 3)"

:: ------- CAMBIO SONIDO DE USB -------------
echo [+] Configurando sonido de sistema...
:: Sonido al conectar
reg add "HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current" /ve /t REG_SZ /d "%sndPath%" /f
:: Sonido al desconectar (opcional, pero divertido)
reg add "HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current" /ve /t REG_SZ /d "%sndPath%" /f

:: -------- EL PC HABLA -----------------------
echo [+] Iniciando sintesis de voz...
echo CreateObject("SAPI.SpVoice").Speak "Oni chan, baka! Tu computadora ahora me pertenece." > "%folder%\voice.vbs"
start "" "%folder%\voice.vbs"

:: ------------ RENOMBRO PAPELERA Y REINICIO EXPLORADOR ----------------
echo [+] Finalizando...
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /ve /t REG_SZ /d "Santuario de Waifus" /f

:: Reiniciamos el explorador para que los cambios de registro (papelera) se vean
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo [!] Broma aplicada con exito.
pause