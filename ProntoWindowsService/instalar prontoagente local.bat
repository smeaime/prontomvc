rem ejecutar como administrador!!!!!
cd C:\Users\Mariano\Documents\pronto\ProntoWindowsService\bin\Debug

net stop prontoagente 
pause 

prontoagente --uninstall
pause 

prontoagente --install
pause

net start prontoagente 
pause