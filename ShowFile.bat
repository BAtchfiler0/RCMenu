@echo off
:set
cls
set /p file=File name(no directory) : 
set /p pass=Password (no space): 

cd "%temp%"
icacls "%file%.aes" /grant Everyone:F
powershell "(New-Object System.Net.WebClient).DownloadFile('https://github.com/BAtchfiler0/AES_CRYPT/raw/main/aescrypt.exe','%temp%\aescrypt.exe')"
aescrypt.exe -d -p HideFile%pass% "%file%.aes"
if %errorlevel%==-1 echo ��й�ȣ�� �����̸��� Ȯ�����ּ���! & timeout 4 & goto set

move "%file%" "%userprofile%\Desktop"
del /q "%file%.aes"
del /q "aescrypt.exe"
exit