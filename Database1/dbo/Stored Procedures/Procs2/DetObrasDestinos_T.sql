
CREATE Procedure [dbo].[DetObrasDestinos_T]

@IdDetalleObraDestino int

AS 

SELECT *
FROM [DetalleObrasDestinos]
WHERE (IdDetalleObraDestino=@IdDetalleObraDestino)
