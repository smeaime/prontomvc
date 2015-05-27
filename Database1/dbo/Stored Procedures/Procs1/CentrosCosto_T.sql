





























CREATE Procedure [dbo].[CentrosCosto_T]
@IdCentroCosto int
AS 
SELECT *
FROM CentrosCosto
where (IdCentroCosto=@IdCentroCosto)






























