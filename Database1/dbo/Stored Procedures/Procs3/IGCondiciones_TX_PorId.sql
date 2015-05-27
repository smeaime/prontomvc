



























CREATE Procedure [dbo].[IGCondiciones_TX_PorId]
@IdIGCondicion int
AS 
SELECT *
FROM IGCondiciones
WHERE (IdIGCondicion=@IdIGCondicion)




























