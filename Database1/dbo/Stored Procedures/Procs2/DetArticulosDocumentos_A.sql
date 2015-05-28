
CREATE Procedure [dbo].[DetArticulosDocumentos_A]

@IdDetalleArticuloDocumentos int output,
@IdArticulo int,
@PathDocumento varchar(200)

AS

INSERT INTO [DetalleArticulosDocumentos]
(
 IdArticulo,
 PathDocumento
)
VALUES
(
 @IdArticulo,
 @PathDocumento
)

SELECT @IdDetalleArticuloDocumentos=@@identity
RETURN(@IdDetalleArticuloDocumentos)
