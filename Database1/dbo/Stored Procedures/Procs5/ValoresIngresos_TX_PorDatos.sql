































CREATE Procedure [dbo].[ValoresIngresos_TX_PorDatos]
@FechaIngreso datetime,
@Importe numeric(18,2)
AS 
Select * 
FROM ValoresIngresos
WHERE FechaIngreso=@FechaIngreso And Importe=@Importe
































