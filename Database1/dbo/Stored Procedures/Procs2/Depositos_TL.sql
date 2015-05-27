
CREATE Procedure [dbo].[Depositos_TL]
AS 
SELECT IdDeposito,Descripcion as Titulo
FROM Depositos 
ORDER by Descripcion
