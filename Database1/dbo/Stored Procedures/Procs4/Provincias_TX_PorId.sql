












CREATE Procedure [dbo].[Provincias_TX_PorId]
@IdProvincia tinyint 
AS 
SELECT *
FROM Provincias
WHERE (IdProvincia=@IdProvincia)












