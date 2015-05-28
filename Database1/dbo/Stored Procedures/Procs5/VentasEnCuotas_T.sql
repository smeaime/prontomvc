















CREATE Procedure [dbo].[VentasEnCuotas_T]
@IdVentaEnCuotas int
AS 
SELECT *
FROM VentasEnCuotas
WHERE (IdVentaEnCuotas=@IdVentaEnCuotas)
















