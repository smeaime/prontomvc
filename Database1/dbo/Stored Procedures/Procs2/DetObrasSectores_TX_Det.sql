
CREATE PROCEDURE [dbo].[DetObrasSectores_TX_Det]

@IdObra int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0133'
SET @vector_T='0433'

SELECT
 Det.IdDetalleObraSector,
 Det.Descripcion as [Sector],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasSectores Det
WHERE (Det.IdObra = @IdObra)
ORDER by Det.Descripcion
