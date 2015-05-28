































CREATE Procedure [dbo].[AcoGrados_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoGrados.IdGrado, 
Grados.Descripcion as Titulo
FROM DetalleAcoGrados 
INNER JOIN AcoGrados ON DetalleAcoGrados.IdAcoGrado = AcoGrados.IdAcoGrado 
INNER JOIN Grados ON DetalleAcoGrados.IdGrado = Grados.IdGrado
WHERE AcoGrados.IdRubro = @Rubro AND AcoGrados.IdSubRubro = @Subrubro
































