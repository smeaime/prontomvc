CREATE Procedure [dbo].[DetRecibosRubrosContables_E]

@IdDetalleReciboRubrosContables int

AS

DELETE DetalleRecibosRubrosContables
WHERE (IdDetalleReciboRubrosContables=@IdDetalleReciboRubrosContables)