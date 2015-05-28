































CREATE Procedure [dbo].[AcoSeries_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoSeries.IdSerie, 
Series.Descripcion as Titulo
FROM DetalleAcoSeries 
INNER JOIN AcoSeries ON DetalleAcoSeries.IdAcoSerie = AcoSeries.IdAcoSerie 
INNER JOIN Series ON DetalleAcoSeries.IdSerie = Series.IdSerie
WHERE AcoSeries.IdRubro = @Rubro AND AcoSeries.IdSubRubro = @Subrubro
































