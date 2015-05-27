





























CREATE Procedure [dbo].[DetAcoSeries_T]
@IdDetalleAcoSerie int
AS 
SELECT *
FROM DetalleAcoSeries
where (IdDetalleAcoSerie=@IdDetalleAcoSerie)






























