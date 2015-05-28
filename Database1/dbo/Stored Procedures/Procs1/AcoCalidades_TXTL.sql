































CREATE Procedure [dbo].[AcoCalidades_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoCalidades.IdCalidad, 
Calidades.Descripcion as Titulo
FROM DetalleAcoCalidades 
INNER JOIN AcoCalidades ON DetalleAcoCalidades.IdAcoCalidad = AcoCalidades.IdAcoCalidad 
INNER JOIN Calidades ON DetalleAcoCalidades.IdCalidad = Calidades.IdCalidad
WHERE AcoCalidades.IdRubro = @Rubro AND AcoCalidades.IdSubRubro = @Subrubro
































