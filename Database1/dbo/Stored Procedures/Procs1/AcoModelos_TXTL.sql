































CREATE Procedure [dbo].[AcoModelos_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoModelos.IdModelo, 
Modelos.Descripcion as Titulo
FROM DetalleAcoModelos 
INNER JOIN AcoModelos ON DetalleAcoModelos.IdAcoModelo = AcoModelos.IdAcoModelo 
INNER JOIN Modelos ON DetalleAcoModelos.IdModelo = Modelos.IdModelo
WHERE AcoModelos.IdRubro = @Rubro AND AcoModelos.IdSubRubro = @Subrubro
































