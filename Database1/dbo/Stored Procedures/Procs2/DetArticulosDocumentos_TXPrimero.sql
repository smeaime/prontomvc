
CREATE PROCEDURE [dbo].[DetArticulosDocumentos_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00133'
SET @vector_T='00500'

SELECT TOP 1
 DetDoc.IdDetalleArticuloDocumentos,
 DetDoc.IdArticulo,
 DetDoc.PathDocumento as [Documento],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosDocumentos DetDoc
