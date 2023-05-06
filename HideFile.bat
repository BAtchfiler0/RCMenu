@echo off
set folderfile=%1
set folder=%~dp1
set file=%~nx1
set /p pass=Password : 
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/BAtchfiler0/AES_CRYPT/raw/main/aescrypt.exe','%temp%\aescrypt.exe')"
"%temp%\aescrypt.exe" -e -p HideFile%pass% "%~dp1%~nx1"
cd "%temp%"


move "%~dp1%~nx1.aes" "%temp%"
del /f /q "%~dp1%~nx1"
icacls "%temp%\%file%.aes" /deny Everyone:F
del /f /q aescrypt.exe
pause
exit
