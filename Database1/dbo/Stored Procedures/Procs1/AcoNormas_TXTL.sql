































CREATE Procedure [dbo].[AcoNormas_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoNormas.IdNorma, 
Normas.Descripcion as Titulo
FROM DetalleAcoNormas 
INNER JOIN AcoNormas ON DetalleAcoNormas.IdAcoNorma = AcoNormas.IdAcoNorma 
INNER JOIN Normas ON DetalleAcoNormas.IdNorma = Normas.IdNorma
WHERE AcoNormas.IdRubro = @Rubro AND AcoNormas.IdSubRubro = @Subrubro
































