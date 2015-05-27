CREATE Procedure [dbo].[DetOrdenesPagoRendicionesFF_M]

@IdDetalleOrdenPagoRendicionesFF int,
@IdOrdenPago int,
@NumeroRendicion int

AS

UPDATE DetalleOrdenesPagoRendicionesFF
SET 
 IdOrdenPago=@IdOrdenPago,
 NumeroRendicion=@NumeroRendicion
WHERE (IdDetalleOrdenPagoRendicionesFF=@IdDetalleOrdenPagoRendicionesFF)

RETURN(@IdDetalleOrdenPagoRendicionesFF)