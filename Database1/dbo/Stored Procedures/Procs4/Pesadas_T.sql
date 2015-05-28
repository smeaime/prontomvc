
CREATE  Procedure [dbo].[Pesadas_T]

@idPesada int

AS 

SELECT *
FROM Pesadas p
WHERE (p.IdPesada=@IdPesada)
