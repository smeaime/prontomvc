CREATE PROCEDURE [dbo].[DetArticulosUnidades_TX_Uni]

@IdArticulo int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001133'
SET @vector_T='001000'

SELECT
 Det.IdDetalleArticuloUnidades,
 Det.IdArticulo,
 Unidades.Abreviatura as [Un.],
 Det.Equivalencia as [Equiv.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosUnidades Det
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
WHERE (Det.IdArticulo = @IdArticulo)
ORDER BY Unidades.Abreviatura