


CREATE PROCEDURE [dbo].[Articulos_TX_UnidadesHabilitadas]

@IdArticulo int

AS

DECLARE @IdUnidad int
SET @IdUnidad=IsNull((Select Top 1 Articulos.IdUnidad From Articulos Where Articulos.IdArticulo=@IdArticulo),0)

SELECT
 Unidades.IdUnidad,
 Unidades.Abreviatura as [Titulo]
FROM Unidades
WHERE Unidades.IdUnidad=@IdUnidad

UNION ALL

SELECT
 Det.IdUnidad,
 Unidades.Abreviatura as [Titulo]
FROM DetalleArticulosUnidades Det
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=Det.IdUnidad
WHERE (Det.IdArticulo = @IdArticulo)

ORDER BY [Titulo]


