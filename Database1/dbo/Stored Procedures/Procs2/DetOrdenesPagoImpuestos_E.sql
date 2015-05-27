





















CREATE Procedure [dbo].[DetOrdenesPagoImpuestos_E]
@IdDetalleOrdenPagoImpuestos int
AS 
DELETE DetalleOrdenesPagoImpuestos
WHERE (IdDetalleOrdenPagoImpuestos=@IdDetalleOrdenPagoImpuestos)






















