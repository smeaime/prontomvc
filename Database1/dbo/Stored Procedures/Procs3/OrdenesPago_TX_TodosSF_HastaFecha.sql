




CREATE PROCEDURE [dbo].[OrdenesPago_TX_TodosSF_HastaFecha]
@FechaHasta datetime
AS
SELECT *
FROM OrdenesPago op 
WHERE FechaOrdenPago<=@FechaHasta and 
	(op.Confirmado is null or op.Confirmado<>'NO')
ORDER BY FechaOrdenPago




