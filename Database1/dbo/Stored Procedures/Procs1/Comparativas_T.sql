





























CREATE Procedure [dbo].[Comparativas_T]
@IdComparativa int
AS 
SELECT * 
FROM Comparativas
WHERE (IdComparativa=@IdComparativa)






























