





























CREATE Procedure [dbo].[DetAcoBiselados_T]
@IdDetalleAcoBiselado int
AS 
SELECT *
FROM DetalleAcoBiselados
where (IdDetalleAcoBiselado=@IdDetalleAcoBiselado)






























