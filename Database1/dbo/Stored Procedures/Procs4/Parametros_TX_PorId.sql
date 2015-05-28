


CREATE Procedure [dbo].[Parametros_TX_PorId]
@IdParametro int
AS 
SELECT *
FROM Parametros
WHERE (IdParametro=@IdParametro)


