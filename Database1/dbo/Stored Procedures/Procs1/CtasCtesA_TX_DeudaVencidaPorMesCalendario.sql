CREATE Procedure [dbo].[CtasCtesA_TX_DeudaVencidaPorMesCalendario]

@Fecha datetime,
@ActivaRango int,
@CodigoDesde varchar(20),
@CodigoHasta varchar(20),
@FiltraSaldos0 int,
@IncluirCreditosNoAplicados int,
@IncluirNoVencido varchar(2),
@UsarFechaVencimiento varchar(2) = Null, 
@CalcularFechaVencimientoDesdeRecepcion varchar(2) = Null,
@UsarFechaComprobante varchar(2) = Null,
@IdObra int = Null

AS 

SET NOCOUNT ON

DECLARE @IdCtaCte int, @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, @IdProveedor1 int, 
	@IdProveedor2 int, @IdProveedorAnt int, @SaldoCuota1 numeric(18,2), @SaldoCuota2 numeric(18,2), 
	@ImporteCuota numeric(18,2), @ImporteCuota1 numeric(18,2), @ImporteCuota2 numeric(18,2), @A_Fecha datetime, @SaldoAAplicar numeric(18,2), 
	@SaldoAplicado numeric(18,2), @Diferencia numeric(18,2), @IdAux int, @IdTipoComprobanteOrdenPago int, @ModeloListado varchar(2)

SET @UsarFechaVencimiento=IsNull(@UsarFechaVencimiento,'NO')
SET @CalcularFechaVencimientoDesdeRecepcion=IsNull(@CalcularFechaVencimientoDesdeRecepcion,'NO')
SET @UsarFechaComprobante=IsNull(@UsarFechaComprobante,'NO')
SET @IdTipoComprobanteOrdenPago=IsNull((Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1),0)
SET @IdObra=IsNull(@IdObra,-1)

SET @ModeloListado=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
				Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
				Where pic.Clave='Modelo listado para deuda vencida por mes calendario'),'')

/*   CALCULAR SALDOS DE CUENTA CORRIENTE A LA FECHA INDICADA CON APERTURA POR CONDICIONES DE COMPRA   */
CREATE TABLE #Auxiliar1 
			(
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_IdImputacion INTEGER,
			 A_IdCondicionCompra INTEGER,
			 A_Coeficiente INTEGER,
			 A_ImporteCuota NUMERIC(18, 2),
			 A_SaldoCuota NUMERIC(18, 2),
			 A_Dias INTEGER,
			 A_Meses INTEGER,
			 A_RubroFinanciero VARCHAR(30),
			 A_Observaciones VARCHAR(50),
			 A_IdObra INTEGER,
			 A_IdAux INTEGER,
			 A_FechaPrestacionServicio DATETIME
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdImputacion, A_Fecha) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (A_IdAux, A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  Case When @UsarFechaComprobante='SI' Then CtaCte.Fecha
	Else 
	  Case When IsNull(Tmp.Dias,0)=0 and IsNull(Tmp.Porcentaje,100)=100
		Then IsNull(IsNull(CtaCte.FechaVencimiento,cp.FechaComprobante),CtaCte.Fecha)
		Else 	Case When @CalcularFechaVencimientoDesdeRecepcion='NO' 
				Then DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaComprobante,CtaCte.FechaVencimiento))
				Else DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaRecepcion,CtaCte.FechaVencimiento))
			End
	  End
  End,
  Case When cp.FechaRecepcion is not null
	Then 'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+
		TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
	Else Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+
		Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  IsNull(CtaCte.IdImputacion,0),
  cp.IdCondicionCompra,
  1,
  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,
  CtaCte.ImporteTotal * IsNull(Tmp.Porcentaje,100)/100,
  0,
  0,
  (Select Top 1 SubString(RubrosContables.Descripcion,1,30)
   From  DetalleComprobantesProveedores DetCom
   Left Outer Join RubrosContables On RubrosContables.IdRubroContable=DetCom.IdRubroContable
   Where DetCom.IdComprobanteProveedor=cp.IdComprobanteProveedor and RubrosContables.Descripcion is not null),
  Case When cp.DestinoPago='A' Then 'ADM'
	When cp.DestinoPago='O' Then 'OBRA'
	Else Null
  End,
  cp.IdObra,
  IsNull(Tmp.IdAux,0),
  cp.FechaPrestacionServicio
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON cp.IdCondicionCompra=Tmp.IdCondicionCompra and @UsarFechaVencimiento='NO' and @UsarFechaComprobante='NO'
 LEFT OUTER JOIN Proveedores ON CtaCte.IdProveedor=Proveedores.IdProveedor
 WHERE TiposComprobante.Coeficiente=1 and CtaCte.Fecha<=@Fecha and 
	(@ActivaRango=-1 or (Proveedores.CodigoEmpresa>=@CodigoDesde and Proveedores.CodigoEmpresa<=@CodigoHasta))

UPDATE #Auxiliar1
SET A_Dias=DATEDIFF(day,A_Fecha,@Fecha), A_Meses=DATEDIFF(m,@Fecha,A_Fecha)

CREATE TABLE #Auxiliar11 
			(
			 A_IdCtaCte INTEGER,
			 A_TotalImporteCuota NUMERIC(18, 2),
			 A_TotalComprobante NUMERIC(18, 2),
			 A_Diferencia NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar11 
 SELECT A_IdCtaCte, Sum(A_ImporteCuota), 0, 0
 FROM #Auxiliar1
 GROUP BY A_IdCtaCte

UPDATE #Auxiliar11
SET A_TotalComprobante=(Select Top 1 ImporteTotal From CuentasCorrientesAcreedores Where IdCtaCte=#Auxiliar11.A_IdCtaCte)
UPDATE #Auxiliar11
SET A_Diferencia=A_TotalComprobante-A_TotalImporteCuota

DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_ImporteCuota, A_IdAux FROM #Auxiliar1 ORDER BY A_IdCtaCte 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte, @ImporteCuota, @IdAux
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @Diferencia=IsNull((Select Top 1 A_Diferencia From #Auxiliar11 Where A_IdCtaCte=@IdCtaCte),0)
	IF @Diferencia<>0
	    BEGIN
		UPDATE #Auxiliar1
		SET A_ImporteCuota=A_ImporteCuota+@Diferencia, A_SaldoCuota=A_SaldoCuota+@Diferencia
		WHERE #Auxiliar1.A_IdAux=@IdAux and #Auxiliar1.A_IdCtaCte=@IdCtaCte

		UPDATE #Auxiliar11
		SET A_Diferencia = 0
		WHERE A_IdCtaCte=@IdCtaCte
	    END
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte, @ImporteCuota, @IdAux
    END
CLOSE CtaCte1
DEALLOCATE CtaCte1

CREATE TABLE #Auxiliar2 
			(
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_Detalle VARCHAR(100),
			 A_IdImputacion INTEGER,
			 A_IdCondicionCompra INTEGER,
			 A_Coeficiente INTEGER,
			 A_ImporteCuota NUMERIC(18, 2),
			 A_SaldoCuota NUMERIC(18, 2),
			 A_Dias INTEGER,
			 A_Meses INTEGER,
			 A_RubroFinanciero VARCHAR(30),
			 A_IdObra INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdImputacion, A_Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  Convert(varchar,CtaCte.Fecha,103)+' '+TiposComprobante.Descripcion+' '+
	Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),
  IsNull(CtaCte.IdImputacion,0),
  Null,
  -1,
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal,
  0,
  0,
  '',
  cp.IdObra
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON CtaCte.IdProveedor=Proveedores.IdProveedor
 LEFT OUTER JOIN DetalleOrdenesPago dop ON dop.IdDetalleOrdenPago=CtaCte.IdDetalleOrdenPago
 LEFT OUTER JOIN CuentasCorrientesAcreedores CtaCte1 ON CtaCte1.IdCtaCte=dop.IdImputacion
 LEFT OUTER JOIN TiposComprobante tc1 ON tc1.IdTipoComprobante=CtaCte1.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte1.IdComprobante
 WHERE TiposComprobante.Coeficiente=-1 and CtaCte.Fecha<=@Fecha and 
	(@ActivaRango=-1 or (Proveedores.CodigoEmpresa>=@CodigoDesde and Proveedores.CodigoEmpresa<=@CodigoHasta))

CREATE TABLE #Auxiliar3 (A_Meses INTEGER)
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar1.A_Meses
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.A_Meses

UPDATE #Auxiliar1
SET A_Fecha=CONVERT(datetime,@Fecha,103)
WHERE #Auxiliar1.A_Fecha Is Null

UPDATE #Auxiliar2
SET A_Fecha=CONVERT(datetime,@Fecha,103)
WHERE #Auxiliar2.A_Fecha Is Null

/*  CURSORES  */
DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
		FROM #Auxiliar2
		WHERE A_SaldoCuota<>0 and A_IdImputacion<>0
		ORDER BY A_IdImputacion, A_Fecha 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoAAplicar=@SaldoCuota1
	SET @IdImputacionAnt=@IdImputacion1
	SET @IdProveedorAnt=@IdProveedor1

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota
			FROM #Auxiliar1
			WHERE A_SaldoCuota<>0 and A_IdImputacion=@IdImputacionAnt and A_IdProveedor=@IdProveedorAnt
			ORDER BY A_IdImputacion, A_Fecha 
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	   BEGIN
		IF @SaldoAAplicar>=@SaldoCuota2
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@SaldoCuota2
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@SaldoCuota2-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		UPDATE #Auxiliar1
		SET A_SaldoCuota = @SaldoAplicado
		WHERE CURRENT OF CtaCte2

		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteCuota2, @SaldoCuota2
	   END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	BEGIN
		UPDATE #Auxiliar2
		SET A_SaldoCuota = @SaldoAAplicar
		WHERE CURRENT OF CtaCte1
	END
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

DECLARE @vector_X varchar(100), @vector_T varchar(100), @vector_E varchar(1000), @Contador int
SET @vector_X='000001111166611666666666666666666666666666111133'
IF @ModeloListado='01'
	SET @vector_T='000000004133933'
ELSE
	SET @vector_T='000000004133333'
SET @vector_E='  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  '
SET @Contador=-13
--SET @vector_X='000001111166611666666666666133'
--SET @vector_T='000000004133333222222222222E00'
WHILE @Contador<=13
    BEGIN
	IF @Contador=-13
	    BEGIN
		IF Exists(Select Top 1 A_Meses FROM #Auxiliar3 Where A_Meses<=-13)
			SET @vector_T=@vector_T+'2'
		ELSE
			SET @vector_T=@vector_T+'9'
	    END
	ELSE
		IF @Contador=13
		    BEGIN
			IF Exists(Select Top 1 A_Meses FROM #Auxiliar3 Where A_Meses>=13)
				SET @vector_T=@vector_T+'2'
			ELSE
				SET @vector_T=@vector_T+'9'
		    END
		ELSE
		    BEGIN
			IF Exists(Select Top 1 A_Meses FROM #Auxiliar3 Where A_Meses=@Contador)
				SET @vector_T=@vector_T+'2'
			ELSE
				SET @vector_T=@vector_T+'9'
		    END
	SET @Contador=@Contador+1
    END
SET @vector_T=@vector_T+'E24900'

IF @IncluirCreditosNoAplicados=-1
    BEGIN
	IF @ModeloListado='01'
		UPDATE #Auxiliar2
		SET A_Fecha=IsNull((Select Top 1 A_Fecha From #Auxiliar1 a1 Where a1.A_IdProveedor=#Auxiliar2.A_IdProveedor and IsNull(a1.A_SaldoCuota,0)<>0 Order By a1.A_IdProveedor,a1.A_Fecha),Convert(datetime,@Fecha,103)), 
			A_Meses=IsNull((Select Top 1 A_Meses From #Auxiliar1 a1 Where a1.A_IdProveedor=#Auxiliar2.A_IdProveedor and IsNull(a1.A_SaldoCuota,0)<>0 Order By a1.A_IdProveedor,a1.A_Fecha),#Auxiliar2.A_Meses)

	INSERT INTO #Auxiliar1 
	 SELECT 
	  0,
	  A_IdProveedor,
	  Max(A_Fecha),
	  'Creditos no aplicados',
	  Null,
	  Null,
	  -1,
	  Null,
	  Sum(IsNull(A_SaldoCuota,0))*-1,
	  1,
	  Max(A_Meses),
	  '',
	  Null,
	  Null,
	  Null,
	  Null
	 FROM #Auxiliar2
	 GROUP BY A_IdProveedor
--select * from #Auxiliar1 order by A_IdProveedor,A_Fecha
    END

IF @FiltraSaldos0=-1
	DELETE FROM #Auxiliar1
	WHERE IsNull(A_SaldoCuota,0)=0

IF @IdObra>0
	DELETE FROM #Auxiliar1
	WHERE IsNull(A_IdObra,0)<>@IdObra

SET NOCOUNT OFF

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 Null as [K_FechaVencimiento],
 0 as [K_Orden],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 Null as [Comprobante],
 Null as [Fecha vto.],
 Null as [Rubro financiero],
 Null as [Importe],
 Null as [Saldo],
 Null as [Cred.N/apl.],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 Null as [-99],
 Null as [-12],
 Null as [-11],
 Null as [-10],
 Null as [-9],
 Null as [-8],
 Null as [-7],
 Null as [-6],
 Null as [-5],
 Null as [-4],
 Null as [-3],
 Null as [-2],
 Null as [-1],
 Null as [0],
 Null as [+1],
 Null as [+2],
 Null as [+3],
 Null as [+4],
 Null as [+5],
 Null as [+6],
 Null as [+7],
 Null as [+8],
 Null as [+9],
 Null as [+10],
 Null as [+11],
 Null as [+12],
 Null as [+99],
 Null as [Obs.],
 Null as [Obra],
 Null as [Fecha prest.serv.],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0)
GROUP BY Proveedores.CodigoEmpresa, Proveedores.RazonSocial

UNION ALL 

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 #Auxiliar1.A_Fecha as [K_FechaVencimiento],
 1 as [K_Orden],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 #Auxiliar1.A_Detalle as [Comprobante],
 #Auxiliar1.A_Fecha as [Fecha vto.],
 #Auxiliar1.A_RubroFinanciero as [Rubro financiero],
 #Auxiliar1.A_ImporteCuota as [Importe],
 Case When #Auxiliar1.A_SaldoCuota>=0 or @ModeloListado='01' Then #Auxiliar1.A_SaldoCuota Else Null End as [Saldo],
 Case When #Auxiliar1.A_SaldoCuota<0 Then #Auxiliar1.A_SaldoCuota Else Null End as [Cred.N/apl.],
 Case When #Auxiliar1.A_Dias>=0 Then #Auxiliar1.A_Dias Else Null End as [Ds.Venc.],
 Case When #Auxiliar1.A_Dias>=0 Then Null Else #Auxiliar1.A_Dias * -1 End as [Ds.A Vencer],
 Case When #Auxiliar1.A_Meses<-12 Then #Auxiliar1.A_SaldoCuota Else Null End as [-99],
 Case When #Auxiliar1.A_Meses=-12 Then #Auxiliar1.A_SaldoCuota Else Null End as [-12],
 Case When #Auxiliar1.A_Meses=-11 Then #Auxiliar1.A_SaldoCuota Else Null End as [-11],
 Case When #Auxiliar1.A_Meses=-10 Then #Auxiliar1.A_SaldoCuota Else Null End as [-10],
 Case When #Auxiliar1.A_Meses=-9 Then #Auxiliar1.A_SaldoCuota Else Null End as [-9],
 Case When #Auxiliar1.A_Meses=-8 Then #Auxiliar1.A_SaldoCuota Else Null End as [-8],
 Case When #Auxiliar1.A_Meses=-7 Then #Auxiliar1.A_SaldoCuota Else Null End as [-7],
 Case When #Auxiliar1.A_Meses=-6 Then #Auxiliar1.A_SaldoCuota Else Null End as [-6],
 Case When #Auxiliar1.A_Meses=-5 Then #Auxiliar1.A_SaldoCuota Else Null End as [-5],
 Case When #Auxiliar1.A_Meses=-4 Then #Auxiliar1.A_SaldoCuota Else Null End as [-4],
 Case When #Auxiliar1.A_Meses=-3 Then #Auxiliar1.A_SaldoCuota Else Null End as [-3],
 Case When #Auxiliar1.A_Meses=-2 Then #Auxiliar1.A_SaldoCuota Else Null End as [-2],
 Case When #Auxiliar1.A_Meses=-1 Then #Auxiliar1.A_SaldoCuota Else Null End as [-1],
 Case When #Auxiliar1.A_Meses=0 Then #Auxiliar1.A_SaldoCuota Else Null End as [0],
 Case When #Auxiliar1.A_Meses=1 Then #Auxiliar1.A_SaldoCuota Else Null End as [+1],
 Case When #Auxiliar1.A_Meses=2 Then #Auxiliar1.A_SaldoCuota Else Null End as [+2],
 Case When #Auxiliar1.A_Meses=3 Then #Auxiliar1.A_SaldoCuota Else Null End as [+3],
 Case When #Auxiliar1.A_Meses=4 Then #Auxiliar1.A_SaldoCuota Else Null End as [+4],
 Case When #Auxiliar1.A_Meses=5 Then #Auxiliar1.A_SaldoCuota Else Null End as [+5],
 Case When #Auxiliar1.A_Meses=6 Then #Auxiliar1.A_SaldoCuota Else Null End as [+6],
 Case When #Auxiliar1.A_Meses=7 Then #Auxiliar1.A_SaldoCuota Else Null End as [+7],
 Case When #Auxiliar1.A_Meses=8 Then #Auxiliar1.A_SaldoCuota Else Null End as [+8],
 Case When #Auxiliar1.A_Meses=9 Then #Auxiliar1.A_SaldoCuota Else Null End as [+9],
 Case When #Auxiliar1.A_Meses=10 Then #Auxiliar1.A_SaldoCuota Else Null End as [+10],
 Case When #Auxiliar1.A_Meses=11 Then #Auxiliar1.A_SaldoCuota Else Null End as [+11],
 Case When #Auxiliar1.A_Meses=12 Then #Auxiliar1.A_SaldoCuota Else Null End as [+12],
 Case When #Auxiliar1.A_Meses>12 Then #Auxiliar1.A_SaldoCuota Else Null End as [+99],
 #Auxiliar1.A_Observaciones as [Obs.],
 Obras.NumeroObra as [Obra],
 #Auxiliar1.A_FechaPrestacionServicio as [Fecha prest.serv.],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Obras ON #Auxiliar1.A_IdObra=Obras.IdObra
WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0)

UNION ALL 

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 Null as [K_FechaVencimiento],
 2 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 '    TOTAL PROVEEDOR' as [Comprobante],
 Null as [Fecha vto.],
 Null as [Rubro financiero],
 SUM(IsNull(#Auxiliar1.A_ImporteCuota,0)) as [Importe],
 SUM(Case When #Auxiliar1.A_SaldoCuota>=0 or @ModeloListado='01' Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Saldo],
 SUM(Case When #Auxiliar1.A_SaldoCuota<0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Cred.N/apl.],
 Null as [Ds.Venc.], Null as [Ds.A Vencer],
 SUM(Case When #Auxiliar1.A_Meses<-12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-99],
 SUM(Case When #Auxiliar1.A_Meses=-12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-12],
 SUM(Case When #Auxiliar1.A_Meses=-11 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-11],
 SUM(Case When #Auxiliar1.A_Meses=-10 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-10],
 SUM(Case When #Auxiliar1.A_Meses=-9 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-9],
 SUM(Case When #Auxiliar1.A_Meses=-8 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-8],
 SUM(Case When #Auxiliar1.A_Meses=-7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-7],
 SUM(Case When #Auxiliar1.A_Meses=-6 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-6],
 SUM(Case When #Auxiliar1.A_Meses=-5 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-5],
 SUM(Case When #Auxiliar1.A_Meses=-4 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-4],
 SUM(Case When #Auxiliar1.A_Meses=-3 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-3],
 SUM(Case When #Auxiliar1.A_Meses=-2 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-2],
 SUM(Case When #Auxiliar1.A_Meses=-1 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-1],
 SUM(Case When #Auxiliar1.A_Meses=0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0],
 SUM(Case When #Auxiliar1.A_Meses=1 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+1],
 SUM(Case When #Auxiliar1.A_Meses=2 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+2],
 SUM(Case When #Auxiliar1.A_Meses=3 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+3],
 SUM(Case When #Auxiliar1.A_Meses=4 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+4],
 SUM(Case When #Auxiliar1.A_Meses=5 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+5],
 SUM(Case When #Auxiliar1.A_Meses=6 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+6],
 SUM(Case When #Auxiliar1.A_Meses=7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+7],
 SUM(Case When #Auxiliar1.A_Meses=8 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+8],
 SUM(Case When #Auxiliar1.A_Meses=9 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+9],
 SUM(Case When #Auxiliar1.A_Meses=10 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+10],
 SUM(Case When #Auxiliar1.A_Meses=11 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+11],
 SUM(Case When #Auxiliar1.A_Meses=12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+12],
 SUM(Case When #Auxiliar1.A_Meses>12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+99],
 Null as [Obs.],
 Null as [Obra],
 Null as [Fecha prest.serv.],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0)
GROUP BY Proveedores.CodigoEmpresa, Proveedores.RazonSocial

UNION ALL 

SELECT 
 0 as [IdAux],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 Null as [K_FechaVencimiento],
 3 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Comprobante],
 Null as [Fecha vto.],
 Null as [Rubro financiero],
 Null as [Importe],
 Null as [Saldo],
 Null as [Cred.N/apl.],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 Null as [-99],
 Null as [-12],
 Null as [-11],
 Null as [-10],
 Null as [-9],
 Null as [-8],
 Null as [-7],
 Null as [-6],
 Null as [-5],
 Null as [-4],
 Null as [-3],
 Null as [-2],
 Null as [-1],
 Null as [0],
 Null as [+1],
 Null as [+2],
 Null as [+3],
 Null as [+4],
 Null as [+5],
 Null as [+6],
 Null as [+7],
 Null as [+8],
 Null as [+9],
 Null as [+10],
 Null as [+11],
 Null as [+12],
 Null as [+99],
 Null as [Obs.],
 Null as [Obra],
 Null as [Fecha prest.serv.],
 @vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0)
GROUP BY Proveedores.CodigoEmpresa, Proveedores.RazonSocial

UNION ALL 

SELECT 
 0 as [IdAux],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 Null as [K_FechaVencimiento],
 4 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 '    TOTAL GENERAL' as [Comprobante],
 Null as [Fecha vto.],
 Null as [Rubro financiero],
 SUM(IsNull(#Auxiliar1.A_ImporteCuota,0)) as [Importe],
 SUM(Case When #Auxiliar1.A_SaldoCuota>=0 or @ModeloListado='01' Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Saldo],
 SUM(Case When #Auxiliar1.A_SaldoCuota<0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Cred.N/apl.],
 Null as [Ds.Venc.],
 Null as [Ds.A Vencer],
 SUM(Case When #Auxiliar1.A_Meses<-12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-99],
 SUM(Case When #Auxiliar1.A_Meses=-12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-12],
 SUM(Case When #Auxiliar1.A_Meses=-11 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-11],
 SUM(Case When #Auxiliar1.A_Meses=-10 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-10],
 SUM(Case When #Auxiliar1.A_Meses=-9 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-9],
 SUM(Case When #Auxiliar1.A_Meses=-8 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-8],
 SUM(Case When #Auxiliar1.A_Meses=-7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-7],
 SUM(Case When #Auxiliar1.A_Meses=-6 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-6],
 SUM(Case When #Auxiliar1.A_Meses=-5 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-5],
 SUM(Case When #Auxiliar1.A_Meses=-4 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-4],
 SUM(Case When #Auxiliar1.A_Meses=-3 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-3],
 SUM(Case When #Auxiliar1.A_Meses=-2 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-2],
 SUM(Case When #Auxiliar1.A_Meses=-1 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [-1],
 SUM(Case When #Auxiliar1.A_Meses=0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0],
 SUM(Case When #Auxiliar1.A_Meses=1 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+1],
 SUM(Case When #Auxiliar1.A_Meses=2 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+2],
 SUM(Case When #Auxiliar1.A_Meses=3 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+3],
 SUM(Case When #Auxiliar1.A_Meses=4 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+4],
 SUM(Case When #Auxiliar1.A_Meses=5 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+5],
 SUM(Case When #Auxiliar1.A_Meses=6 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+6],
 SUM(Case When #Auxiliar1.A_Meses=7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+7],
 SUM(Case When #Auxiliar1.A_Meses=8 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+8],
 SUM(Case When #Auxiliar1.A_Meses=9 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+9],
 SUM(Case When #Auxiliar1.A_Meses=10 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+10],
 SUM(Case When #Auxiliar1.A_Meses=11 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+11],
 SUM(Case When #Auxiliar1.A_Meses=12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+12],
 SUM(Case When #Auxiliar1.A_Meses>12 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [+99],
 Null as [Obs.],
 Null as [Obra],
 Null as [Fecha prest.serv.],
 ' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL |'+
	' BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL | BOL ' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0)

ORDER BY [K_Proveedor],[K_Codigo],[K_Orden],[K_FechaVencimiento],[Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar11