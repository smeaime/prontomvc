CREATE Procedure [dbo].[Articulos_TX_EquivalenciaPorIdUnidad]

@IdArticulo int,
@IdUnidad int

AS

SELECT *
FROM DetalleArticulosUnidades
WHERE IdArticulo=@IdArticulo and IdUnidad=@IdUnidad
