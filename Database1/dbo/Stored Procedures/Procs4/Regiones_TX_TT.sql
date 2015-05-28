CREATE Procedure [dbo].[Regiones_TX_TT]

@IdRegion int

AS 

SELECT *
FROM Regiones
WHERE (IdRegion=@IdRegion)