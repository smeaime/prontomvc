





























CREATE Procedure [dbo].[Formas_T]
@IdForma smallint
AS 
SELECT *
FROM Formas
where (IdForma=@IdForma)






























