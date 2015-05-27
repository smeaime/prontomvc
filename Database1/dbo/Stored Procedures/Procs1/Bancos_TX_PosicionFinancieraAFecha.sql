CREATE PROCEDURE [dbo].[Bancos_TX_PosicionFinancieraAFecha]

@Fecha datetime,
@FechaViernesProximo datetime,
@IdMoneda int

AS

SET NOCOUNT ON

DECLARE @FechaATomar datetime, @IdTipoCuentaGrupoAportes int, @CuentasDescarte varchar(2000)

IF DATEPART(dw,@Fecha)=5 and @FechaViernesProximo>0
	SET @FechaATomar=DATEADD(dd,-1,@Fecha)
ELSE
	SET @FechaATomar=@Fecha

SET @IdTipoCuentaGrupoAportes=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoCuentaGrupoAportes'),0)

SET @CuentasDescarte=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Cuentas a descartar para posicion financiera'),'')

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

UNION ALL 

 SELECT Valores.IdValor
 FROM Valores 
 LEFT OUTER JOIN DetalleRecibosCuentas det ON det.IdDetalleReciboCuentas=Valores.IdDetalleReciboCuentas
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=det.IdRecibo
 WHERE Valores.IdDetalleReciboCuentas is not null and IsNull(Recibos.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

 SELECT Valores.IdValor
 FROM Valores 
 LEFT OUTER JOIN DetalleRecibosValores det ON det.IdDetalleReciboValores=Valores.IdDetalleReciboValores
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=det.IdRecibo
 WHERE Valores.IdDetalleReciboValores is not null and IsNull(Recibos.TipoOperacionOtros,-1)=0 and IsNull(Valores.Anulado,'NO')<>'SI'


CREATE TABLE #Auxiliar1	
			(
			 IdValor INTEGER,
			 IdCuentaBancaria INTEGER,
			 IdMoneda INTEGER,
			 DepositosPendientes NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasPendientes NUMERIC(18, 2),
			 ChequesPropiosAFecha NUMERIC(18, 2),
			 ChequesPropiosHastaViernesProximo NUMERIC(18, 2),
			 ChequesPropiosPosterioresAlViernesProximo NUMERIC(18, 2),
			 SaldosContableAFecha NUMERIC(18, 2),
			 DepositosDelDia NUMERIC(18, 2),
			 ChequesPropiosDelDia NUMERIC(18, 2),
			 GastosBancariosDelDia NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasDelDia NUMERIC(18, 2),
			 AportesDelDia NUMERIC(18, 2),
			 ChequesPosdatadosAnt NUMERIC(18, 2),
			 ChequesPosdatadosDia NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancariaDeposito,
  Valores.IdMoneda,
  Valores.Importe,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.Estado='D' And Valores.IdCuentaBancariaDeposito is not null and #Auxiliar0.IdValor is null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  IsNull(Valores.IdCuentaBancaria,Valores.IdCuentaBancariaDeposito),
  Valores.IdMoneda,
  0,
  Valores.Importe * Case When Valores.IdTipoComprobante=17 Then -1 Else 1 End,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE ((Valores.IdTipoComprobante=2 and Valores.IdCuentaBancariaDeposito is not null) or (Valores.IdTipoComprobante=17 and Valores.IdCuentaBancaria is not null)) and 
	#Auxiliar0.IdValor is not null and IsNull(Valores.Anulado,'NO')<>'SI' and IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  Valores.Importe * -1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and Valores.FechaValor<=@FechaATomar and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO' and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  Valores.Importe * -1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.Anulado,'NO')<>'SI' and (Valores.FechaValor>@FechaATomar and Valores.FechaValor<=@FechaViernesProximo) and 
	IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  Valores.Importe * -1,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores  LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.Anulado,'NO')<>'SI' and Valores.FechaValor>@FechaViernesProximo and IsNull(Valores.MovimientoConfirmadoBanco,'NO')='NO'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancariaDeposito,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe,
  0,
  0,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.Estado='D' And Valores.IdCuentaBancariaDeposito is not null and IsNull(Valores.Anulado,'NO')<>'SI' and #Auxiliar0.IdValor is null and 
	Valores.FechaDeposito=@FechaATomar

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * -1,
  0,
  0,
  0,
  0,
  0
 FROM Valores  LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=OrdenesPago.IdCuenta
 LEFT OUTER JOIN BancoChequeras ON BancoChequeras.IdBancoChequera=dopv.IdBancoChequera
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	(Valores.FechaValor=@FechaATomar or (Valores.IdTipoValor=22 and Valores.FechaComprobante=@FechaATomar)) and 
	IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoAportes and 
	(IsNull(BancoChequeras.ChequeraPagoDiferido,'')='SI' or Valores.FechaValor=Valores.FechaComprobante or Valores.IdTipoValor=22)

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * IsNull(tc.Coeficiente,0) * -1,
  0,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE Valores.Estado='G' and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.FechaComprobante=@FechaATomar 

UNION ALL 

 SELECT 
  Valores.IdValor,
  IsNull(Valores.IdCuentaBancaria,Valores.IdCuentaBancariaDeposito),
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * Case When Valores.IdTipoComprobante=17 Then -1 Else 1 End,
  0,
  0,
  0
 FROM Valores 
 LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 WHERE ((Valores.IdTipoComprobante=2 and Valores.IdCuentaBancariaDeposito is not null) or (Valores.IdTipoComprobante=17 and Valores.IdCuentaBancaria is not null)) and 
	#Auxiliar0.IdValor is not null and IsNull(Valores.Anulado,'NO')<>'SI' and Valores.FechaComprobante=@FechaATomar

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * -1,
  0,
  0
 FROM Valores  LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=OrdenesPago.IdCuenta
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.Anulado,'NO')<>'SI' and Valores.FechaValor=@FechaATomar and IsNull(Cuentas.IdTipoCuentaGrupo,-1)=@IdTipoCuentaGrupoAportes

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * -1,
  0
 FROM Valores  LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=OrdenesPago.IdCuenta
 LEFT OUTER JOIN BancoChequeras ON BancoChequeras.IdBancoChequera=dopv.IdBancoChequera
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and 
	IsNull(Valores.Anulado,'NO')<>'SI' and Valores.FechaValor=@FechaATomar and Valores.FechaComprobante<>@FechaATomar and 
	IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoAportes and IsNull(BancoChequeras.ChequeraPagoDiferido,'')<>'SI'

UNION ALL 

 SELECT 
  Valores.IdValor,
  Valores.IdCuentaBancaria,
  Valores.IdMoneda,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  Valores.Importe * -1
 FROM Valores  LEFT OUTER JOIN #Auxiliar0 ON #Auxiliar0.IdValor=Valores.IdValor
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON dopv.IdDetalleOrdenPagoValores=Valores.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN DetalleOrdenesPagoCuentas dopc ON dopc.IdDetalleOrdenPagoCuentas=Valores.IdDetalleOrdenPagoCuentas
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=IsNull(dopv.IdOrdenPago,dopc.IdOrdenPago)
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=OrdenesPago.IdCuenta
 LEFT OUTER JOIN BancoChequeras ON BancoChequeras.IdBancoChequera=dopv.IdBancoChequera
 WHERE Valores.IdTipoComprobante=17 and #Auxiliar0.IdValor is null and Valores.IdCuentaBancaria is not null and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.FechaValor<>@FechaATomar and Valores.FechaComprobante=@FechaATomar and Valores.IdTipoValor<>22 and 
	IsNull(Cuentas.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoAportes and IsNull(BancoChequeras.ChequeraPagoDiferido,'')<>'SI'


CREATE TABLE #Auxiliar2	
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdCuentaBancaria, Bancos.IdCuenta
 FROM #Auxiliar1
 LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
 GROUP BY #Auxiliar1.IdCuentaBancaria,Bancos.IdCuenta


CREATE TABLE #Auxiliar3 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeAnterior NUMERIC(18, 2),
			 HaberAnterior NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT CuentasBancarias.IdCuentaBancaria, DetAsi.IdCuenta, IsNull(DetAsi.Debe,0), IsNull(DetAsi.Haber,0), 
	Case When Asientos.FechaAsiento<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(DetAsi.Debe,0) Else 0 End,
	Case When Asientos.FechaAsiento<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(DetAsi.Haber,0) Else 0 End
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN Bancos ON DetAsi.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null and asientos.IdCuentaSubdiario is null and Asientos.FechaAsiento<=DateAdd(n,1439,@Fecha)

 UNION ALL

 SELECT CuentasBancarias.IdCuentaBancaria, Subdiarios.IdCuenta, IsNull(Subdiarios.Debe,0), IsNull(Subdiarios.Haber,0), 
	Case When Subdiarios.FechaComprobante<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(Subdiarios.Debe,0) Else 0 End,
	Case When Subdiarios.FechaComprobante<=DateAdd(n,1439,DateAdd(dd,-1,@Fecha)) Then IsNull(Subdiarios.Haber,0) Else 0 End
 FROM Subdiarios
 LEFT OUTER JOIN Bancos ON Subdiarios.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null and Subdiarios.FechaComprobante<=DateAdd(n,1439,@Fecha)


CREATE TABLE #Auxiliar4 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 DebeAnterior NUMERIC(18, 2),
			 HaberAnterior NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT #Auxiliar3.IdCuentaBancaria, #Auxiliar3.IdCuenta, Sum(IsNull(#Auxiliar3.Debe,0)), Sum(IsNull(#Auxiliar3.Haber,0)), 
	Sum(IsNull(#Auxiliar3.DebeAnterior,0)), Sum(IsNull(#Auxiliar3.HaberAnterior,0))
 FROM #Auxiliar3
 GROUP BY #Auxiliar3.IdCuentaBancaria, #Auxiliar3.IdCuenta


CREATE TABLE #Auxiliar5 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 IdMoneda INTEGER,
			 DepositosPendientes NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasPendientes NUMERIC(18, 2),
			 ChequesPropiosAFecha NUMERIC(18, 2),
			 ChequesPropiosHastaViernesProximo NUMERIC(18, 2),
			 ChequesPropiosPosterioresAlViernesProximo NUMERIC(18, 2),
			 SaldosContableAFecha NUMERIC(18, 2),
			 DepositosDelDia NUMERIC(18, 2),
			 ChequesPropiosDelDia NUMERIC(18, 2),
			 GastosBancariosDelDia NUMERIC(18, 2),
			 TransferenciasEntreCuentasPropiasDelDia NUMERIC(18, 2),
			 AportesDelDia NUMERIC(18, 2),
			 ChequesPosdatadosAnt NUMERIC(18, 2),
			 ChequesPosdatadosDia NUMERIC(18, 2),
			 SaldosContableDiaAnterior NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar5 
 SELECT 
  #Auxiliar1.IdCuentaBancaria,
  #Auxiliar4.IdCuenta,
  Max(IsNull(#Auxiliar1.IdMoneda,0)),
  Sum(IsNull(#Auxiliar1.DepositosPendientes,0)),
  Sum(IsNull(#Auxiliar1.TransferenciasEntreCuentasPropiasPendientes,0)),
  Sum(IsNull(#Auxiliar1.ChequesPropiosAFecha,0)),
  Sum(IsNull(#Auxiliar1.ChequesPropiosHastaViernesProximo,0)),
  Sum(IsNull(#Auxiliar1.ChequesPropiosPosterioresAlViernesProximo,0)),
  Max(IsNull(#Auxiliar4.Debe,0))-Max(IsNull(#Auxiliar4.Haber,0)),
  Sum(IsNull(#Auxiliar1.DepositosDelDia,0)),
  Sum(IsNull(#Auxiliar1.ChequesPropiosDelDia,0)),
  Sum(IsNull(#Auxiliar1.GastosBancariosDelDia,0)),
  Sum(IsNull(#Auxiliar1.TransferenciasEntreCuentasPropiasDelDia,0)),
  Sum(IsNull(#Auxiliar1.AportesDelDia,0)),
  Sum(IsNull(#Auxiliar1.ChequesPosdatadosAnt,0)),
  Sum(IsNull(#Auxiliar1.ChequesPosdatadosDia,0)),
  Max(IsNull(#Auxiliar4.DebeAnterior,0))-Max(IsNull(#Auxiliar4.HaberAnterior,0))
 FROM #Auxiliar1
 LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.IdCuentaBancaria = #Auxiliar1.IdCuentaBancaria
 GROUP BY #Auxiliar1.IdCuentaBancaria, #Auxiliar4.IdCuenta

INSERT INTO #Auxiliar5 
 SELECT 
  #Auxiliar4.IdCuentaBancaria,
  #Auxiliar4.IdCuenta,
  @IdMoneda,
  0,
  0,
  0,
  0,
  0,
  IsNull(#Auxiliar4.Debe,0)-IsNull(#Auxiliar4.Haber,0),
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  IsNull(#Auxiliar4.DebeAnterior,0)-IsNull(#Auxiliar4.HaberAnterior,0)
 FROM #Auxiliar4
 WHERE (IsNull(#Auxiliar4.Debe,0)-IsNull(#Auxiliar4.Haber,0)<>0 or IsNull(#Auxiliar4.DebeAnterior,0)-IsNull(#Auxiliar4.HaberAnterior,0)<>0) and 
	Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar4.IdCuentaBancaria=#Auxiliar1.IdCuentaBancaria)

SET NOCOUNT ON

SELECT 
 #Auxiliar5.IdCuentaBancaria,
 CuentasBancarias.Detalle as [Detalle],
 CuentasBancarias.Cuenta as [Cuenta],
 Bancos.Nombre as [Banco],
 Monedas.Nombre as [Moneda],
 Provincias.Nombre as [Cuenta en provincia],
 Cuentas.Codigo as [CodigoCuenta],
 #Auxiliar5.DepositosPendientes,
 #Auxiliar5.TransferenciasEntreCuentasPropiasPendientes,
 #Auxiliar5.ChequesPropiosAFecha,
 #Auxiliar5.ChequesPropiosHastaViernesProximo,
 #Auxiliar5.ChequesPropiosPosterioresAlViernesProximo,
 #Auxiliar5.SaldosContableAFecha,
 #Auxiliar5.DepositosDelDia,
 #Auxiliar5.ChequesPropiosDelDia,
 #Auxiliar5.GastosBancariosDelDia,
 #Auxiliar5.TransferenciasEntreCuentasPropiasDelDia,
 #Auxiliar5.AportesDelDia,
 #Auxiliar5.ChequesPosdatadosAnt,
 #Auxiliar5.ChequesPosdatadosDia,
 #Auxiliar5.SaldosContableDiaAnterior
FROM #Auxiliar5
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar5.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=CuentasBancarias.IdMoneda
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=#Auxiliar5.IdCuenta
LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=CuentasBancarias.IdProvincia
WHERE CuentasBancarias.IdMoneda=@IdMoneda and Patindex('%('+Convert(varchar,Cuentas.Codigo)+')%', @CuentasDescarte)=0
ORDER BY IsNull(Cuentas.OrdenamientoAuxiliar,999999), Bancos.Nombre, CuentasBancarias.Cuenta

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5