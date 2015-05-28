CREATE Procedure [dbo].[DetOrdenesPagoRendicionesFF_E]

@IdDetalleOrdenPagoRendicionesFF int

AS

DELETE DetalleOrdenesPagoRendicionesFF
WHERE (IdDetalleOrdenPagoRendicionesFF=@IdDetalleOrdenPagoRendicionesFF)