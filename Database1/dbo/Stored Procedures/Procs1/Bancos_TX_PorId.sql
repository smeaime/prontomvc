










CREATE Procedure [dbo].[Bancos_TX_PorId]
@IdBanco int
AS 
SELECT *
FROM Bancos
WHERE (IdBanco=@IdBanco)











