































CREATE Procedure [dbo].[AcoTipos_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoTipos.IdTipo, 
Tipos.Descripcion as Titulo
FROM DetalleAcoTipos 
INNER JOIN AcoTipos ON DetalleAcoTipos.IdAcoTipo = AcoTipos.IdAcoTipo 
INNER JOIN Tipos ON DetalleAcoTipos.IdTipo = Tipos.IdTipo
WHERE AcoTipos.IdRubro = @Rubro AND AcoTipos.IdSubRubro = @Subrubro
































