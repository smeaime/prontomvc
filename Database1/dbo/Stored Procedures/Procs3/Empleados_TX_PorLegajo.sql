CREATE Procedure [dbo].[Empleados_TX_PorLegajo]

@Legajo int 

AS 

SELECT *
FROM Empleados
WHERE (Legajo=@Legajo)