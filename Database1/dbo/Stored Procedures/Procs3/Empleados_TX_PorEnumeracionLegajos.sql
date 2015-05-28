CREATE Procedure [dbo].[Empleados_TX_PorEnumeracionLegajos]

@Legajos varchar(4000)

AS 

SELECT *
FROM Empleados 
WHERE Patindex('%('+Convert(varchar,Empleados.Legajo)+')%', @Legajos)<>0