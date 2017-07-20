cd C:\Users\Administrador\Documents\bdl\pronto\ProntoWindowsService\bin\Debug


net stop prontoagente 
pause 

prontoagente --uninstall
pause 

prontoagente --install
pause

net start prontoagente 
pause