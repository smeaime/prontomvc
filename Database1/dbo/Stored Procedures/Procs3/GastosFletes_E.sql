
CREATE Procedure [dbo].[GastosFletes_E]

@IdGastoFlete int 

AS 

DELETE GastosFletes
WHERE (IdGastoFlete=@IdGastoFlete)
