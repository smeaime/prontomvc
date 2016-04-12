set origen=C:\Users\Administrador\Documents\bdl\Marcalba\
set pendientes=C:\Users\Administrador\Documents\bdl\Marcalba\Pendientes\
set enviados=C:\Users\Administrador\Documents\bdl\Marcalba\Enviados\
set WinSCP="C:\Program Files (x86)\WinSCP\WinSCP.com"
set FTP=ftp://bdl01:Baemoo0ahngu@190.12.108.166
set FTPdir=/Backup/
set smail=C:\Users\Administrador\Documents\bdl\Marcalba\sendmail\sendEmail.exe
set casilla=mscalella911@gmail.com;soporte@bdlconsultores.com.ar 


 
move "%origen%*.*"  "%pendientes%"

%WinSCP% /log=c:\winscp.log /command "open %FTP%"   "put %pendientes%*.* %FTPdir%"   "exit"
echo %errorlevel%

if %ERRORLEVEL% neq 0 goto error

move  "%pendientes%*.*"  "%enviados%"

rem pause

exit /b 0


 
:error
   echo Failure Reason Given is %errorlevel%
   rem enviar mail. usar Blat?
   rem %BLAT% -to mscalella911@gmail.com  -server smtp.gmail.com -f batch_script@example.com -subject "subject" -body "body"
   %smail% -f soporte@bdlconsultores.com.ar  -t %casilla% -u FTP Marcalba error -m Hubo un error al mandar por ftp! -s smtp.gmail.com:587 -xu ProntoWebMail@gmail.com -xp 50TriplesdJQ -o tls=yes

rem   pause
exit /b 1