CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_M]

@IdDetalleOrdenPagoRubrosContables int,
@IdOrdenPago int,
@IdRubroContable int,
@Importe numeric(18,2)

AS

UPDATE DetalleOrdenesPagoRubrosContables
SET 
 IdOrdenPago=@IdOrdenPago,
 IdRubroContable=@IdRubroContable,
 Importe=@Importe
WHERE (IdDetalleOrdenPagoRubrosContables=@IdDetalleOrdenPagoRubrosContables)

RETURN(@IdDetalleOrdenPagoRubrosContables)