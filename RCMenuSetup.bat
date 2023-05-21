::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSTk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDpQQQ2MNXiuFLQI5/rHy++UqVkSRN4NW6Le1KG9JfQG+gvhbZNN
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

 if '%errorlevel%' NEQ '0' (
     echo Requesting administrative privileges...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"

rename %0 RCMenuSetup.exe

if exist "%temp%\yes.txt" goto yes

:no
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs"
(
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo Set oShell = WScript.CreateObject ^("WSCript.shell"^)
echo X = Msgbox^("RCMenu을 설치 할겁니까?", vbQuestion + vbYesNo + 4096, "RCMenu"^)
echo If X=vbYes then
echo Set txtFile = fso.CreateTextFile^("%temp%\yes.txt", true^)
echo oShell.Run ^"%0^"

echo ELSEIf X=vbNo then

echo End If
) > "%temp%\ques.vbs"
start "" "%temp%\ques.vbs"
exit

:yes
:: yes.txt 삭제, ques.vbs 삭제
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs"
:: %systemdrive%\Program Files에 RCMenu 폴더 만들기
md "%systemdrive%\Program Files\RCMenu"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/cleaner.bat" > "%systemdrive%\Program Files\RCMenu\cleaner.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/HideFile.bat" > "%systemdrive%\Program Files\RCMenu\HideFile.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/ShowFile.bat" > "%systemdrive%\Program Files\RCMenu\ShowFile.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/CheckSpec.bat" > "%systemdrive%\Program Files\RCMenu\CheckSpec.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/RCMenuRemove.bat" > "%userprofile%\Desktop\RCMenuRemove.bat"
reg add "HKCR\*\shell\RCMenu_파일 숨기기\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\HideFile.bat %%1" /f
reg add "HKCR\Directory\Background\shell\RCMenu_Windows 클리너\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\cleaner.bat" /f
reg add "HKCR\Directory\Background\shell\RCMenu_파일 보이기\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\ShowFile.bat" /f
reg add "HKCR\Directory\Background\shell\RCMenu_사양 확인\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\CheckSpec.bat" /f
timeout 2 /nobreak > nul
cls
echo X=msgbox ^("설치 성공", vbQustion + vbOk + 4096 ,"RCMenu"^) > "%temp%\delete.vbs"
start "" "%temp%\delete.vbs"
exit