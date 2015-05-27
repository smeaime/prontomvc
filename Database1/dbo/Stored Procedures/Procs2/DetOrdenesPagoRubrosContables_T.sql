CREATE Procedure [dbo].[DetOrdenesPagoRubrosContables_T]

@IdDetalleOrdenPagoRubrosContables int

AS 

SELECT *
FROM DetalleOrdenesPagoRubrosContables
WHERE (IdDetalleOrdenPagoRubrosContables=@IdDetalleOrdenPagoRubrosContables)