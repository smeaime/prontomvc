





























CREATE Procedure [dbo].[Series_TX_TT]
@IdSerie smallint
AS 
Select 
IdSerie,
Descripcion,
Abreviatura
FROM Series
where (IdSerie=@IdSerie)
order by Descripcion






























