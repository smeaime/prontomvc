




CREATE PROCEDURE [dbo].[DepositosBancarios_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM DepositosBancarios 
WHERE FechaDeposito<=@FechaHasta
ORDER BY FechaDeposito





