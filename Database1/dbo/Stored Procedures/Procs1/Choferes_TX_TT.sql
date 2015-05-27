
CREATE Procedure [dbo].[Choferes_TX_TT]

@IdChofer int

AS 

SELECT *
FROM Choferes
WHERE (IdChofer=@IdChofer)
