
CREATE Procedure [dbo].[Monedas_TX_MonedasStandarParaCombo]

AS 

SET NOCOUNT ON

DECLARE @IdMonedaPesos int,@IdMonedaDolar int

SET @IdMonedaPesos=IsNull((Select Parametros.IdMoneda From Parametros Where Parametros.IdParametro=1),1)
SET @IdMonedaDolar=IsNull((Select Parametros.IdMonedaDolar From Parametros Where Parametros.IdParametro=1),2)

SET NOCOUNT OFF

SELECT 
 IdMoneda,
 Nombre as [Titulo]
FROM Monedas 
WHERE IdMoneda=@IdMonedaPesos or IdMoneda=@IdMonedaDolar
ORDER by Nombre
