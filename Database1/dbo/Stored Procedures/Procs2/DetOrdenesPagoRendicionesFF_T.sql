CREATE Procedure [dbo].[DetOrdenesPagoRendicionesFF_T]

@IdDetalleOrdenPagoRendicionesFF int

AS 

SELECT *
FROM DetalleOrdenesPagoRendicionesFF
WHERE (IdDetalleOrdenPagoRendicionesFF=@IdDetalleOrdenPagoRendicionesFF)