CREATE Procedure [dbo].[DetOrdenesPagoImpuestos_T]

@IdDetalleOrdenPagoImpuestos int

AS 

SELECT *
FROM DetalleOrdenesPagoImpuestos
WHERE (IdDetalleOrdenPagoImpuestos=@IdDetalleOrdenPagoImpuestos)