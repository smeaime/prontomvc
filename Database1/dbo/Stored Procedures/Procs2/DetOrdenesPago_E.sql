





















CREATE Procedure [dbo].[DetOrdenesPago_E]
@IdDetalleOrdenPago int
AS 
DELETE DetalleOrdenesPago
WHERE (IdDetalleOrdenPago=@IdDetalleOrdenPago)





















