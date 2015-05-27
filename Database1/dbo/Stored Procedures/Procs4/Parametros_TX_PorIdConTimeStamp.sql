


CREATE Procedure [dbo].[Parametros_TX_PorIdConTimeStamp]
@IdParametro int
AS 
SELECT *, Convert(integer,FechaTimeStamp) as [FechaTimeStamp1]
FROM Parametros
WHERE (IdParametro=@IdParametro)


