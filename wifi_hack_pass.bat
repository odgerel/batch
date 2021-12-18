@ECHO OFF 

setlocal enableDelayedExpansion
set /a c=0
for /F delims^=^ eol^= %%r in ('netsh wlan show profiles') DO (
	set /A line[0] += 1 &set "line[!line[0]!]=%%r"
	set /A c+=1
		If !c! GEQ 7 ( 
			FOR /f "tokens=2 delims=:" %%i in ("%%r") DO (
			for /f "tokens=* delims= " %%a in ("%%i") do (
				set /a c1=0
				for /F delims^=^ eol^= %%s in ('netsh wlan show profiles "%%a" key"="clear') DO (
					set /A c1+=1
					If !c1! == 28 (
						FOR /f "tokens=2 delims=:" %%m in ("%%s") DO for /f "tokens=* delims= " %%p in ("%%m") do echo %%a : %%p >> WIFI_PASSWORDS.txt
						)
					)
				
				)
			)
		)
	)
