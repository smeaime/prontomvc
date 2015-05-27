create Procedure PROD_Maquinas_E
@IdPROD_Maquina int
AS 
DELETE [PROD_Maquinas]
WHERE (IdPROD_Maquina=@IdPROD_Maquina)


