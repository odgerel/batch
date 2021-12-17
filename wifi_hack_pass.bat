@ECHO OFF 

::netsh wlan show profiles > wlan_list.txt
::myVar=$(myCmd)

::for /f "delims=" %%A in ('netsh wlan show profiles') do set volume=%%A


::echo %volume%

::FOR /f "tokens=2 delims=:" %%i in ('netsh wlan show profiles') DO set var=%%i
::echo %var%

setlocal enableDelayedExpansion
set /a c=0
for /F delims^=^ eol^= %%r in ('netsh wlan show profiles') DO (
	set /A line[0] += 1 &set "line[!line[0]!]=%%r"
	set /A c+=1
		If !c! GEQ 7 ( 
			FOR /f "tokens=2 delims=:" %%i in ("%%r") DO (
			for /f "tokens=* delims= " %%a in ("%%i") do echo netsh wlan show profiles "%%a" key=clear
			)
		)
	)
for /f "tokens=* delims= " %%a in ("%str%") do set str=%%a

::FOR /f "tokens=2 delims=:" %%i in ("%%r") DO echo %%i name

REM set var=ipconfig
REM For /f %%a in ('%var%') DO echo %%a :: хувьсагч аван коммандыг ажиллуан гарсан зр дүнгээс хайот хийнэ.

REM set var=ipconfig
REM For /f %%a in ("%var%") DO echo %%a :: хувьсагч аван хайлт хийнэ

::echo !line[10]!

::FOR /L %%i IN (7 1 2) DO  (
::   call echo Name = %%obj[%%i].Name%%
::   call echo Value = %%obj[%%i].ID%%
::)


REM for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
REM if "%version%" == "6.0" echo Windows Vista.
REM if "%version%" == "6.1" echo Windows 7
REM if "%version%" == "6.2" echo Windows 8
REM if "%version%" == "6.3" echo Windows 8.1
REM if "%version%" == "10.0" echo Windows 10.