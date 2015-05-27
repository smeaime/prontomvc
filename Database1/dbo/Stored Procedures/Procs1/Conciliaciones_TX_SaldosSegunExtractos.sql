CREATE  Procedure [dbo].[Conciliaciones_TX_SaldosSegunExtractos]

@FechaFinal datetime

AS 

SELECT 
 SUM(IsNull(SaldoFinalResumen,0)) as [Saldo],
 SUM(IsNull(SaldoInicialResumen,0)) as [SaldoInicial]
-- COUNT(*) as [Resumenes]
FROM Conciliaciones
WHERE FechaFinal=@FechaFinal