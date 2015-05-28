




CREATE PROCEDURE [dbo].[NotasDebito_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM NotasDebito 
WHERE FechaNotaDebito<=@FechaHasta
ORDER BY FechaNotaDebito





