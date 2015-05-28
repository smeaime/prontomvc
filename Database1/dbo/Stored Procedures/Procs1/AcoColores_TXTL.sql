































CREATE Procedure [dbo].[AcoColores_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoColores.IdColor, 
Colores.Descripcion as Titulo
FROM DetalleAcoColores 
INNER JOIN AcoColores ON DetalleAcoColores.IdAcoColor = AcoColores.IdAcoColor 
INNER JOIN Colores ON DetalleAcoColores.IdColor = Colores.IdColor
WHERE AcoColores.IdRubro = @Rubro AND AcoColores.IdSubRubro = @Subrubro
































