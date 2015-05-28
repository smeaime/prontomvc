































CREATE Procedure [dbo].[AcoMarcas_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoMarcas.IdMarca, 
Marcas.Descripcion as Titulo
FROM DetalleAcoMarcas 
INNER JOIN AcoMarcas ON DetalleAcoMarcas.IdAcoMarca = AcoMarcas.IdAcoMarca 
INNER JOIN Marcas ON DetalleAcoMarcas.IdMarca = Marcas.IdMarca
WHERE AcoMarcas.IdRubro = @Rubro AND AcoMarcas.IdSubRubro = @Subrubro
































