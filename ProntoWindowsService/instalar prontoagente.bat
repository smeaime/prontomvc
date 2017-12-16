rem ejecutar como administrador!!!!!
cd E:\Sites\ProntoAgente\

net stop prontoagente 
pause 

E:\Sites\ProntoAgente\prontoagente --uninstall
pause 

E:\Sites\ProntoAgente\prontoagente --install
pause

net start prontoagente 
pause

net stop prontoagente 
pause 

net start prontoagente 
pause