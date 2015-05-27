




























CREATE Procedure [dbo].[Rubros_TX_PorId]
@IdRubro smallint
AS 
SELECT*
FROM Rubros
WHERE (IdRubro=@IdRubro)






























