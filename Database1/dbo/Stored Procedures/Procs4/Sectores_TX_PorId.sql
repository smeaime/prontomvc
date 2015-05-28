




CREATE Procedure [dbo].[Sectores_TX_PorId]
@IdSector int
AS 
SELECT *
FROM Sectores
WHERE (IdSector=@IdSector)




