




CREATE Procedure [dbo].[VentasEnCuotas_ModificarVencimientos]

@IdDetalleVentaEnCuotas int,
@FechaPrimerVencimiento datetime,
@FechaSegundoVencimiento datetime,
@FechaTercerVencimiento datetime

AS 

DECLARE @IdNotaDebito int
SET @IdNotaDebito=IsNull((Select Top 1 DetVta.IdNotaDebito
				From DetalleVentasEnCuotas DetVta
				Where DetVta.IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas),0)

UPDATE DetalleVentasEnCuotas
SET 
 FechaPrimerVencimiento=@FechaPrimerVencimiento,
 FechaSegundoVencimiento=@FechaSegundoVencimiento,
 FechaTercerVencimiento=@FechaTercerVencimiento
WHERE IdDetalleVentaEnCuotas=@IdDetalleVentaEnCuotas

UPDATE CuentasCorrientesDeudores
SET 
 FechaVencimiento=@FechaPrimerVencimiento
WHERE IdTipoComp=3 and IdComprobante=@IdNotaDebito





