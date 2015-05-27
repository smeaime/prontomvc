
CREATE Procedure [dbo].[TarifasFletes_T]

@IdTarifaFlete int

AS 

SELECT *
FROM TarifasFletes
WHERE (IdTarifaFlete=@IdTarifaFlete)
