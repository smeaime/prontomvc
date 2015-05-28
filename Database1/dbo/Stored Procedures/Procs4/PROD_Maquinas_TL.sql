
CREATE Procedure PROD_Maquinas_TL
AS 
Select 
IdPROD_Maquina, '' as [Titulo]
-- Convert(varchar,Numero) + ' del ' + Convert(varchar,Fecha,103) as [Titulo]
FROM PROD_Maquinas 
--WHERE PresupuestoSeleccionado is not null
--ORDER by Numero desc

