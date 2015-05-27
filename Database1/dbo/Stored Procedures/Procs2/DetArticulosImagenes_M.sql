
CREATE Procedure [dbo].[DetArticulosImagenes_M]

@IdDetalleArticuloImagenes int,
@IdArticulo int,
@PathImagen varchar(200)

AS

UPDATE [DetalleArticulosImagenes]
SET 
 IdArticulo=@IdArticulo,
 PathImagen=@PathImagen
WHERE (IdDetalleArticuloImagenes=@IdDetalleArticuloImagenes)

RETURN(@IdDetalleArticuloImagenes)
