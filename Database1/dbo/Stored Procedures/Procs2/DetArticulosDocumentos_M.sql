
CREATE Procedure [dbo].[DetArticulosDocumentos_M]

@IdDetalleArticuloDocumentos int,
@IdArticulo int,
@PathDocumento varchar(200)

AS

UPDATE [DetalleArticulosDocumentos]
SET 
 IdArticulo=@IdArticulo,
 PathDocumento=@PathDocumento
WHERE (IdDetalleArticuloDocumentos=@IdDetalleArticuloDocumentos)

RETURN(@IdDetalleArticuloDocumentos)
