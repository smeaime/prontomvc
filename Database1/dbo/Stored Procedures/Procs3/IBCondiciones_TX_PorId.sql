
























CREATE Procedure [dbo].[IBCondiciones_TX_PorId]
@IdIBCondicion int
AS 
SELECT *
FROM IBCondiciones
WHERE (IdIBCondicion=@IdIBCondicion)
























