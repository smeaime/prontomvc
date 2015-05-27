CREATE PROCEDURE [dbo].[DetRubrosContables_TXDet]

@IdRubroContable int

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011133'
SET @vector_T='029200'

SELECT 
 Det.IdDetalleRubroContable as [IdDetalleRubroContable],
 Obras.Descripcion as [Obra],
 Det.IdDetalleRubroContable as [IdDet],
 Det.Porcentaje as [%],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleRubrosContables Det
LEFT OUTER JOIN RubrosContables ON Det.IdRubroContable = RubrosContables.IdRubroContable
LEFT OUTER JOIN Obras ON Obras.IdObra = Det.IdObra
WHERE (Det.IdRubroContable = @IdRubroContable)
ORDER BY Obras.Descripcion