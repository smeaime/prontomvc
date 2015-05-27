












CREATE Procedure [dbo].[DetVentasEnCuotas_E]
@IdDetalleVentaEnCuotas int  AS 
Delete [DetalleVentasEnCuotas]
Where (IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas)













