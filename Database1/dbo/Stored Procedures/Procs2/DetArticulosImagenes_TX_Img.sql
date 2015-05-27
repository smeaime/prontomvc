
CREATE PROCEDURE [dbo].[DetArticulosImagenes_TX_Img]

@IdArticulo int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00133'
SET @vector_T='00500'

SELECT
 DetImg.IdDetalleArticuloImagenes,
 DetImg.IdArticulo,
 DetImg.PathImagen,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosImagenes DetImg
WHERE (DetImg.IdArticulo = @IdArticulo)
ORDER BY DetImg.PathImagen
