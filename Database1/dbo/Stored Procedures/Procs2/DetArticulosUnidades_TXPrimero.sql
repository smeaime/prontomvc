
CREATE PROCEDURE [dbo].[DetArticulosUnidades_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='001133'
SET @vector_T='005500'

SELECT TOP 1
 Det.IdDetalleArticuloUnidades,
 Det.IdArticulo,
 Unidades.Abreviatura as [Un.],
 Det.Equivalencia as [Equiv.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleArticulosUnidades Det
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
