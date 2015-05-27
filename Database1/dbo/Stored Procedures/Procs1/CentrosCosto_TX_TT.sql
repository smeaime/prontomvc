





























CREATE Procedure [dbo].[CentrosCosto_TX_TT]
@IdCentroCosto int
AS 
Select *
FROM CentrosCosto
where (IdCentroCosto=@IdCentroCosto)






























