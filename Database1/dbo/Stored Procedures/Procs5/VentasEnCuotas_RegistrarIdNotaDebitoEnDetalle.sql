






CREATE Procedure [dbo].[VentasEnCuotas_RegistrarIdNotaDebitoEnDetalle]

@IdDetalleVentaEnCuotas int,
@IdNotaDebito int

AS 

UPDATE DetalleVentasEnCuotas
SET 
 IdNotaDebito=@IdNotaDebito
WHERE IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas






