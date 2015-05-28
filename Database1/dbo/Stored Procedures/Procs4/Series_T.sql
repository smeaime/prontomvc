





























CREATE Procedure [dbo].[Series_T]
@IdSerie smallint
AS 
SELECT *
FROM Series
where (IdSerie=@IdSerie)






























