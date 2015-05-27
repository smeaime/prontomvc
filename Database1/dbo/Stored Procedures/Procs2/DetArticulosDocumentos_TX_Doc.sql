
CREATE PROCEDURE [dbo].[DetArticulosDocumentos_TX_Doc]

@IdArticulo int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00133'
SET @vector_T='00500'

SELECT
 DetDoc.IdDetalleArticuloDocumentos,
 DetDoc.IdArticulo,
 DetDoc.PathDocumento as [Documento],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosDocumentos DetDoc
WHERE (DetDoc.IdArticulo = @IdArticulo)
ORDER by DetDoc.PathDocumento
