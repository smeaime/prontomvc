
CREATE Procedure [dbo].[Codigos_TX_TT]

@IdCodigo int

AS 

SELECT *
FROM Codigos
WHERE (IdCodigo=@IdCodigo)
