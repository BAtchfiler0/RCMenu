@echo off
setlocal enableextensions enabledelayedexpansion
 :: 관리자 권한 요청
 ::--------------------------------
 :: Check for permissions
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

 :: If error flag set, we do not have admin.
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
title RcMenuRemove
rename %0 RCMenuSetup.bat

:: Yes.txt가 있으면 Yes로 이동
if exist "%temp%\yes.txt" goto yes

:: 없다면
:no
:: yes.txt 삭제, ques.vbs 삭제
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs"
:: 삭제할겁니까? 를 물어보는 메시지 박스 만들기
(
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo Set oShell = WScript.CreateObject ^("WSCript.shell"^)
echo X = Msgbox^("RCMenu을 삭제할겁니까?", vbQuestion + vbYesNo + 4096, "RCMenu"^)
echo If X=vbYes then
echo Set txtFile = fso.CreateTextFile^("%temp%\yes.txt", true^)
echo oShell.Run "%0"

echo ELSEIf X=vbNo then

echo End If
) > "%temp%\ques.vbs"
:: 실행하고 종료
start "" "%temp%\ques.vbs"
exit

:: 있다면
:yes
rd /s /q "%systemdrive%\icon"
rd /s /q "%systemdrive%\Program Files\RCMenu"
reg delete "HKCR\*\shell\RCMenu_파일 숨기기" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_Windows 클리너" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_사양 확인" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_파일 보이기" /f
echo X=msgbox ^("삭제 성공", vbQustion + vbOk + 4096 ,"RCMenu"^) > "%temp%\delete.vbs"
start "" "%temp%\delete.vbs"
del /f /q delete.vbs
del /f /q "%temp%\yes.txt"
del /f /q "%0"
exit
