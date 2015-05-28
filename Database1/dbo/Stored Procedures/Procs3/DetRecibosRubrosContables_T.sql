CREATE Procedure [dbo].[DetRecibosRubrosContables_T]

@IdDetalleReciboRubrosContables int

AS 

SELECT *
FROM DetalleRecibosRubrosContables
WHERE (IdDetalleReciboRubrosContables=@IdDetalleReciboRubrosContables)