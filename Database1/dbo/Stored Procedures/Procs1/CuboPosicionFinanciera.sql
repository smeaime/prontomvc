CREATE PROCEDURE [dbo].[CuboPosicionFinanciera]

@Fecha datetime,
@Dts varchar(200)

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 (IdValor INTEGER)
INSERT INTO #Auxiliar0 
 SELECT Valores.IdValor
 FROM Valores 
 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopc.IdOrdenPago
 WHERE Valores.IdDetalleOrdenPagoCuentas is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

 SELECT Valores.IdValor
 FROM Valores 
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=dopv.IdOrdenPago
 WHERE Valores.IdDetalleOrdenPagoValores is not null and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI'


CREATE TABLE #Auxiliar1	
			(
			 IdValor INTEGER,
			 IdCuentaBancaria INTEGER,
			 IdMoneda INTEGER,
			 Fecha DATETIME,
			 DepositosPendientes NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasPendientes NUMERIC(18, 2),
			 ChequesPropiosAFecha NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancariaDeposito,
  Valores.IdMoneda,
  Case When Valores.FechaValor<@Fecha Then @Fecha Else Valores.FechaValor End,
  Valores.Importe,
  0,
  0
 FROM Valores 
 WHERE Valores.Estado='D' and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.IdCuentaBancariaDeposito is not null and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  Case When Valores.FechaComprobante<@Fecha Then @Fecha Else Valores.FechaComprobante End,
  0,
  Valores.Importe * -1,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.IdTipoComprobante=17 and IsNull(Valores.Anulado,'NO')<>'SI' and 
	#Auxiliar0.IdValor is not null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  Case When Valores.FechaValor<@Fecha Then @Fecha Else Valores.FechaValor End,
  0,
  0,
  Valores.Importe * -1
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.IdTipoComprobante=17 and IsNull(Valores.Anulado,'NO')<>'SI' and 
	#Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'


CREATE TABLE #Auxiliar2	
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdCuentaBancaria,  Bancos.IdCuenta
 FROM #Auxiliar1
 LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
 GROUP BY #Auxiliar1.IdCuentaBancaria,Bancos.IdCuenta


CREATE TABLE #Auxiliar3 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT 
  CuentasBancarias.IdCuentaBancaria,
  DetAsi.IdCuenta,
  Asientos.FechaAsiento,
  IsNull(DetAsi.Debe,0),
  IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN Bancos ON DetAsi.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null and asientos.IdCuentaSubdiario is null 

 UNION ALL

 SELECT
  CuentasBancarias.IdCuentaBancaria,
  Subdiarios.IdCuenta,
  Subdiarios.FechaComprobante,
  IsNull(Subdiarios.Debe,0),
  IsNull(Subdiarios.Haber,0)
 FROM Subdiarios
 LEFT OUTER JOIN Bancos ON Subdiarios.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null


CREATE TABLE #Auxiliar4 			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Fecha DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  #Auxiliar3.IdCuentaBancaria,
  #Auxiliar3.IdCuenta,
  #Auxiliar3.Fecha,
  SUM(#Auxiliar3.Debe),
  SUM(#Auxiliar3.Haber),
  Null
 FROM #Auxiliar3
 GROUP BY #Auxiliar3.IdCuentaBancaria, #Auxiliar3.IdCuenta, #Auxiliar3.Fecha

UPDATE #Auxiliar4
SET Saldo=Debe-Haber


CREATE TABLE #Auxiliar11	
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar11 
 SELECT 
  Cajas.IdCaja,
  Cajas.IdCuenta
 FROM Cajas 

CREATE TABLE #Auxiliar12
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar12 
 SELECT 
  #Auxiliar11.IdCaja,
  #Auxiliar11.IdCuenta,
  IsNull(DetAsi.Debe,0),
  IsNull(DetAsi.Haber,0)
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN #Auxiliar11 ON DetAsi.IdCuenta = #Auxiliar11.IdCuenta
 WHERE #Auxiliar11.IdCuenta is not null and asientos.IdCuentaSubdiario is null and
	Asientos.FechaAsiento<=DATEADD(n,1439,@Fecha)

 UNION ALL

 SELECT
  #Auxiliar11.IdCaja,
  #Auxiliar11.IdCuenta,
  IsNull(Subdiarios.Debe,0),
  IsNull(Subdiarios.Haber,0)
 FROM Subdiarios
 LEFT OUTER JOIN #Auxiliar11 ON Subdiarios.IdCuenta = #Auxiliar11.IdCuenta
 WHERE #Auxiliar11.IdCuenta is not null and 
	Subdiarios.FechaComprobante<=DATEADD(n,1439,@Fecha)

CREATE TABLE #Auxiliar13
			(
			 IdCaja INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar13 
 SELECT 
  #Auxiliar12.IdCaja,
  #Auxiliar12.IdCuenta,
  SUM(#Auxiliar12.Debe),
  SUM(#Auxiliar12.Haber),
  Null
 FROM #Auxiliar12
 GROUP BY #Auxiliar12.IdCaja,#Auxiliar12.IdCuenta

UPDATE #Auxiliar13
SET Saldo=Debe-Haber


TRUNCATE TABLE _TempCuboPosicionFinanciera
INSERT INTO _TempCuboPosicionFinanciera 
SELECT 
 'BANCOS',
 Monedas.Nombre,
 IsNull(Bancos.Nombre,'')+' - '+
	'Cta. banco : '+IsNull(CuentasBancarias.Cuenta COLLATE SQL_Latin1_General_CP1_CI_AS ,'')+' - '+
	'Cta. contable : '+Convert(varchar,IsNull(Cuentas.Codigo,'')),
 #Auxiliar1.Fecha,
 IsNull(TiposComprobante.DescripcionAb,'')+' '+
	Convert(varchar,IsNull(Valores.NumeroComprobante,0))+' del '+
	Convert(varchar,IsNull(Valores.FechaComprobante,''),103)+' '+
	'Nro.valor: '+Convert(varchar,IsNull(Valores.NumeroValor,0)),
 #Auxiliar1.DepositosPendientes,
 #Auxiliar1.TransferenciasEntreCuentasPropiasPendientes,
 #Auxiliar1.ChequesPropiosAFecha,
 (Select Sum(#Auxiliar4.Saldo) From #Auxiliar4 
  Where #Auxiliar4.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria and 
	#Auxiliar4.IdCuenta=Bancos.IdCuenta and #Auxiliar4.Fecha<=#Auxiliar1.Fecha),
 Null
FROM #Auxiliar1
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar1.IdValor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Valores.IdTipoComprobante
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=CuentasBancarias.IdMoneda
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Bancos.IdCuenta

UNION ALL

SELECT 
 'BANCOS',
 Monedas.Nombre,
 IsNull(Bancos.Nombre,'')+' - '+
	'Cta. banco : '+IsNull(CuentasBancarias.Cuenta COLLATE SQL_Latin1_General_CP1_CI_AS ,'')+' - '+
	'Cta. contable : '+Convert(varchar,IsNull(Cuentas.Codigo,'')),
 #Auxiliar1.Fecha,
 '',
 0,
 0,
 0,
 (Select Sum(#Auxiliar4.Saldo) From #Auxiliar4 
  Where #Auxiliar4.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria and 
	#Auxiliar4.IdCuenta=Bancos.IdCuenta and #Auxiliar4.Fecha<=#Auxiliar1.Fecha),
 Null
FROM #Auxiliar1
LEFT OUTER JOIN Valores ON Valores.IdValor=#Auxiliar1.IdValor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Valores.IdTipoComprobante
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=CuentasBancarias.IdMoneda
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Bancos.IdCuenta
GROUP BY Monedas.Nombre, Bancos.Nombre, CuentasBancarias.Cuenta, Cuentas.Codigo, 
	#Auxiliar1.Fecha, #Auxiliar1.IdCuentaBancaria, Bancos.IdCuenta

UNION ALL

SELECT 
 'INVERSIONES',
 Monedas.Nombre,
 IsNull(Bancos.Nombre,''),
 PlazosFijos.FechaVencimiento,
 'Plazo fijo '+
	Convert(varchar,IsNull(PlazosFijos.NumeroCertificado1,0))+' del '+
	Convert(varchar,IsNull(PlazosFijos.FechaInicioPlazoFijo,''),103),
 Null,
 Null,
 Null,
 Null,
 PlazosFijos.Importe
FROM PlazosFijos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=PlazosFijos.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=PlazosFijos.IdMoneda
WHERE (PlazosFijos.Finalizado is null or PlazosFijos.Finalizado='NO') and 
	(PlazosFijos.Anulado is null or PlazosFijos.Anulado<>'SI')

UNION ALL

SELECT 
 'CAJAS',
 Monedas.Nombre,
 IsNull(Cajas.Descripcion,'')+' - '+
	'Cta. contable : '+Convert(varchar,IsNull(Cuentas.Codigo,'')),
 Null,
 Null,
 Null,
 Null,
 Null,
 #Auxiliar13.Saldo,
 Null
FROM #Auxiliar13
LEFT OUTER JOIN Cajas ON Cajas.IdCaja=#Auxiliar13.IdCaja
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Cajas.IdMoneda
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar13.IdCuenta

Declare @Resultado INT
EXEC @Resultado=master..xp_cmdshell @Dts

SET NOCOUNT ON

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13