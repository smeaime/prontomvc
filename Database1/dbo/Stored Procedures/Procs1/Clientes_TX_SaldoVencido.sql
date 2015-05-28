CREATE Procedure [dbo].[Clientes_TX_SaldoVencido]

@IdCliente int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (IdCliente INTEGER, SaldoDeuda NUMERIC(18,2), SaldoCreditosNoAplicados NUMERIC(18,2), SaldoTotal NUMERIC(18,2))
INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCliente, Case When IsNull(CtaCte.FechaVencimiento,CtaCte.Fecha)<GetDate() and IsNull(CtaCte.Saldo,0)>0 Then CtaCte.Saldo Else 0 End, 0, IsNull(CtaCte.ImporteTotal,0)
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE TiposComprobante.Coeficiente=1 and (@IdCliente=-1 or CtaCte.IdCliente=@IdCliente)

INSERT INTO #Auxiliar1 
 SELECT CtaCte.IdCliente, 0, IsNull(CtaCte.Saldo,0), IsNull(CtaCte.ImporteTotal,0)*-1
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 WHERE TiposComprobante.Coeficiente=-1 and (@IdCliente=-1 or CtaCte.IdCliente=@IdCliente)

CREATE TABLE #Auxiliar2 (IdCliente INTEGER, SaldoDeuda NUMERIC(18,2), SaldoCreditosNoAplicados NUMERIC(18,2), SaldoTotal NUMERIC(18,2))
INSERT INTO #Auxiliar2 
 SELECT IdCliente, Sum(IsNull(SaldoDeuda,0)), Sum(IsNull(SaldoCreditosNoAplicados,0)), Sum(IsNull(SaldoTotal,0))
 FROM #Auxiliar1
 GROUP BY IdCliente

SET NOCOUNT OFF

SELECT * FROM #Auxiliar2

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2