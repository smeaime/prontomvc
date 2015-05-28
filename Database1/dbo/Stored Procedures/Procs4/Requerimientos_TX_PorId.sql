
















CREATE Procedure [dbo].[Requerimientos_TX_PorId]
@IdRequerimiento int
AS 
SELECT * 
FROM Requerimientos
WHERE (IdRequerimiento=@IdRequerimiento)

















