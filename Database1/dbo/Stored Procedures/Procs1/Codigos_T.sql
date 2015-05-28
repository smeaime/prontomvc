
CREATE Procedure [dbo].[Codigos_T]

@IdCodigo int

AS 

SELECT*
FROM Codigos
WHERE (IdCodigo=@IdCodigo)
