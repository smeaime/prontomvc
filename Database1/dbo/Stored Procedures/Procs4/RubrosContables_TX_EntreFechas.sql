CREATE Procedure [dbo].[RubrosContables_TX_EntreFechas]

@IdRubroContable int,
@Desde datetime,
@hasta datetime,
@Formato varchar(10) = Null, 
@ConPrevision varchar(2) = Null,
@IdBanco int = Null,
@ConTransferenciasEntreCuentasPropias varchar(2) = Null,
@Sin_OP_y_Sin_RE varchar(2) = Null

AS 

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'')
SET @ConPrevision=IsNull(@ConPrevision,'NO')
SET @IdBanco=IsNull(@IdBanco,-1)
SET @ConTransferenciasEntreCuentasPropias=IsNull(@ConTransferenciasEntreCuentasPropias,'NO')
SET @Sin_OP_y_Sin_RE=IsNull(@Sin_OP_y_Sin_RE,'NO')

DECLARE @Hoy datetime

SET @Hoy=Convert(datetime,Convert(varchar,Day(Getdate()))+'/'+Convert(varchar,Month(Getdate()))+'/'+Convert(varchar,Year(Getdate())),103)

/*   PROCESO DE INGRESOS   */

CREATE TABLE #Auxiliar1 (IdRecibo INTEGER, FechaValor DATETIME, Importe NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdRecibo) ON [PRIMARY]

IF @Sin_OP_y_Sin_RE<>'SI'
	INSERT INTO #Auxiliar1 
	 SELECT DetRV.IdRecibo, IsNull(DetRV.FechaVencimiento,Recibos.FechaRecibo), IsNull(DetRV.Importe,0)*IsNull(Recibos.CotizacionMoneda,1)
	 FROM DetalleRecibosValores DetRV
	 LEFT OUTER JOIN Recibos ON DetRV.IdRecibo=Recibos.IdRecibo
	 LEFT OUTER JOIN Valores ON Valores.IdDetalleReciboValores=DetRV.IdDetalleReciboValores
	 WHERE IsNull(DetRV.FechaVencimiento,Recibos.FechaRecibo) between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')='NO' and IsNull(Valores.Anulado,'NO')<>'SI' --and Valores.Estado is null

CREATE TABLE #Auxiliar2 (IdRecibo INTEGER, Importe NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdRecibo) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdRecibo, 0
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdRecibo

UPDATE #Auxiliar2
SET Importe=IsNull((Select Sum(IsNull(DetRV.Importe,0)*IsNull(Recibos.CotizacionMoneda,1)) From DetalleRecibosValores DetRV
			Left Outer Join Recibos On DetRV.IdRecibo=Recibos.IdRecibo
			Left Outer Join Valores On Valores.IdDetalleReciboValores=DetRV.IdDetalleReciboValores
			Where DetRV.IdRecibo=#Auxiliar2.IdRecibo and IsNull(Valores.Anulado,'NO')<>'SI'),0)

/*   PROCESO DE EGRESOS   */

CREATE TABLE #Auxiliar4 (IdOrdenPago INTEGER, FechaValor DATETIME, Importe NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdOrdenPago) ON [PRIMARY]

IF @Sin_OP_y_Sin_RE<>'SI'
	INSERT INTO #Auxiliar4 
	 SELECT DetOPV.IdOrdenPago, IsNull(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago), IsNull(DetOPV.Importe,0)*IsNull(OrdenesPago.CotizacionMoneda,1)
	 FROM DetalleOrdenesPagoValores DetOPV
	 LEFT OUTER JOIN OrdenesPago ON DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
	 LEFT OUTER JOIN Valores ON Valores.IdDetalleOrdenPagoValores=DetOPV.IdDetalleOrdenPagoValores
	 WHERE IsNull(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago) between @Desde and @Hasta and IsNull(OrdenesPago.Anulada,'NO')='NO' and IsNull(Valores.Anulado,'NO')<>'SI' --and DetOPV.IdValor is null   (Sacado el 5/7/2013)

CREATE TABLE #Auxiliar5 (IdOrdenPago INTEGER, Importe NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdOrdenPago) ON [PRIMARY]
INSERT INTO #Auxiliar5 
 SELECT #Auxiliar4.IdOrdenPago, 0
 FROM #Auxiliar4
 GROUP BY #Auxiliar4.IdOrdenPago

UPDATE #Auxiliar5
SET Importe=IsNull((Select Sum(IsNull(DetOPV.Importe,0)*IsNull(OrdenesPago.CotizacionMoneda,1)) From DetalleOrdenesPagoValores DetOPV
			Left Outer Join OrdenesPago On DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
			Left Outer Join Valores On Valores.IdDetalleOrdenPagoValores=DetOPV.IdDetalleOrdenPagoValores
			Where DetOPV.IdOrdenPago=#Auxiliar5.IdOrdenPago and IsNull(Valores.Anulado,'NO')<>'SI'),0)


/*   ARMADO DE TABLA FINAL   */

CREATE TABLE #Auxiliar3 (IdRubroContable INTEGER, Fecha DATETIME, Comprobante VARCHAR(20), Importe NUMERIC(18,2), IdBanco INTEGER, EntreCuentasPropias VARCHAR(2))

IF @Sin_OP_y_Sin_RE<>'SI'
	INSERT INTO #Auxiliar3 
	 SELECT DetOP.IdRubroContable, #Auxiliar4.FechaValor, 'OP '+Convert(varchar,IsNull(OrdenesPago.NumeroOrdenPago,0)),
		Case When IsNull(#Auxiliar5.Importe,1)<>0
			Then #Auxiliar4.Importe / IsNull(#Auxiliar5.Importe,1) * (DetOP.Importe * IsNull(OrdenesPago.CotizacionMoneda,1))
			Else 0
		End * -1, --Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End, 
		(Select Top 1 dopv.IdBanco From DetalleOrdenesPagoValores dopv Where dopv.IdOrdenPago=DetOP.IdOrdenPago and dopv.IdBanco is not null), Null
	 FROM DetalleOrdenesPagoRubrosContables DetOP
	 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetOP.IdRubroContable
	 LEFT OUTER JOIN #Auxiliar4 ON DetOP.IdOrdenPago=#Auxiliar4.IdOrdenPago
	 LEFT OUTER JOIN #Auxiliar5 ON DetOP.IdOrdenPago=#Auxiliar5.IdOrdenPago
	 WHERE (@IdRubroContable=-1 or DetOP.IdRubroContable=@IdRubroContable) and #Auxiliar4.FechaValor between @Desde and @Hasta and IsNull(OrdenesPago.Anulada,'NO')='NO' and 
			(@IdBanco=-1 or IsNull((Select Top 1 dopv.IdBanco From DetalleOrdenesPagoValores dopv Where dopv.IdOrdenPago=DetOP.IdOrdenPago and dopv.IdBanco is not null),0)=@IdBanco)

IF @Sin_OP_y_Sin_RE<>'SI'
	INSERT INTO #Auxiliar3 
	 SELECT DetRE.IdRubroContable, #Auxiliar1.FechaValor, 'RE '+Convert(varchar,IsNull(Recibos.NumeroRecibo,0)),
		Case When IsNull(#Auxiliar2.Importe,1)<>0
			Then #Auxiliar1.Importe / IsNull(#Auxiliar2.Importe,1) * (DetRE.Importe * IsNull(Recibos.CotizacionMoneda,1))
			Else 0
		End * 1, --Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End, --Then -1 Else 1 End
		(Select Top 1 drv.IdBancoTransferencia From DetalleRecibosValores drv Where drv.IdRecibo=DetRE.IdRecibo and drv.IdBancoTransferencia is not null), Null
	 FROM DetalleRecibosRubrosContables DetRE
	 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRE.IdRecibo
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetRE.IdRubroContable
	 LEFT OUTER JOIN #Auxiliar1 ON DetRE.IdRecibo=#Auxiliar1.IdRecibo
	 LEFT OUTER JOIN #Auxiliar2 ON DetRE.IdRecibo=#Auxiliar2.IdRecibo
	 WHERE (@IdRubroContable=-1 or DetRE.IdRubroContable=@IdRubroContable) and #Auxiliar1.FechaValor between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')='NO' and 
			(@IdBanco=-1 or IsNull((Select Top 1 drv.IdBancoTransferencia From DetalleRecibosValores drv Where drv.IdRecibo=DetRE.IdRecibo and drv.IdBancoTransferencia is not null),0)=@IdBanco)

INSERT INTO #Auxiliar3 
 SELECT DetV.IdRubroContable, IsNull(Valores.FechaConfirmacionBanco,Valores.FechaComprobante), 'CBG '+Convert(varchar,IsNull(Valores.NumeroComprobante,0)), DetV.Importe * IsNull(Valores.CotizacionMoneda,1), Valores.IdBanco, Null
 FROM DetalleValoresRubrosContables DetV 
 LEFT OUTER JOIN Valores ON Valores.IdValor=DetV.IdValor
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
 WHERE IsNull(RubrosContables.IngresoEgreso,'E')='I' and (@IdRubroContable=-1 or DetV.IdRubroContable=@IdRubroContable) and Valores.FechaComprobante between @Desde and @Hasta and 
		(@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco)

INSERT INTO #Auxiliar3 
 SELECT DetV.IdRubroContable, IsNull(Valores.FechaConfirmacionBanco,Valores.FechaComprobante), 'DBG '+Convert(varchar,IsNull(Valores.NumeroComprobante,0)), DetV.Importe * IsNull(Valores.CotizacionMoneda,1) * -1, Valores.IdBanco, Null
 FROM DetalleValoresRubrosContables DetV 
 LEFT OUTER JOIN Valores ON Valores.IdValor=DetV.IdValor
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
 WHERE IsNull(RubrosContables.IngresoEgreso,'E')='E' and (@IdRubroContable=-1 or DetV.IdRubroContable=@IdRubroContable) and Valores.FechaComprobante between @Desde and @Hasta and 
		(@IdBanco=-1 or IsNull(Valores.IdBanco,0)=@IdBanco)

INSERT INTO #Auxiliar3 
 SELECT Det.IdRubroContable, PlazosFijos.FechaInicioPlazoFijo, 'PF '+Convert(varchar,IsNull(PlazosFijos.NumeroCertificado1,0)), Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlInicio,1) * -1, PlazosFijos.IdBanco, Null
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 WHERE (@IdRubroContable=-1 or Det.IdRubroContable=@IdRubroContable) and PlazosFijos.FechaInicioPlazoFijo between @Desde and @Hasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='E' and 
		(@IdBanco=-1 or IsNull(PlazosFijos.IdBanco,0)=@IdBanco)

INSERT INTO #Auxiliar3 
 SELECT Det.IdRubroContable, PlazosFijos.FechaVencimiento, 'PF '+Convert(varchar,IsNull(PlazosFijos.NumeroCertificado1,0)), Det.Importe * IsNull(PlazosFijos.CotizacionMonedaAlFinal,1), PlazosFijos.IdBanco, Null
 FROM DetallePlazosFijosRubrosContables Det
 LEFT OUTER JOIN PlazosFijos ON PlazosFijos.IdPlazoFijo=Det.IdPlazoFijo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Det.IdRubroContable
 WHERE (@IdRubroContable=-1 or Det.IdRubroContable=@IdRubroContable) and PlazosFijos.FechaVencimiento between @Desde and @Hasta and IsNull(PlazosFijos.Anulado,'NO')='NO' and IsNull(Det.Tipo,'E')='I' and 
		(@IdBanco=-1 or IsNull(PlazosFijos.IdBanco,0)=@IdBanco)

IF @ConPrevision='SI'
	INSERT INTO #Auxiliar3 
	 SELECT Previsiones.IdRubroFinanciero, Previsiones.FechaCaducidad, 'PREV '+Convert(varchar,IsNull(Previsiones.Numero,0)), Previsiones.Importe * Case When IsNull(Previsiones.TipoMovimiento,'I')='I' Then 1 Else -1 End, Previsiones.IdBanco, Null
	 FROM Previsiones
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=Previsiones.IdRubroFinanciero
	 WHERE (@IdRubroContable=-1 or Previsiones.IdRubroFinanciero=@IdRubroContable) and 
		Previsiones.FechaCaducidad between @Desde and @Hasta and 
		((Previsiones.FechaCaducidad>@Hoy and IsNull(PostergarFechaCaducidad,'')<>'SI') or (Previsiones.FechaCaducidad>=@Hoy and IsNull(PostergarFechaCaducidad,'')='SI')) and 
		(@IdBanco=-1 or IsNull(Previsiones.IdBanco,0)=@IdBanco)

IF @ConTransferenciasEntreCuentasPropias='SI' and @Sin_OP_y_Sin_RE<>'SI'
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT -210, IsNull(DetRV.FechaVencimiento,Recibos.FechaRecibo), 'RE '+Convert(varchar,IsNull(Recibos.NumeroRecibo,0)), IsNull(DetRV.Importe,0)*IsNull(Recibos.CotizacionMoneda,1)*-1, 
			CuentasBancarias.IdBanco, 'SI'
	 FROM DetalleRecibosValores DetRV
	 LEFT OUTER JOIN Recibos ON DetRV.IdRecibo=Recibos.IdRecibo
	 LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=DetRV.IdCuentaBancariaTransferencia
	 WHERE IsNull(DetRV.FechaVencimiento,Recibos.FechaRecibo) between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')='NO' and IsNull(Recibos.TipoOperacionOtros,-1)=0 and 
			Not Exists(Select Top 1 DetRE.IdRecibo From DetalleRecibosRubrosContables DetRE Where DetRE.IdRecibo=DetRV.IdRecibo) and (@IdBanco=-1 or IsNull(CuentasBancarias.IdBanco,0)=@IdBanco)

	INSERT INTO #Auxiliar3 
	 SELECT -210, IsNull(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago), 'OP '+Convert(varchar,IsNull(OrdenesPago.NumeroOrdenPago,0)), IsNull(DetOPV.Importe,0)*IsNull(OrdenesPago.CotizacionMoneda,1), 
			DetOPV.IdBanco, 'SI'
	 FROM DetalleOrdenesPagoValores DetOPV
	 LEFT OUTER JOIN OrdenesPago ON DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
	 WHERE IsNull(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago) between @Desde and @Hasta and IsNull(OrdenesPago.Anulada,'NO')='NO' and IsNull(OrdenesPago.TipoOperacionOtros,-1)=0 and 
			Not Exists(Select Top 1 DetOP.IdOrdenPago From DetalleOrdenesPagoRubrosContables DetOP Where DetOP.IdOrdenPago=DetOPV.IdOrdenPago) and (@IdBanco=-1 or IsNull(DetOPV.IdBanco,0)=@IdBanco)
  END

/*
 SELECT TiposComprobante.DescripcionAb+' '+Convert(varchar,IsNull(Valores.NumeroComprobante,0)), DetV.Importe * IsNull(TiposComprobante.Coeficiente,1) * IsNull(Valores.CotizacionMoneda,1)
 FROM DetalleValoresRubrosContables DetV 
 LEFT OUTER JOIN Valores ON Valores.IdValor=DetV.IdValor
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
 LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
 WHERE DetV.IdRubroContable=@IdRubroContable and Valores.FechaComprobante between @Desde and @Hasta 
*/
SET NOCOUNT OFF

IF @Formato=''
	SELECT Sum(Importe) as [Importe] FROM #Auxiliar3 WHERE IsNull(IdRubroContable,0)>0

IF @Formato='SinObra' or @Formato='CashFlow5'
	SELECT * FROM #Auxiliar3 WHERE IsNull(IdRubroContable,0)>0 ORDER BY IdRubroContable, Fecha, Comprobante

IF @Formato='SinObra2'
	SELECT #Auxiliar3.*, Case When #Auxiliar3.IdRubroContable<0 Then #Auxiliar3.IdRubroContable*-1 Else RubrosContables.Codigo End, RubrosContables.Descripcion, Bancos.Nombre as [Banco] FROM #Auxiliar3 
	LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar3.IdRubroContable
	LEFT OUTER JOIN Bancos ON Bancos.IdBanco=#Auxiliar3.IdBanco
	ORDER BY RubrosContables.Codigo, RubrosContables.Descripcion, #Auxiliar3.Fecha, #Auxiliar3.Comprobante

IF @Formato='PorMes'
  BEGIN
	SET NOCOUNT ON

	CREATE TABLE #Auxiliar6 (Codigo INTEGER, RubroContable VARCHAR(50), 
				 Dia1 NUMERIC(18,2), Dia2 NUMERIC(18,2), Dia3 NUMERIC(18,2), Dia4 NUMERIC(18,2), Dia5 NUMERIC(18,2), Dia6 NUMERIC(18,2), Dia7 NUMERIC(18,2), 
				 Dia8 NUMERIC(18,2), Dia9 NUMERIC(18,2), Dia10 NUMERIC(18,2), Dia11 NUMERIC(18,2), Dia12 NUMERIC(18,2), Dia13 NUMERIC(18,2), Dia14 NUMERIC(18,2), 
				 Dia15 NUMERIC(18,2), Dia16 NUMERIC(18,2), Dia17 NUMERIC(18,2), Dia18 NUMERIC(18,2), Dia19 NUMERIC(18,2), Dia20 NUMERIC(18,2), Dia21 NUMERIC(18,2), 
				 Dia22 NUMERIC(18,2), Dia23 NUMERIC(18,2), Dia24 NUMERIC(18,2), Dia25 NUMERIC(18,2), Dia26 NUMERIC(18,2), Dia27 NUMERIC(18,2), Dia28 NUMERIC(18,2), 
				 Dia29 NUMERIC(18,2), Dia30 NUMERIC(18,2), Dia31 NUMERIC(18,2), Dia32 NUMERIC(18,2), Dia33 NUMERIC(18,2), Dia34 NUMERIC(18,2), Dia35 NUMERIC(18,2), 
				 Dia36 NUMERIC(18,2), Dia37 NUMERIC(18,2), Dia38 NUMERIC(18,2), Dia39 NUMERIC(18,2), Dia40 NUMERIC(18,2), Dia41 NUMERIC(18,2), Dia42 NUMERIC(18,2), 
				 Dia43 NUMERIC(18,2), Dia44 NUMERIC(18,2), Dia45 NUMERIC(18,2), Dia46 NUMERIC(18,2), Dia47 NUMERIC(18,2), Dia48 NUMERIC(18,2), Dia49 NUMERIC(18,2), 
				 Dia50 NUMERIC(18,2), Dia51 NUMERIC(18,2), Dia52 NUMERIC(18,2), Dia53 NUMERIC(18,2), Dia54 NUMERIC(18,2), Dia55 NUMERIC(18,2), Dia56 NUMERIC(18,2), 
				 Dia57 NUMERIC(18,2), Dia58 NUMERIC(18,2), Dia59 NUMERIC(18,2), Dia60 NUMERIC(18,2))
	INSERT INTO #Auxiliar6
	 SELECT Case When a.IdRubroContable<0 Then a.IdRubroContable*-1 Else RubrosContables.Codigo End, RubrosContables.Descripcion, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=1 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=2 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=3 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=4 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=5 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=6 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=7 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=8 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=9 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=10 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=11 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=12 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=13 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=14 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=15 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=16 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=17 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=18 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=19 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=20 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=21 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=22 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=23 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=24 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=25 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=26 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=27 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=28 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=29 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=30 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=31 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=32 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=33 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=34 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=35 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=36 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=37 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=38 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=39 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=40 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=41 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=42 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=43 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=44 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=45 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=46 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=47 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=48 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=49 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=50 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=51 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=52 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=53 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=54 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=55 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=56 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=57 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=58 Then a.Importe Else Null End, 
			Case When DateDiff(day,@Desde,a.Fecha)+1=59 Then a.Importe Else Null End, Case When DateDiff(day,@Desde,a.Fecha)+1=60 Then a.Importe Else Null End
	 FROM #Auxiliar3 a
	 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=a.IdRubroContable

	CREATE TABLE #Auxiliar7 (Codigo INTEGER, RubroContable VARCHAR(50), 
				 Dia1 NUMERIC(18,2), Dia2 NUMERIC(18,2), Dia3 NUMERIC(18,2), Dia4 NUMERIC(18,2), Dia5 NUMERIC(18,2), Dia6 NUMERIC(18,2), Dia7 NUMERIC(18,2), 
				 Dia8 NUMERIC(18,2), Dia9 NUMERIC(18,2), Dia10 NUMERIC(18,2), Dia11 NUMERIC(18,2), Dia12 NUMERIC(18,2), Dia13 NUMERIC(18,2), Dia14 NUMERIC(18,2), 
				 Dia15 NUMERIC(18,2), Dia16 NUMERIC(18,2), Dia17 NUMERIC(18,2), Dia18 NUMERIC(18,2), Dia19 NUMERIC(18,2), Dia20 NUMERIC(18,2), Dia21 NUMERIC(18,2), 
				 Dia22 NUMERIC(18,2), Dia23 NUMERIC(18,2), Dia24 NUMERIC(18,2), Dia25 NUMERIC(18,2), Dia26 NUMERIC(18,2), Dia27 NUMERIC(18,2), Dia28 NUMERIC(18,2), 
				 Dia29 NUMERIC(18,2), Dia30 NUMERIC(18,2), Dia31 NUMERIC(18,2), Dia32 NUMERIC(18,2), Dia33 NUMERIC(18,2), Dia34 NUMERIC(18,2), Dia35 NUMERIC(18,2), 
				 Dia36 NUMERIC(18,2), Dia37 NUMERIC(18,2), Dia38 NUMERIC(18,2), Dia39 NUMERIC(18,2), Dia40 NUMERIC(18,2), Dia41 NUMERIC(18,2), Dia42 NUMERIC(18,2), 
				 Dia43 NUMERIC(18,2), Dia44 NUMERIC(18,2), Dia45 NUMERIC(18,2), Dia46 NUMERIC(18,2), Dia47 NUMERIC(18,2), Dia48 NUMERIC(18,2), Dia49 NUMERIC(18,2), 
				 Dia50 NUMERIC(18,2), Dia51 NUMERIC(18,2), Dia52 NUMERIC(18,2), Dia53 NUMERIC(18,2), Dia54 NUMERIC(18,2), Dia55 NUMERIC(18,2), Dia56 NUMERIC(18,2), 
				 Dia57 NUMERIC(18,2), Dia58 NUMERIC(18,2), Dia59 NUMERIC(18,2), Dia60 NUMERIC(18,2))
	INSERT INTO #Auxiliar7
	 SELECT Codigo, Codigo, Sum(IsNull(Dia1,0)), Sum(IsNull(Dia2,0)), Sum(IsNull(Dia3,0)), Sum(IsNull(Dia4,0)), Sum(IsNull(Dia5,0)), Sum(IsNull(Dia6,0)), Sum(IsNull(Dia7,0)), 
		Sum(IsNull(Dia8,0)), Sum(IsNull(Dia9,0)), Sum(IsNull(Dia10,0)), Sum(IsNull(Dia11,0)), Sum(IsNull(Dia12,0)), Sum(IsNull(Dia13,0)), Sum(IsNull(Dia14,0)), Sum(IsNull(Dia15,0)), 
		Sum(IsNull(Dia16,0)), Sum(IsNull(Dia17,0)), Sum(IsNull(Dia18,0)), Sum(IsNull(Dia19,0)), Sum(IsNull(Dia20,0)), Sum(IsNull(Dia21,0)), Sum(IsNull(Dia22,0)), Sum(IsNull(Dia23,0)), 
		Sum(IsNull(Dia24,0)), Sum(IsNull(Dia25,0)), Sum(IsNull(Dia26,0)), Sum(IsNull(Dia27,0)), Sum(IsNull(Dia28,0)), Sum(IsNull(Dia29,0)), Sum(IsNull(Dia30,0)), Sum(IsNull(Dia31,0)),
		Sum(IsNull(Dia32,0)), Sum(IsNull(Dia33,0)), Sum(IsNull(Dia34,0)), Sum(IsNull(Dia35,0)), Sum(IsNull(Dia36,0)), Sum(IsNull(Dia37,0)), Sum(IsNull(Dia38,0)), Sum(IsNull(Dia39,0)), 
		Sum(IsNull(Dia40,0)), Sum(IsNull(Dia41,0)), Sum(IsNull(Dia42,0)), Sum(IsNull(Dia43,0)), Sum(IsNull(Dia44,0)), Sum(IsNull(Dia45,0)), Sum(IsNull(Dia46,0)), Sum(IsNull(Dia47,0)), 
		Sum(IsNull(Dia48,0)), Sum(IsNull(Dia49,0)), Sum(IsNull(Dia50,0)), Sum(IsNull(Dia51,0)), Sum(IsNull(Dia52,0)), Sum(IsNull(Dia53,0)), Sum(IsNull(Dia54,0)), Sum(IsNull(Dia55,0)), 
		Sum(IsNull(Dia56,0)), Sum(IsNull(Dia57,0)), Sum(IsNull(Dia58,0)), Sum(IsNull(Dia59,0)), Sum(IsNull(Dia60,0))
	 FROM #Auxiliar6 a
	 GROUP BY Codigo

	SET NOCOUNT OFF

	SELECT * 
	FROM #Auxiliar7 
	ORDER BY Codigo, RubroContable

	DROP TABLE #Auxiliar6
	DROP TABLE #Auxiliar7
  END

--SELECT * FROM #Auxiliar3 ORDER BY Comprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5

/*
CREATE TABLE #Auxiliar1
			(
			 IdRecibo INTEGER,
			 Fecha DATETIME,
			 Detalle VARCHAR(100),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetRV.IdRecibo,
  ISNULL(DetRV.FechaVencimiento,Recibos.FechaRecibo),
  'RE '+Convert(varchar,IsNull(Recibos.NumeroRecibo,0))+' '+IsNull(TiposComprobante.DescripcionAB,'')+' '+
	Case When DetRV.NumeroValor is not null Then Convert(varchar,DetRV.NumeroValor)+' ' Else '' End+
	Case When DetRV.FechaVencimiento is not null Then 'Vto. '+Convert(varchar,DetRV.FechaVencimiento,103)+' ' Else '' End+
	Case When Bancos.Nombre is not null Then Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS 
		When Cajas.Descripcion is not null Then Cajas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS 
		 Else ''
	End,
  DetRV.Importe * IsNull(Recibos.CotizacionMoneda,1)
 FROM DetalleRecibosValores DetRV
 LEFT OUTER JOIN Recibos ON DetRV.IdRecibo=Recibos.IdRecibo
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetRV.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetRV.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetRV.IdCaja
 WHERE 	Recibos.FechaRecibo between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')='NO'

CREATE TABLE #Auxiliar2
			(
			 IdRecibo INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdRecibo,
  SUM(#Auxiliar1.Importe)
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdRecibo


CREATE TABLE #Auxiliar4
			(
			 IdOrdenPago INTEGER,
			 Fecha DATETIME,
			 Detalle VARCHAR(100),
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar4 
 SELECT 
  DetOPV.IdOrdenPago,
  ISNULL(DetOPV.FechaVencimiento,OrdenesPago.FechaOrdenPago),
  'OP '+Convert(varchar,IsNull(OrdenesPago.NumeroOrdenPago,0))+' '+
	Case When DetOPV.IdValor is not null Then TiposComprobante.DescripcionAB+' (Terc.)' Else TiposComprobante.DescripcionAB End+' '+
	Case When DetOPV.NumeroValor is not null Then Convert(varchar,DetOPV.NumeroValor)+' ' Else '' End+
	Case When DetOPV.FechaVencimiento is not null Then 'Vto. '+Convert(varchar,DetOPV.FechaVencimiento,103)+' ' Else '' End+
	Case When Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS is not null 
		Then Bancos.Nombre COLLATE SQL_Latin1_General_CP1_CI_AS 
		Else IsNull(Cajas.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')
	End,
  DetOPV.Importe * IsNull(OrdenesPago.CotizacionMoneda,1)
 FROM DetalleOrdenesPagoValores DetOPV
 LEFT OUTER JOIN OrdenesPago ON DetOPV.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=DetOPV.IdTipoValor
 LEFT OUTER JOIN Bancos ON Bancos.IdBanco=DetOPV.IdBanco
 LEFT OUTER JOIN Cajas ON Cajas.IdCaja=DetOPV.IdCaja
 WHERE 	OrdenesPago.FechaOrdenPago between @Desde and @Hasta and IsNull(OrdenesPago.Anulada,'NO')='NO'

CREATE TABLE #Auxiliar5
			(
			 IdOrdenPago INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar5 
 SELECT 
  #Auxiliar4.IdOrdenPago,
  SUM(#Auxiliar4.Importe)
 FROM #Auxiliar4
 GROUP BY #Auxiliar4.IdOrdenPago


CREATE TABLE #Auxiliar3 (Comprobante VARCHAR(20), Importe NUMERIC(18,2))
INSERT INTO #Auxiliar3 
 SELECT 'OP '+Convert(varchar,IsNull(OrdenesPago.NumeroOrdenPago,0)),
	Case When IsNull(#Auxiliar5.Importe,1)<>0
		Then #Auxiliar4.Importe / IsNull(#Auxiliar5.Importe,1) * (DetOP.Importe * IsNull(OrdenesPago.CotizacionMoneda,1))
		Else 0
	End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
 FROM DetalleOrdenesPagoRubrosContables DetOP
 LEFT OUTER JOIN OrdenesPago ON OrdenesPago.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetOP.IdRubroContable
 LEFT OUTER JOIN #Auxiliar4 ON DetOP.IdOrdenPago=#Auxiliar4.IdOrdenPago
 LEFT OUTER JOIN #Auxiliar5 ON DetOP.IdOrdenPago=#Auxiliar5.IdOrdenPago
 WHERE DetOP.IdRubroContable=@IdRubroContable and #Auxiliar4.Fecha between @Desde and @Hasta and IsNull(OrdenesPago.Anulada,'NO')='NO'

 UNION ALL

 SELECT 'RE '+Convert(varchar,IsNull(Recibos.NumeroRecibo,0)),
	Case When IsNull(#Auxiliar2.Importe,1)<>0
		Then #Auxiliar1.Importe / IsNull(#Auxiliar2.Importe,1) * (DetRE.Importe * IsNull(Recibos.CotizacionMoneda,1))
		Else 0
	End * Case When IsNull(RubrosContables.IngresoEgreso,'E')='I' Then 1 Else -1 End
 FROM DetalleRecibosRubrosContables DetRE
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=DetRE.IdRecibo
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetRE.IdRubroContable
 LEFT OUTER JOIN #Auxiliar1 ON DetRE.IdRecibo=#Auxiliar1.IdRecibo
 LEFT OUTER JOIN #Auxiliar2 ON DetRE.IdRecibo=#Auxiliar2.IdRecibo
 WHERE DetRE.IdRubroContable=@IdRubroContable and #Auxiliar1.Fecha between @Desde and @Hasta and IsNull(Recibos.Anulado,'NO')='NO'

 UNION ALL

 SELECT 'CBG '+Convert(varchar,IsNull(Valores.NumeroComprobante,0)), DetV.Importe * IsNull(Valores.CotizacionMoneda,1)
 FROM DetalleValoresRubrosContables DetV 
 LEFT OUTER JOIN Valores ON Valores.IdValor=DetV.IdValor
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
 WHERE IsNull(RubrosContables.IngresoEgreso,'E')='I' and DetV.IdRubroContable=@IdRubroContable and Valores.FechaComprobante between @Desde and @Hasta 

 UNION ALL

 SELECT 'DBG '+Convert(varchar,IsNull(Valores.NumeroComprobante,0)), DetV.Importe * IsNull(Valores.CotizacionMoneda,1) * -1
 FROM DetalleValoresRubrosContables DetV 
 LEFT OUTER JOIN Valores ON Valores.IdValor=DetV.IdValor
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=DetV.IdRubroContable
 WHERE IsNull(RubrosContables.IngresoEgreso,'E')='E' and DetV.IdRubroContable=@IdRubroContable and Valores.FechaComprobante between @Desde and @Hasta 

SET NOCOUNT OFF

SELECT SUM(Importe) as [Importe] FROM #Auxiliar3
--SELECT * FROM #Auxiliar3 ORDER BY Comprobante

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
*/
