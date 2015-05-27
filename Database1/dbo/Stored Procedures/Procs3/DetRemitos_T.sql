




























CREATE Procedure [dbo].[DetRemitos_T]
@IdDetalleRemito int
AS 
SELECT *
FROM DetalleRemitos
WHERE (IdDetalleRemito=@IdDetalleRemito)





























