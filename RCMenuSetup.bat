@echo off
 >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

 if '%errorlevel%' NEQ '0' (
     echo Requesting administrative privileges...
     goto UACPrompt
 ) else ( goto gotAdmin )

:UACPrompt
     echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
     echo UAC.ShellExecute "%~s0", "", "", "runas", 0 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
     exit /B

:gotAdmin
     if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
     pushd "%CD%"
     CD /D "%~dp0"

if exist "%temp%\yes.txt" goto yes

:no
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs"
(
echo Set fso = CreateObject^("Scripting.FileSystemObject"^)
echo Set oShell = WScript.CreateObject ^("WSCript.shell"^)
echo X = Msgbox^("RCMenu�� ��ġ �Ұ̴ϱ�?", vbQuestion + vbYesNo + 4096, "RCMenu"^)
echo If X=vbYes then
echo Set txtFile = fso.CreateTextFile^("%temp%\yes.txt", true^)
echo oShell.Run ^"%0^"

echo ELSEIf X=vbNo then

echo End If
) > "%temp%\ques.vbs"
start "" "%temp%\ques.vbs"
exit

:yes
:: yes.txt ����, ques.vbs ����
del /f /q "%temp%\yes.txt"
del /f /q "%temp%\ques.vbs
"
:: %systemdrive%\Program Files�� RCMenu ���� �����
md "%systemdrive%\Program Files\RCMenu"
:: %systemdrive%\icon���� �����
md "%systemdrive%\icon"

powershell -Command "Invoke-Webrequest" "https://cdn.discordapp.com/attachments/1098914318571024465/1167054646284648509/RCMenuRemove.bat" -outfile "%userprofile%\desktop\RCMenuRemove.bat"

powershell -Command "Invoke-Webrequest" "https://cdn.discordapp.com/attachments/1098914318571024465/1167042384958324827/desktopclear.bat" -outfile "%systemdrive%\Program` Files\RCMenu\desktopclear.bat"


curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/rcmenu.ico" > "%systemdrive%\icons\rcmenu.ico"

curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/cleaner.bat" > "%systemdrive%\Program Files\RCMenu\cleaner.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/HideFile.bat" > "%systemdrive%\Program Files\RCMenu\HideFile.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/ShowFile.bat" > "%systemdrive%\Program Files\RCMenu\ShowFile.bat"
curl "https://raw.githubusercontent.com/BAtchfiler0/RCMenu/main/CheckSpec.bat" > "%systemdrive%\Program Files\RCMenu\CheckSpec.bat"

reg add "HKCR\*\shell\RCMenu_���� �����\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\HideFile.bat %%1" /f
reg add "HKCR\Directory\Background\shell\RCMenu_Windows Ŭ����\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\cleaner.bat" /f
reg add "HKCR\Directory\Background\shell\RCMenu_���� ���̱�\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\ShowFile.bat" /f
reg add "HKCR\Directory\Background\shell\RCMenu_��� Ȯ��\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\CheckSpec.bat" /f
reg add "HKCR\Directory\Background\shell\RCMenu_����ȭ�� ����\command" /ve /t REG_SZ /d "%systemdrive%\Program Files\RCMenu\desktopclear.bat" /f

reg add "HKCR\Directory\Background\shell\RCMenu_Windows Ŭ����" /v "Icon" /t REG_SZ /d "C:\icons\rcmenu.ico" /f
reg add "HKCR\Directory\Background\shell\RCMenu_���� ���̱�" /v "Icon" /t REG_SZ /d "C:\icons\rcmenu.ico" /f
reg add "HKCR\Directory\Background\shell\RCMenu_��� Ȯ��" /v "Icon" /t REG_SZ /d "C:\icons\rcmenu.ico" /f
reg add "HKCR\Directory\Background\shell\RCMenu_����ȭ�� ����" /v "Icon" /t REG_SZ /d "C:\icons\rcmenu.ico" /f
reg add "HKCR\*\shell\RCMenu_���� �����" /v "Icon" /t REG_SZ /d "C:\icons\rcmenu.ico" /f
cls
echo X=msgbox ^("��ġ ����", vbQustion + vbOk + 4096 ,"RCMenu"^) > "%temp%\delete.vbs"
start "" "%temp%\delete.vbs"

exit