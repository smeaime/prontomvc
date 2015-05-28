
CREATE Procedure [dbo].[DetArticulosImagenes_A]

@IdDetalleArticuloImagenes int output,
@IdArticulo int,
@PathImagen varchar(200)

AS 

INSERT INTO [DetalleArticulosImagenes]
(
 IdArticulo,
 PathImagen
)
VALUES
(
 @IdArticulo,
 @PathImagen
)

SELECT @IdDetalleArticuloImagenes=@@identity
RETURN(@IdDetalleArticuloImagenes)
