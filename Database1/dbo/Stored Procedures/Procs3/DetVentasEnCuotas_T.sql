












CREATE Procedure [dbo].[DetVentasEnCuotas_T]
@IdDetalleVentaEnCuotas int
AS 
SELECT *
FROM [DetalleVentasEnCuotas]
WHERE (IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas)













