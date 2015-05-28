
CREATE PROCEDURE [dbo].[NotasCredito_TX_TodosSF_HastaFecha]

@FechaHasta datetime

AS

SELECT *
FROM NotasCredito 
WHERE FechaNotaCredito<=@FechaHasta
ORDER BY FechaNotaCredito
