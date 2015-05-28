































CREATE Procedure [dbo].[AcoCodigos_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoCodigos.IdCodigo, 
Codigos.Descripcion as Titulo
FROM DetalleAcoCodigos 
INNER JOIN AcoCodigos ON DetalleAcoCodigos.IdAcoCodigo = AcoCodigos.IdAcoCodigo 
INNER JOIN Codigos ON DetalleAcoCodigos.IdCodigo = Codigos.IdCodigo
WHERE AcoCodigos.IdRubro = @Rubro AND AcoCodigos.IdSubRubro = @Subrubro
































