CREATE Procedure [dbo].[Rubros_T]

@IdRubro int

AS 

SELECT*
FROM Rubros
WHERE (IdRubro=@IdRubro)