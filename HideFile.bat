@echo off
set folderfile=%1
set folder=%~dp1
set file=%~nx1


powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/BAtchfiler0/AES_CRYPT/raw/main/aescrypt.exe','%temp%\aescrypt.exe')"
"%temp%\aescrypt.exe" -e -p HideFile "%~dp1%~nx1"
echo %file%>"%temp%\file.txt"
certutil -encode "%temp%\file.txt" "%temp%\filee.txt" && findstr /v /c:-  "%temp%\filee.txt">"%temp%\filename.txt"
cd "%temp%"
for /f "tokens=*" %%A in ('filename.txt') do (
set basefilename=%%A
)
md "%temp%\%basefilename%"
move "%~dp1%~nx1.aes" "%temp%\%basefilename%"
del /f /q "%~dp1%~nx1"
icacls "%temp%\%basefilename%\%file%.aes" /deny Everyone:F

pause
exit