
CREATE Procedure [dbo].[DetObrasDestinos_E]

@IdDetalleObraDestino int  

AS 

DELETE [DetalleObrasDestinos]
WHERE (IdDetalleObraDestino=@IdDetalleObraDestino)
