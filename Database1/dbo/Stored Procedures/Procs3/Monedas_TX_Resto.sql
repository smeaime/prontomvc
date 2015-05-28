




CREATE Procedure [dbo].[Monedas_TX_Resto]

AS 

SET NOCOUNT ON
DECLARE @IdMonedaPesos int,@IdMonedaDolar int,@IdMonedaEuro int
SET @IdMonedaPesos=(Select Parametros.IdMoneda From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaDolar=(Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1)
SET @IdMonedaEuro=(Select Parametros.IdMonedaEuro From Parametros Where Parametros.IdParametro=1)
SET NOCOUNT OFF

SELECT 
 IdMoneda,
 Nombre as [Titulo]
FROM Monedas 
WHERE IdMoneda<>@IdMonedaPesos and IdMoneda<>@IdMonedaDolar and IdMoneda<>@IdMonedaEuro
ORDER by Nombre




