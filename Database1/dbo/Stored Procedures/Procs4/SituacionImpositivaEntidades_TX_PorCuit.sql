CREATE Procedure [dbo].[SituacionImpositivaEntidades_TX_PorCuit]

@Cuit varchar(11)

AS 

SELECT * 
FROM SituacionImpositivaEntidades
WHERE Cuit=@Cuit