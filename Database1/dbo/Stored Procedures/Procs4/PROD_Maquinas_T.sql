
create Procedure PROD_Maquinas_T
@IdPROD_Maquina int
AS 
SELECT * 
FROM PROD_Maquinas
WHERE (IdPROD_Maquina=@IdPROD_Maquina)
