@echo off
setlocal enableextensions enabledelayedexpansion
title 사양 확인_RCMENU

REM CPU
for /f "tokens=2 delims==" %%a in ('wmic CPU get Name /format:list') do set cpu_name=%%a 
for /f "tokens=2 delims==" %%a in ('wmic CPU get MaxClockSpeed /format:list 2^>nul') do set cpu_hz=%%a 
set clock_1=%cpu_hz:~0,1%
set clock_2=%cpu_hz:~1,2%

for /f "tokens=2 delims==" %%a in ('wmic ComputerSystem get NumberofLogicalProcessors /format:list 2^>nul') do set lo_processors=%%a 
if "%lo_processors%"=="" (for /f "tokens=2 delims==" %%a in ('wmic ComputerSystem get NumberofProcessors /format:list 2^>nul') do set lo_processors=%%a )

REM Memory
for /f "tokens=2 delims==" %%a in ('wmic computersystem get totalphysicalmemory /format:list') do set mem=%%a
set /a t_mem=%mem:~0,-4% /1050

for /f "tokens=2 delims= " %%a in ('wmic MemoryChip get Tag^, Capacity^') do (
	set /a ram_count=!ram_count!+1
)
set /a ram_count=%ram_count%-1

for /f "tokens=2-3 delims= " %%a in ('wmic MemPhysical get Location^, MaxCapacity^, MemoryDevices^') do (
	set m_bank=%%b
	set m_mem=%%a
	)
set /a max_mem=!m_mem! /1024 /1024


REM Mainboard
for /f "tokens=2-3 delims= " %%a in ('wmic baseboard get Caption^, Manufacturer^, Product^') do (
	set mb_p=%%a
	set mb_model=%%b
	)

REM VGA
for /f "tokens=2 delims==" %%a in ('wmic path Win32_VideoController get AdapterRAM /format:list') do set v_ram=%%a
for /f "tokens=2 delims==" %%a in ('wmic path Win32_VideoController get Name /format:list') do set vga_p=%%a
set /a v_ram=%v_ram:~0,-4% /1050

REM HDD
for /f "tokens=2-3 delims= " %%a in ('wmic logicaldisk get filesystem^, name^, size^| find "NTFS"') do (
	set size_byte=%%b
	set len=0

	REM TB 인지 아닌지 검사
	for /L %%i in (0,1,15) do (
		set len_1=!size_byte:~%%i,1!
		if "!len_1!" NEQ "" set /a len=!len!+1
		if !len!==13 (set /a size_GB=!size_byte:~0,-4!/1048576&set size_GB=!size_GB!0)else (set /a size_GB=!size_byte:~0,-3!/1048576)
		if !len!==14 (set /a size_GB=!size_byte:~0,-5!/1048576&set size_GB=!size_GB!00)else (set /a size_GB=!size_byte:~0,-3!/1048576)
		if !len!==15 (set /a size_GB=!size_byte:~0,-6!/1048576&set size_GB=!size_GB!000)else (set /a size_GB=!size_byte:~0,-3!/1048576)
		) 2>nul
	set label=%%a
	set hdd_cap=!hdd_cap!!label:~0,1!!size_GB! 
	)

cls
echo.  CPU NAME	: %cpu_name%
echo.  CPU CLOCK	: %clock_1%.%clock_2%GHz * %lo_processors%
echo.  TOTAL MEMORY	: %t_mem% MB (%mem% B)
echo.  RAM SLOT	: %ram_count% / %m_bank%
echo.  MAX MEMORY	: %max_mem% GB (%m_mem% KB)
echo.  MOTHERBOARD	: %mb_p% %mb_model% MB
echo.  GRAPHIC CARD	: %vga_p% (%v_ram% MB)
echo.  HDD SIZE	: %hdd_cap%
:end
endlocal
pause