































CREATE Procedure [dbo].[AcoBiselados_TXTL]
@Rubro int,
@Subrubro int
AS 
SELECT 
DetalleAcoBiselados.IdBiselado, 
Biselados.Descripcion as Titulo
FROM DetalleAcoBiselados 
INNER JOIN AcoBiselados ON DetalleAcoBiselados.IdAcoBiselado = AcoBiselados.IdAcoBiselado 
INNER JOIN Biselados ON DetalleAcoBiselados.IdBiselado = Biselados.IdBiselado
WHERE AcoBiselados.IdRubro = @Rubro AND AcoBiselados.IdSubRubro = @Subrubro
































