





























CREATE Procedure [dbo].[DetAcoHHTareas_T]
@IdDetalleAcoHHTarea int
AS 
SELECT *
FROM DetalleAcoHHTareas
where (IdDetalleAcoHHTarea=@IdDetalleAcoHHTarea)






























