
CREATE Procedure [dbo].[GastosFletes_T]

@IdGastoFlete int

AS 

SELECT *
FROM GastosFletes
WHERE (IdGastoFlete=@IdGastoFlete)
