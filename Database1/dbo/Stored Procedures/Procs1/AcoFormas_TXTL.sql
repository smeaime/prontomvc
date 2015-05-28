































CREATE Procedure [dbo].[AcoFormas_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoFormas.IdForma, 
Formas.Descripcion as Titulo
FROM DetalleAcoFormas 
INNER JOIN AcoFormas ON DetalleAcoFormas.IdAcoForma = AcoFormas.IdAcoForma 
INNER JOIN Formas ON DetalleAcoFormas.IdForma = Formas.IdForma
WHERE AcoFormas.IdRubro = @Rubro AND AcoFormas.IdSubRubro = @Subrubro
































