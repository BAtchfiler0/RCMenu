@echo off
 :: ������ ���� ��û
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

rename %0 RCMenuSetup.bat

:: Yes.txt�� ������ Yes�� �̵�
if exist "%temp%\yes.txt" goto yes

:: ���ٸ�
:no
:: yes.txt ����, ques.vbs ����
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs"
:: �����Ұ̴ϱ�? �� ����� �޽��� �ڽ� �����
(
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo Set oShell = WScript.CreateObject ^("WSCript.shell"^)
echo X = Msgbox^("RCMenu�� �����Ұ̴ϱ�?", vbQuestion + vbYesNo + 4096, "RCMenu"^)
echo If X=vbYes then
echo Set txtFile = fso.CreateTextFile^("%temp%\yes.txt", true^)
echo oShell.Run "%0"

echo ELSEIf X=vbNo then

echo End If
) > "%temp%\ques.vbs"
:: �����ϰ� ����
start "" "%temp%\ques.vbs"
exit

:: �ִٸ�
:yes
rd /s /q "%systemdrive%\Program Files\RCMenu"
reg delete "HKCR\*\shell\RCMenu_���� �����" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_Windows Ŭ����" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_��� Ȯ��" /f
reg delete "HKCR\Directory\Background\shell\RCMenu_���� ���̱�" /f
echo X=msgbox ^("���� ����", vbQustion + vbOk + 4096 ,"RCMenu"^) > "%temp%\delete.vbs"
start "" "%temp%\delete.vbs"
del /f /q delete.vbs
del /f /q "%temp%\yes.txt"
exit