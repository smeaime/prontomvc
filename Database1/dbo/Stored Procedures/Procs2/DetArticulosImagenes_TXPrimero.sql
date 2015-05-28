
CREATE PROCEDURE [dbo].[DetArticulosImagenes_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00133'
SET @vector_T='00500'

SELECT TOP 1
 DetImg.IdDetalleArticuloImagenes,
 DetImg.IdArticulo,
 DetImg.PathImagen,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosImagenes DetImg
