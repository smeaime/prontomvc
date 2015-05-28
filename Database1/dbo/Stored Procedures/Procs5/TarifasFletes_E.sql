
CREATE Procedure [dbo].[TarifasFletes_E]

@IdTarifaFlete int 

AS 

DELETE TarifasFletes
WHERE (IdTarifaFlete=@IdTarifaFlete)
