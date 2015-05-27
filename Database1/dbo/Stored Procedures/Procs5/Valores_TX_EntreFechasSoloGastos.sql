


CREATE  Procedure [dbo].[Valores_TX_EntreFechasSoloGastos]
@Desde datetime,
@Hasta datetime
AS
SELECT *
FROM Valores 
WHERE (Valores.FechaComprobante Between @Desde And @Hasta) and 
	Valores.IdCuentaContable is not null
ORDER BY Valores.FechaComprobante


