CREATE Procedure [dbo].[Bancos_TX_PosicionBancariaAFecha]

@Fecha datetime,
@IdBanco int = Null

AS

SET @IdBanco=IsNull(@IdBanco,-1)

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), 
	@FechaIni1 datetime, @FechaFin1 datetime, @FechaIni2 datetime, @FechaFin2 datetime, @FechaIni3 datetime, @FechaFin3 datetime, @FechaIni4 datetime, @FechaFin4 datetime, 
	@FechaIni5 datetime, @FechaFin5 datetime, @FechaIni6 datetime, @FechaFin6 datetime, @FechaIni7 datetime, @FechaFin7 datetime, @FechaIni8 datetime, @FechaFin8 datetime, 
	@FechaIni9 datetime, @FechaFin9 datetime, @FechaIni10 datetime, 
	@FechaIni01 datetime, @FechaFin01 datetime, @FechaIni02 datetime, @FechaFin02 datetime, @FechaIni03 datetime, @FechaFin03 datetime, @FechaIni04 datetime, @FechaFin04 datetime, 
	@ModeloPosicionBancaria varchar(50)

SET @ModeloPosicionBancaria=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Modelo para posicion bancaria'),'')
SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')

SET @FechaIni1=@Fecha
IF Datepart(dw,@Fecha)=1
	SET @FechaFin1=Dateadd(d,4,@FechaIni1)
IF Datepart(dw,@Fecha)=2
	SET @FechaFin1=Dateadd(d,3,@FechaIni1)
IF Datepart(dw,@Fecha)=3
	SET @FechaFin1=Dateadd(d,2,@FechaIni1)
IF Datepart(dw,@Fecha)=4
	SET @FechaFin1=Dateadd(d,1,@FechaIni1)
IF Datepart(dw,@Fecha)=5
	SET @FechaFin1=@FechaIni1
IF Datepart(dw,@Fecha)=6
	SET @FechaFin1=Dateadd(d,6,@FechaIni1)
IF Datepart(dw,@Fecha)=7
	SET @FechaFin1=Dateadd(d,5,@FechaIni1)
SET @FechaIni2=Dateadd(d,1,@FechaFin1)
SET @FechaFin2=Dateadd(d,6,@FechaIni2)
SET @FechaIni3=Dateadd(d,1,@FechaFin2)
SET @FechaFin3=Dateadd(d,6,@FechaIni3)
SET @FechaIni4=Dateadd(d,1,@FechaFin3)
SET @FechaFin4=Dateadd(d,6,@FechaIni4)

SET @FechaIni01=Dateadd(d,1,@FechaFin4)
SET @FechaFin01=Dateadd(d,6,@FechaIni01)
SET @FechaIni02=Dateadd(d,1,@FechaFin01)
SET @FechaFin02=Dateadd(d,6,@FechaIni02)
SET @FechaIni03=Dateadd(d,1,@FechaFin02)
SET @FechaFin03=Dateadd(d,6,@FechaIni03)
SET @FechaIni04=Dateadd(d,1,@FechaFin03)
SET @FechaFin04=Dateadd(d,6,@FechaIni04)

SET @FechaIni5=Dateadd(d,1,Case When @ModeloPosicionBancaria='Modelo3' Then @FechaFin04 Else @FechaFin4 End)
SET @FechaFin5=Dateadd(d,-1,Dateadd(m,1,Convert(datetime,'01/'+Convert(varchar,Month(@FechaIni5))+'/'+Convert(varchar,Year(@FechaIni5)),103)))
SET @FechaIni6=Dateadd(d,1,@FechaFin5)
SET @FechaFin6=Dateadd(d,-1,Dateadd(m,1,@FechaIni6))
SET @FechaIni7=Dateadd(d,1,@FechaFin6)
SET @FechaFin7=Dateadd(d,-1,Dateadd(m,1,@FechaIni7))
SET @FechaIni8=Dateadd(d,1,@FechaFin7)
SET @FechaFin8=Dateadd(d,-1,Dateadd(m,1,@FechaIni8))
SET @FechaIni9=Dateadd(d,1,@FechaFin8)
SET @FechaFin9=Dateadd(d,-1,Dateadd(m,1,@FechaIni9))
SET @FechaIni10=Dateadd(d,1,@FechaFin9)

-- DETERMINAR SALDO CONTABLE DE BANCOS --
CREATE TABLE #Auxiliar10 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar10 
 SELECT 
  CuentasBancarias.IdCuentaBancaria,
  DetAsi.IdCuenta,
  DetAsi.Debe,
  DetAsi.Haber
 FROM DetalleAsientos DetAsi
 LEFT OUTER JOIN Asientos ON DetAsi.IdAsiento = Asientos.IdAsiento
 LEFT OUTER JOIN Bancos ON DetAsi.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null and asientos.IdCuentaSubdiario is null and Asientos.FechaAsiento<=DATEADD(n,1439,@Fecha)

 UNION ALL

 SELECT
  CuentasBancarias.IdCuentaBancaria,
  Subdiarios.IdCuenta,
  Subdiarios.Debe,
  Subdiarios.Haber
 FROM Subdiarios
 LEFT OUTER JOIN Bancos ON Subdiarios.IdCuenta = Bancos.IdCuenta
 LEFT OUTER JOIN CuentasBancarias ON Bancos.IdBanco = CuentasBancarias.IdBanco
 WHERE CuentasBancarias.IdCuentaBancaria is not null and Subdiarios.FechaComprobante<=DATEADD(n,1439,@Fecha)

CREATE TABLE #Auxiliar11 
			(
			 IdCuentaBancaria INTEGER,
			 IdCuenta INTEGER,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar11 
 SELECT #Auxiliar10.IdCuentaBancaria, #Auxiliar10.IdCuenta, Sum(IsNull(#Auxiliar10.Debe,0)), Sum(IsNull(#Auxiliar10.Haber,0)), 0
 FROM #Auxiliar10
 GROUP BY #Auxiliar10.IdCuentaBancaria, #Auxiliar10.IdCuenta

UPDATE #Auxiliar11 SET Saldo=Debe-Haber

-- DETERMINAR LOS ULTIMOS RESUMENES DE CONCILIACION DE CADA CUENTA BANCARIA --
CREATE TABLE #Auxiliar15 
			(
			 IdCuentaBancaria INTEGER,
			 IdConciliacion INTEGER,
			 Importe NUMERIC(18, 2)
			)

INSERT INTO #Auxiliar15 
 SELECT cb.IdCuentaBancaria, (Select Top 1 C.IdConciliacion From Conciliaciones C Where C.IdCuentaBancaria=cb.IdCuentaBancaria Order By C.FechaFinal Desc), 0
 FROM CuentasBancarias cb

DELETE #Auxiliar15 WHERE IdConciliacion is null

CREATE TABLE #Auxiliar16 
			(
			 IdCuentaBancaria INTEGER,
			 IdConciliacion INTEGER,
			 IdTipoValor INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar16
 SELECT #Auxiliar15.IdCuentaBancaria, DetConc.IdConciliacion, Valores.IdTipoValor, 
	IsNull(
		Case When (Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=Conciliaciones.IdCuentaBancaria) or 
			((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0))) or 
			(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and tc.Coeficiente=-1)
			 Then Case When Valores.Importe>=0 Then Valores.Importe Else Valores.Importe*-1 End 
			When (not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
			 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe*IsNull(tc2.Coeficiente,1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe*IsNull(tc2.Coeficiente,1)<0)
					Then Case When Valores.Importe*IsNull(tc2.Coeficiente,1)>=0 Then Valores.Importe*IsNull(tc2.Coeficiente,1) Else Valores.Importe*IsNull(tc2.Coeficiente,1)*-1 End 
					Else Null 
				End
			Else Null
		End,0) * Isnull(Valores.CotizacionMoneda,1) - 
	IsNull(
		Case When ((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
			   Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
			   ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
				(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0))) or
			   (Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and tc.Coeficiente=1)
			Then Case When Valores.Importe>=0 Then Valores.Importe Else Valores.Importe*-1 End 
			When (not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
			Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe*Isnull(tc2.Coeficiente,1)>=0) or 
						(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe*Isnull(tc2.Coeficiente,1)<0)
					 Then Case When Valores.Importe*Isnull(tc2.Coeficiente,1)>=0 Then Valores.Importe*Isnull(tc2.Coeficiente,1) Else Valores.Importe*Isnull(tc2.Coeficiente,1)*-1 End 
					 Else Null 
				End
			Else Null
		 End,0) * Isnull(Valores.CotizacionMoneda,1)
 FROM DetalleConciliaciones DetConc
 LEFT OUTER JOIN Conciliaciones ON DetConc.IdConciliacion=Conciliaciones.IdConciliacion
 LEFT OUTER JOIN Valores ON DetConc.IdValor=Valores.IdValor
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN TiposComprobante tc2 ON Valores.IdTipoValor=tc2.IdTipoComprobante
 LEFT OUTER JOIN #Auxiliar15 ON #Auxiliar15.IdConciliacion=Conciliaciones.IdConciliacion
 WHERE #Auxiliar15.IdConciliacion is not null and IsNull(Valores.Anulado,'NO')<>'SI' and DetConc.Conciliado is not null and DetConc.Conciliado='NO'

UPDATE #Auxiliar15
SET Importe=IsNull((Select Sum(
	IsNull(
	Case When (Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=Conciliaciones.IdCuentaBancaria) or 
		((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
		 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0))) or 
		(Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and tc.Coeficiente=-1)
		 Then Case When Valores.Importe>=0 Then Valores.Importe Else Valores.Importe*-1 End 
		When (not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		 Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe*IsNull(tc2.Coeficiente,1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe*IsNull(tc2.Coeficiente,1)<0)
				Then Case When Valores.Importe*IsNull(tc2.Coeficiente,1)>=0 Then Valores.Importe*IsNull(tc2.Coeficiente,1) Else Valores.Importe*IsNull(tc2.Coeficiente,1)*-1 End 
				Else Null 
			End
		Else Null
	End,0) * Isnull(Valores.CotizacionMoneda,1) - 
	IsNull(
	Case When ((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		   Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and 
		   ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
		    (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0))) or
		   (Valores.Estado='G' and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria and tc.Coeficiente=1)
		Then Case When Valores.Importe>=0 Then Valores.Importe Else Valores.Importe*-1 End 
		When (not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null and Valores.IdCuentaBancaria=Conciliaciones.IdCuentaBancaria)
		Then 	Case When (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe*Isnull(tc2.Coeficiente,1)>=0) or 
					(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe*Isnull(tc2.Coeficiente,1)<0)
				 Then Case When Valores.Importe*Isnull(tc2.Coeficiente,1)>=0 Then Valores.Importe*Isnull(tc2.Coeficiente,1) Else Valores.Importe*Isnull(tc2.Coeficiente,1)*-1 End 
				 Else Null 
			End
		Else Null
	 End,0) * Isnull(Valores.CotizacionMoneda,1))
	From DetalleConciliaciones DetConc
	Left Outer Join Conciliaciones ON DetConc.IdConciliacion=Conciliaciones.IdConciliacion
	Left Outer Join Valores ON DetConc.IdValor=Valores.IdValor
	Left Outer Join TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
	Left Outer Join TiposComprobante tc2 ON Valores.IdTipoValor=tc2.IdTipoComprobante
	Where DetConc.IdConciliacion = #Auxiliar15.IdConciliacion and IsNull(Valores.Anulado,'NO')<>'SI' and DetConc.Conciliado is not null and DetConc.Conciliado='NO'),0)

-- ********************************************************************** --

CREATE TABLE #Auxiliar1 
			(
			 IdValor INTEGER, 
			 IdCuentaBancaria INTEGER, 
			 IdTipo INTEGER, 
			 Tipo VARCHAR(100), 
			 Semana1 NUMERIC(18,2), 
			 Semana2 NUMERIC(18,2), 
			 Semana3 NUMERIC(18,2), 
			 Semana4 NUMERIC(18,2), 
			 Semana5 NUMERIC(18,2), 
			 Semana6 NUMERIC(18,2), 
			 Semana7 NUMERIC(18,2), 
			 Semana8 NUMERIC(18,2), 
			 Mes1 NUMERIC(18,2), 
			 Mes2 NUMERIC(18,2), 
			 Mes3 NUMERIC(18,2), 
			 Mes4 NUMERIC(18,2), 
			 Mes5 NUMERIC(18,2), 
			 Resto NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 0, IdCuentaBancaria, 1, '1.SALDO INICIAL CONTABLE', Saldo, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar11 

INSERT INTO #Auxiliar1 
 SELECT 0, IdCuentaBancaria, 2, '2.MOVIMIENTOS QUE NO FIGURAN EN EXTRACTO', Importe*-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar15

INSERT INTO #Auxiliar1 
 SELECT 0, #Auxiliar15.IdCuentaBancaria, 3, '3.MOVIMIENTOS QUE NO FIGURAN EN CONTABILIDAD', 
	IsNull(DetConc.Ingresos,0)-IsNull(DetConc.Egresos,0), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar15
 LEFT OUTER JOIN DetalleConciliacionesNoContables DetConc ON DetConc.IdConciliacion=#Auxiliar15.IdConciliacion

INSERT INTO #Auxiliar1 
 SELECT 0, IdCuentaBancaria, 4, '4.CHEQUES PENDIENTES DE INGRESO BANCO', Sum(IsNull(Importe,0)), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar16
 WHERE IdTipoValor=6
 GROUP BY IdCuentaBancaria

INSERT INTO #Auxiliar1 
 SELECT Valores.IdValor, Valores.IdCuentaBancaria, 5, '5.CHEQUES PENDIENTES', 
	Case When Valores.FechaValor between @FechaIni1 and @FechaFin1 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni2 and @FechaFin2 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni3 and @FechaFin3 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni4 and @FechaFin4 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni01 and @FechaFin01 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni02 and @FechaFin02 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni03 and @FechaFin03 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni04 and @FechaFin04 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni5 and @FechaFin5 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni6 and @FechaFin6 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni7 and @FechaFin7 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni8 and @FechaFin8 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor between @FechaIni9 and @FechaFin9 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End, 
	Case When Valores.FechaValor>=@FechaIni10 
		Then Valores.Importe * Isnull(Valores.CotizacionMoneda,1) * Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente) Else 0 End
 FROM Valores 
 LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 WHERE IsNull(Valores.Anulado,'NO')<>'SI' and @ActivarCircuitoChequesDiferidos='SI' and Valores.IdTipoValor=6 and Valores.IdTipoComprobante=17 and 
	Valores.FechaValor>=@FechaIni1 and Valores.IdCuentaBancaria is not null and 
	IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO'

INSERT INTO #Auxiliar1 
 SELECT 0, IdCuentaBancaria, IdTipoValor+1000, '6.'+Upper(tc.Descripcion)+' PENDIENTES DE INGRESO BANCO', Sum(IsNull(Importe,0)), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM #Auxiliar16
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=#Auxiliar16.IdTipoValor
 WHERE IdTipoValor<>6
 GROUP BY IdCuentaBancaria, IdTipoValor, tc.Descripcion


CREATE TABLE #Auxiliar2 
			(
			 IdCuentaBancaria INTEGER, 
			 Tipo VARCHAR(100), 
			 Semana1 NUMERIC(18,2), 
			 Semana2 NUMERIC(18,2), 
			 Semana3 NUMERIC(18,2), 
			 Semana4 NUMERIC(18,2), 
			 Semana5 NUMERIC(18,2), 
			 Semana6 NUMERIC(18,2), 
			 Semana7 NUMERIC(18,2), 
			 Semana8 NUMERIC(18,2), 
			 Mes1 NUMERIC(18,2), 
			 Mes2 NUMERIC(18,2), 
			 Mes3 NUMERIC(18,2), 
			 Mes4 NUMERIC(18,2), 
			 Mes5 NUMERIC(18,2), 
			 Resto NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT IdCuentaBancaria, Tipo, Sum(IsNull(Semana1,0)), Sum(IsNull(Semana2,0)), Sum(IsNull(Semana3,0)), Sum(IsNull(Semana4,0)), Sum(IsNull(Semana5,0)), Sum(IsNull(Semana6,0)), 
	Sum(IsNull(Semana7,0)), Sum(IsNull(Semana8,0)), Sum(IsNull(Mes1,0)), Sum(IsNull(Mes2,0)), Sum(IsNull(Mes3,0)), Sum(IsNull(Mes4,0)), Sum(IsNull(Mes5,0)), Sum(IsNull(Resto,0))
 FROM #Auxiliar1
 GROUP BY IdCuentaBancaria, Tipo

DELETE #Auxiliar2
WHERE Not Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=#Auxiliar2.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '1.SALDO INICIAL CONTABLE', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar1.IdCuentaBancaria=cb.IdCuentaBancaria and #Auxiliar1.IdTipo=1) and 
	Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '2.MOVIMIENTOS QUE NO FIGURAN EN EXTRACTO', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar1.IdCuentaBancaria=cb.IdCuentaBancaria and #Auxiliar1.IdTipo=2) and 
	Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '3.MOVIMIENTOS QUE NO FIGURAN EN CONTABILIDAD', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar1.IdCuentaBancaria=cb.IdCuentaBancaria and #Auxiliar1.IdTipo=3) and 
	Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '4.CHEQUES PENDIENTES DE INGRESO BANCO', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar1.IdCuentaBancaria=cb.IdCuentaBancaria and #Auxiliar1.IdTipo=4) and 
	Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '5.CHEQUES PENDIENTES', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Not Exists(Select Top 1 #Auxiliar1.IdCuentaBancaria From #Auxiliar1 Where #Auxiliar1.IdCuentaBancaria=cb.IdCuentaBancaria and #Auxiliar1.IdTipo=5) and 
	Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)

INSERT INTO #Auxiliar2 
 SELECT cb.IdCuentaBancaria, '7.OTROS', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 FROM CuentasBancarias cb
 WHERE Exists(Select Top 1 Conciliaciones.IdCuentaBancaria From Conciliaciones Where Conciliaciones.IdCuentaBancaria=cb.IdCuentaBancaria)


CREATE TABLE #Auxiliar3 
			(
			 IdCuentaBancaria INTEGER, 
			 Semana1 NUMERIC(18,2), 
			 Semana2 NUMERIC(18,2), 
			 Semana3 NUMERIC(18,2), 
			 Semana4 NUMERIC(18,2), 
			 Semana5 NUMERIC(18,2), 
			 Semana6 NUMERIC(18,2), 
			 Semana7 NUMERIC(18,2), 
			 Semana8 NUMERIC(18,2), 
			 Mes1 NUMERIC(18,2), 
			 Mes2 NUMERIC(18,2), 
			 Mes3 NUMERIC(18,2), 
			 Mes4 NUMERIC(18,2), 
			 Mes5 NUMERIC(18,2), 
			 Resto NUMERIC(18,2)
			)
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.IdCuentaBancaria, Max(Abs(IsNull(#Auxiliar2.Semana1,0))), Max(Abs(IsNull(#Auxiliar2.Semana2,0))), Max(Abs(IsNull(#Auxiliar2.Semana3,0))), 
	Max(Abs(IsNull(#Auxiliar2.Semana4,0))), Max(Abs(IsNull(#Auxiliar2.Semana5,0))), Max(Abs(IsNull(#Auxiliar2.Semana6,0))), Max(Abs(IsNull(#Auxiliar2.Semana7,0))), 
	Max(Abs(IsNull(#Auxiliar2.Semana8,0))), Max(Abs(IsNull(#Auxiliar2.Mes1,0))), Max(Abs(IsNull(#Auxiliar2.Mes2,0))), Max(Abs(IsNull(#Auxiliar2.Mes3,0))), 
	Max(Abs(IsNull(#Auxiliar2.Mes4,0))), Max(Abs(IsNull(#Auxiliar2.Mes5,0))), Max(Abs(IsNull(#Auxiliar2.Resto,0)))
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdCuentaBancaria

SET NOCOUNT OFF

SELECT Bancos.Nombre as [Banco], CuentasBancarias.Cuenta as [Cta.Bco.], #Auxiliar2.*, 
	Convert(varchar,Day(@FechaIni1))+'/'+Convert(varchar,Month(@FechaIni1))+' al '+Convert(varchar,Day(@FechaFin1))+'/'+Convert(varchar,Month(@FechaFin1)) as [DatosSemana1],
	Convert(varchar,Day(@FechaIni2))+'/'+Convert(varchar,Month(@FechaIni2))+' al '+Convert(varchar,Day(@FechaFin2))+'/'+Convert(varchar,Month(@FechaFin2)) as [DatosSemana2],
	Convert(varchar,Day(@FechaIni3))+'/'+Convert(varchar,Month(@FechaIni3))+' al '+Convert(varchar,Day(@FechaFin3))+'/'+Convert(varchar,Month(@FechaFin3)) as [DatosSemana3],
	Convert(varchar,Day(@FechaIni4))+'/'+Convert(varchar,Month(@FechaIni4))+' al '+Convert(varchar,Day(@FechaFin4))+'/'+Convert(varchar,Month(@FechaFin4)) as [DatosSemana4],
	Convert(varchar,Day(@FechaIni01))+'/'+Convert(varchar,Month(@FechaIni01))+' al '+Convert(varchar,Day(@FechaFin01))+'/'+Convert(varchar,Month(@FechaFin01)) as [DatosSemana5],
	Convert(varchar,Day(@FechaIni02))+'/'+Convert(varchar,Month(@FechaIni02))+' al '+Convert(varchar,Day(@FechaFin02))+'/'+Convert(varchar,Month(@FechaFin02)) as [DatosSemana6],
	Convert(varchar,Day(@FechaIni03))+'/'+Convert(varchar,Month(@FechaIni03))+' al '+Convert(varchar,Day(@FechaFin03))+'/'+Convert(varchar,Month(@FechaFin03)) as [DatosSemana7],
	Convert(varchar,Day(@FechaIni04))+'/'+Convert(varchar,Month(@FechaIni04))+' al '+Convert(varchar,Day(@FechaFin04))+'/'+Convert(varchar,Month(@FechaFin04)) as [DatosSemana8],
	Case When Month(@FechaIni5)=1 Then 'Enero' When Month(@FechaIni5)=2 Then 'Febrero' When Month(@FechaIni5)=3 Then 'Marzo'
		When Month(@FechaIni5)=4 Then 'Abril' When Month(@FechaIni5)=5 Then 'Mayo' When Month(@FechaIni5)=6 Then 'Junio'
		When Month(@FechaIni5)=7 Then 'Julio' When Month(@FechaIni5)=8 Then 'Agosto' When Month(@FechaIni5)=9 Then 'Setiembre'
		When Month(@FechaIni5)=10 Then 'Octubre' When Month(@FechaIni5)=11 Then 'Noviembre' When Month(@FechaIni5)=12 Then 'Diciembre'
		Else ''
	End as [DatosMes1],
	Case When Month(@FechaIni6)=1 Then 'Enero' When Month(@FechaIni6)=2 Then 'Febrero' When Month(@FechaIni6)=3 Then 'Marzo'
		When Month(@FechaIni6)=4 Then 'Abril' When Month(@FechaIni6)=5 Then 'Mayo' When Month(@FechaIni6)=6 Then 'Junio'
		When Month(@FechaIni6)=7 Then 'Julio' When Month(@FechaIni6)=8 Then 'Agosto' When Month(@FechaIni6)=9 Then 'Setiembre'
		When Month(@FechaIni6)=10 Then 'Octubre' When Month(@FechaIni6)=11 Then 'Noviembre' When Month(@FechaIni6)=12 Then 'Diciembre'
		Else ''
	End as [DatosMes2],
	Case When Month(@FechaIni7)=1 Then 'Enero' When Month(@FechaIni7)=2 Then 'Febrero' When Month(@FechaIni7)=3 Then 'Marzo'
		When Month(@FechaIni7)=4 Then 'Abril' When Month(@FechaIni7)=5 Then 'Mayo' When Month(@FechaIni7)=6 Then 'Junio'
		When Month(@FechaIni7)=7 Then 'Julio' When Month(@FechaIni7)=8 Then 'Agosto' When Month(@FechaIni7)=9 Then 'Setiembre'
		When Month(@FechaIni7)=10 Then 'Octubre' When Month(@FechaIni7)=11 Then 'Noviembre' When Month(@FechaIni7)=12 Then 'Diciembre'
		Else ''
	End as [DatosMes3],
	Case When Month(@FechaIni8)=1 Then 'Enero' When Month(@FechaIni8)=2 Then 'Febrero' When Month(@FechaIni8)=3 Then 'Marzo'
		When Month(@FechaIni8)=4 Then 'Abril' When Month(@FechaIni8)=5 Then 'Mayo' When Month(@FechaIni8)=6 Then 'Junio'
		When Month(@FechaIni8)=7 Then 'Julio' When Month(@FechaIni8)=8 Then 'Agosto' When Month(@FechaIni8)=9 Then 'Setiembre'
		When Month(@FechaIni8)=10 Then 'Octubre' When Month(@FechaIni8)=11 Then 'Noviembre' When Month(@FechaIni8)=12 Then 'Diciembre'
		Else ''
	End as [DatosMes4],
	Case When Month(@FechaIni9)=1 Then 'Enero' When Month(@FechaIni9)=2 Then 'Febrero' When Month(@FechaIni9)=3 Then 'Marzo'
		When Month(@FechaIni9)=4 Then 'Abril' When Month(@FechaIni9)=5 Then 'Mayo' When Month(@FechaIni9)=6 Then 'Junio'
		When Month(@FechaIni9)=7 Then 'Julio' When Month(@FechaIni9)=8 Then 'Agosto' When Month(@FechaIni9)=9 Then 'Setiembre'
		When Month(@FechaIni9)=10 Then 'Octubre' When Month(@FechaIni9)=11 Then 'Noviembre' When Month(@FechaIni9)=12 Then 'Diciembre'
		Else ''
	End as [DatosMes5],
	Convert(varchar,Year(@FechaIni10)) as [DatosResto], CuentasBancarias.IdBanco as [IdBanco]
FROM #Auxiliar2 
LEFT OUTER JOIN CuentasBancarias ON CuentasBancarias.IdCuentaBancaria=#Auxiliar2.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=CuentasBancarias.IdBanco
LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdCuentaBancaria=#Auxiliar2.IdCuentaBancaria
WHERE (#Auxiliar3.Semana1<>0 or #Auxiliar3.Semana2<>0 or #Auxiliar3.Semana3<>0 or #Auxiliar3.Semana4<>0 or #Auxiliar3.Mes1<>0 or #Auxiliar3.Mes2<>0 or #Auxiliar3.Mes3<>0 or #Auxiliar3.Mes4<>0 or #Auxiliar3.Mes5<>0 or #Auxiliar3.Resto<>0) and
	(@IdBanco=-1 or CuentasBancarias.IdBanco=@IdBanco)
ORDER BY [Banco], [Cta.Bco.], #Auxiliar2.Tipo


DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar15
DROP TABLE #Auxiliar16
/*
select @FechaIni1 as [FechaIni1], @FechaFin1 as [FechaFin1], @FechaIni2 as [FechaIni2], @FechaFin2 as [FechaFin2], 
		@FechaIni3 as [FechaIni3], @FechaFin3 as [FechaFin3], @FechaIni4 as [FechaIni4], @FechaFin4 as [FechaFin4], 
		@FechaIni01 as [FechaIni01], @FechaFin01 as [FechaFin01], @FechaIni02 as [FechaIni02], @FechaFin02 as [FechaFin02], 
		@FechaIni03 as [FechaIni03], @FechaFin03 as [FechaFin03], @FechaIni04 as [FechaIni04], @FechaFin04 as [FechaFin04], 
		@FechaIni5 as [FechaIni5], @FechaFin5 as [FechaFin5], @FechaIni6 as [FechaIni6], @FechaFin6 as [FechaFin6], 
		@FechaIni7 as [FechaIni7], @FechaFin7 as [FechaFin7], @FechaIni8 as [FechaIni8], @FechaFin8 as [FechaFin8], 
		@FechaIni9 as [FechaIni9], @FechaFin9 as [FechaFin9], @FechaIni10 as [FechaIni10]
*/