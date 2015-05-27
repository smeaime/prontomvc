































CREATE Procedure [dbo].[AcoMateriales_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoMateriales.IdMaterial, 
Materiales.Descripcion as Titulo
FROM DetalleAcoMateriales 
INNER JOIN AcoMateriales ON DetalleAcoMateriales.IdAcoMaterial = AcoMateriales.IdAcoMaterial 
INNER JOIN Materiales ON DetalleAcoMateriales.IdMaterial = Materiales.IdMaterial
WHERE AcoMateriales.IdRubro = @Rubro AND AcoMateriales.IdSubRubro = @Subrubro
































