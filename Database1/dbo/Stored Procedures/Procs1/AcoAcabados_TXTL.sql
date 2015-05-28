































CREATE Procedure [dbo].[AcoAcabados_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoAcabados.IdAcabado, 
Acabados.Descripcion as Titulo
FROM DetalleAcoAcabados 
INNER JOIN AcoAcabados ON DetalleAcoAcabados.IdAcoAcabado = AcoAcabados.IdAcoAcabado 
INNER JOIN Acabados ON DetalleAcoAcabados.IdAcabado = Acabados.IdAcabado
WHERE AcoAcabados.IdRubro = @Rubro AND AcoAcabados.IdSubRubro = @Subrubro
































