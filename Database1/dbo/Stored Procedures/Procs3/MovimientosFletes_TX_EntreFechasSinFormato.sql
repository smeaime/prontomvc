
CREATE Procedure [dbo].[MovimientosFletes_TX_EntreFechasSinFormato]

@Desde datetime,
@Hasta datetime

AS 

SELECT *
FROM MovimientosFletes
WHERE Fecha between @Desde and DATEADD(n,1439,@Hasta)
ORDER BY IdFlete, Fecha
