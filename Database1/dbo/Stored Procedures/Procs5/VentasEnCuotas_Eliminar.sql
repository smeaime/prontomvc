




CREATE Procedure [dbo].[VentasEnCuotas_Eliminar]

@IdVentaEnCuotas int

AS 

DELETE FROM DetalleVentasEnCuotas
WHERE IdVentaEnCuotas=@IdVentaEnCuotas

DELETE FROM VentasEnCuotas
WHERE IdVentaEnCuotas=@IdVentaEnCuotas





