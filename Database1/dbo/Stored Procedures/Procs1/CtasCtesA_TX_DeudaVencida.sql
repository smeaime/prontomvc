CREATE Procedure [dbo].[CtasCtesA_TX_DeudaVencida]

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
@RegistrosResumidos varchar(2) = Null,
@IdObra int = Null,
@InformeOrigen varchar(20) = Null

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteOrdenPago int

SET @UsarFechaVencimiento=IsNull(@UsarFechaVencimiento,'NO')
SET @CalcularFechaVencimientoDesdeRecepcion=IsNull(@CalcularFechaVencimientoDesdeRecepcion,'NO')
SET @UsarFechaComprobante=IsNull(@UsarFechaComprobante,'NO')
SET @IdTipoComprobanteOrdenPago=IsNull((Select Top 1 IdTipoComprobanteOrdenPago From Parametros Where IdParametro=1),0)
SET @RegistrosResumidos=IsNull(@RegistrosResumidos,'NO')
SET @IdObra=IsNull(@IdObra,-1)
SET @InformeOrigen=IsNull(@InformeOrigen,'')

DECLARE @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, @IdProveedor1 int, @IdProveedor2 int, 
		@IdProveedorAnt int, @SaldoCuota1 numeric(18,2), @SaldoCuota2 numeric(18,2), @ImporteCuota1 numeric(18,2), @ImporteCuota2 numeric(18,2), 
		@A_Fecha datetime, @SaldoAAplicar numeric(18,2), @SaldoAplicado numeric(18,2), @Diferencia numeric(18,2), @IdAux int, @Modelo varchar(2), 
		@IdTipoComprobante int, @IdComprobante int, @ActivarConsultaFechaVencimiento varchar(2),@NumeroComprobanteCancelacion varchar(30), 
		@TipoFecha varchar(15), @DetallarCreditosNoAplicados varchar(2)

-- @Modelo='01' Standar, @Modelo='02' para Homaq, @Modelo='03' para Williams (toma todos los pagos)
SET @Modelo=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Modelo informe deuda vencida a fecha'),'01')

SET @TipoFecha=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Tipo de fecha a tomar en informe deuda vencida a fecha'),'RECEPCION')

SET @ActivarConsultaFechaVencimiento=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Preguntar por fecha de vencimiento en proveedores'),'NO')

SET @DetallarCreditosNoAplicados=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
			Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
			Where pic.Clave='Detallar creditos no aplicados en informe deuda vencida a fecha'),'NO')

EXEC _TempCondicionesCompra_Generar

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
			 A_RubroFinanciero VARCHAR(30),
			 A_Observaciones VARCHAR(50),
			 A_IdAux INTEGER,
			 A_NumeroComprobante VARCHAR(30),
			 A_IdTipoComprobante INTEGER,
			 A_IdComprobante INTEGER,
			 A_IdObra INTEGER,
			 A_FechaComprobante DATETIME,
			 A_IdOrdenPagoCancelacion INTEGER,
			 A_DebitoAutomatico VARCHAR(2),
			 A_FechaPrestacionServicio DATETIME,
			 A_NumeroComprobanteCancelacion VARCHAR(30),
			 A_Observaciones2 VARCHAR(1000)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdImputacion, A_Fecha) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (A_IdAux, A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  Case When @UsarFechaComprobante='SI' Then Case When @CalcularFechaVencimientoDesdeRecepcion='NO' Then IsNull(cp.FechaComprobante,CtaCte.Fecha) Else IsNull(cp.FechaRecepcion,CtaCte.Fecha) End
	When @InformeOrigen='EGRESOSPROYECTADOS' and @ActivarConsultaFechaVencimiento='SI' and IsNull(Proveedores.FechaVencimientoParaEgresosProyectados,'NO')='NO' Then IsNull(CtaCte.FechaVencimiento,cp.FechaVencimiento)
	Else 
	  Case When IsNull(Tmp.Dias,0)=0 and IsNull(Tmp.Porcentaje,100)=100
		Then IsNull(IsNull(CtaCte.FechaVencimiento,cp.FechaComprobante),CtaCte.Fecha)
		Else Case When @CalcularFechaVencimientoDesdeRecepcion='NO' 
				Then DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaComprobante,CtaCte.FechaVencimiento))
				Else DateAdd(day,IsNull(Tmp.Dias,0),IsNull(cp.FechaRecepcion,CtaCte.FechaVencimiento))
			End
	  End
  End,
  Case	When cp.FechaRecepcion is not null and @TipoFecha='RECEPCION'
	Then 'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaRecepcion,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
		When cp.FechaRecepcion is not null and @TipoFecha='COMPROBANTE'
	Then 'Ref. : '+Convert(varchar,cp.NumeroReferencia)+' '+Convert(varchar,cp.FechaComprobante,103)+' '+TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
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
  (Select Top 1 SubString(RubrosContables.Descripcion,1,30)
   From  DetalleComprobantesProveedores DetCom
   Left Outer Join RubrosContables On RubrosContables.IdRubroContable=DetCom.IdRubroContable
   Where DetCom.IdComprobanteProveedor=cp.IdComprobanteProveedor and RubrosContables.Descripcion is not null),
  Case When cp.DestinoPago='A' Then 'ADM' When cp.DestinoPago='O' Then 'OBRA' Else Null End,
  IsNull(Tmp.IdAux,0),
  Case When cp.FechaRecepcion is not null
	Then TiposComprobante.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)
	Else TiposComprobante.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante)
  End,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante,
  cp.IdObra,
  CtaCte.Fecha,
  Null,
  IsNull(cp.DebitoAutomatico,''),
  cp.FechaPrestacionServicio,
  Null,
  Convert(varchar(1000),cp.Observaciones)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 LEFT OUTER JOIN ComprobantesProveedores cp ON CtaCte.IdComprobante=cp.IdComprobanteProveedor and CtaCte.IdTipoComp=cp.IdTipoComprobante
 LEFT OUTER JOIN Proveedores ON CtaCte.IdProveedor=Proveedores.IdProveedor
 LEFT OUTER JOIN _TempCondicionesCompra Tmp ON cp.IdCondicionCompra=Tmp.IdCondicionCompra and @UsarFechaVencimiento='NO' and @UsarFechaComprobante='NO' and 
				(@InformeOrigen<>'EGRESOSPROYECTADOS' or @ActivarConsultaFechaVencimiento<>'SI' or (@ActivarConsultaFechaVencimiento='SI' and IsNull(Proveedores.FechaVencimientoParaEgresosProyectados,'NO')='SI'))
 WHERE TiposComprobante.Coeficiente=1 and CtaCte.Fecha<=@Fecha and (@ActivaRango=-1 or (Proveedores.CodigoEmpresa>=@CodigoDesde and Proveedores.CodigoEmpresa<=@CodigoHasta))

UPDATE #Auxiliar1
SET A_Dias=DATEDIFF(day,A_Fecha,@Fecha)

CREATE TABLE #Auxiliar111 
			(
			 A_IdCtaCte INTEGER,
			 A_TotalImporteCuota NUMERIC(18, 2),
			 A_TotalComprobante NUMERIC(18, 2),
			 A_Diferencia NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar111 (A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar111 
 SELECT A_IdCtaCte, Sum(A_ImporteCuota), 0, 0
 FROM #Auxiliar1
 GROUP BY A_IdCtaCte

UPDATE #Auxiliar111
SET A_TotalComprobante=(Select Top 1 CtaCte.ImporteTotal From CuentasCorrientesAcreedores CtaCte Where CtaCte.IdCtaCte=#Auxiliar111.A_IdCtaCte)
UPDATE #Auxiliar111
SET A_Diferencia=A_TotalComprobante-A_TotalImporteCuota

DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_ImporteCuota, A_IdAux FROM #Auxiliar1 ORDER BY A_IdCtaCte 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @ImporteCuota1, @IdAux
WHILE @@FETCH_STATUS = 0
    BEGIN
	SET @Diferencia=IsNull((Select Top 1 A_Diferencia From #Auxiliar111 Where A_IdCtaCte=@IdCtaCte1),0)
	IF @Diferencia<>0
	    BEGIN
		UPDATE #Auxiliar1
		SET A_ImporteCuota=A_ImporteCuota+@Diferencia, A_SaldoCuota=A_SaldoCuota+@Diferencia
		WHERE #Auxiliar1.A_IdAux=@IdAux and #Auxiliar1.A_IdCtaCte=@IdCtaCte1

		UPDATE #Auxiliar111
		SET A_Diferencia = 0
		WHERE A_IdCtaCte=@IdCtaCte1
	    END
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @ImporteCuota1, @IdAux
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
			 A_ImporteCuota NUMERIC(15, 2),
			 A_SaldoCuota NUMERIC(15, 2),
			 A_Dias INTEGER,
			 A_RubroFinanciero VARCHAR(30),
			 A_NumeroComprobante VARCHAR(30),
			 A_IdTipoComprobante INTEGER,
			 A_IdComprobante INTEGER,
			 A_IdObra INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdImputacion, A_Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  Convert(varchar,CtaCte.Fecha,103)+' '+tc.Descripcion+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),
  IsNull(CtaCte.IdImputacion,0),
  Null,
  -1,
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal,
  0,
  '',
  tc.DescripcionAb+' '+Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+Convert(varchar,CtaCte.NumeroComprobante),
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante,
  cp.IdObra
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=CtaCte.IdTipoComp LEFT OUTER JOIN Proveedores ON CtaCte.IdProveedor=Proveedores.IdProveedor
 LEFT OUTER JOIN DetalleOrdenesPago dop ON dop.IdDetalleOrdenPago=CtaCte.IdDetalleOrdenPago
 LEFT OUTER JOIN CuentasCorrientesAcreedores CtaCte1 ON CtaCte1.IdCtaCte=dop.IdImputacion
 LEFT OUTER JOIN TiposComprobante tc1 ON tc1.IdTipoComprobante=CtaCte1.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte1.IdComprobante
 WHERE tc.Coeficiente=-1 and (CtaCte.Fecha<=@Fecha or @Modelo='03') and 
	(@ActivaRango=-1 or (Proveedores.CodigoEmpresa>=@CodigoDesde and Proveedores.CodigoEmpresa<=@CodigoHasta))

UPDATE #Auxiliar1
SET A_Fecha=CONVERT(datetime,@Fecha,103)
WHERE #Auxiliar1.A_Fecha Is Null

UPDATE #Auxiliar2
SET A_Fecha=CONVERT(datetime,@Fecha,103)
WHERE #Auxiliar2.A_Fecha Is Null

/*  CURSORES  */
DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_ImporteCuota, A_SaldoCuota, A_IdTipoComprobante, A_IdComprobante, A_NumeroComprobante
		FROM #Auxiliar2
		WHERE A_SaldoCuota<>0 --and A_IdImputacion<>0
		ORDER BY A_IdImputacion, A_Fecha 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1, @IdTipoComprobante, @IdComprobante, @NumeroComprobanteCancelacion
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

		IF @IdTipoComprobante=@IdTipoComprobanteOrdenPago
			UPDATE #Auxiliar1
			SET A_IdOrdenPagoCancelacion = @IdComprobante, A_NumeroComprobanteCancelacion=@NumeroComprobanteCancelacion
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
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteCuota1, @SaldoCuota1, @IdTipoComprobante, @IdComprobante, @NumeroComprobanteCancelacion
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

IF @IncluirCreditosNoAplicados=-1
	IF @DetallarCreditosNoAplicados<>'SI'
		INSERT INTO #Auxiliar1 
		 SELECT 
		  0,
		  A_IdProveedor,
		  Null,
		  'Creditos no aplicados',
		  Null,
		  Null,
		  -1,
		  Null,
		  Sum(IsNull(A_SaldoCuota,0))*-1,
		  1,
		  '',
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null,
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null
		 FROM #Auxiliar2
		 GROUP BY A_IdProveedor
	ELSE
		INSERT INTO #Auxiliar1 
		 SELECT 
		  0,
		  A_IdProveedor,
		  Null,
		  A_Detalle,
		  Null,
		  Null,
		  -1,
		  Null,
		  IsNull(A_SaldoCuota,0)*-1,
		  1,
		  '',
		  Null, 
		  Null, 
		  A_NumeroComprobante, 
		  A_IdTipoComprobante, 
		  A_IdComprobante, 
		  Null,
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null, 
		  Null
		 FROM #Auxiliar2

IF @FiltraSaldos0=-1
	DELETE FROM #Auxiliar1
	WHERE IsNull(A_SaldoCuota,0)=0

IF @IdObra>0
	DELETE FROM #Auxiliar1
	WHERE IsNull(A_IdObra,0)<>@IdObra

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='000000111116611666666666666111133'
SET @vector_T='000000000413333222222222222E24D00'

IF @RegistrosResumidos='SI'
  BEGIN
	SELECT 
	 0 as [IdAux],
	 Proveedores.CodigoEmpresa as [K_Codigo],
	 Proveedores.RazonSocial as [K_Proveedor],
	 #Auxiliar1.A_Fecha as [K_FechaVencimiento],
	 #Auxiliar1.A_NumeroComprobante as [K_NumeroComprobante],
	 1 as [K_Orden],
	 Proveedores.CodigoEmpresa as [Codigo],
	 Proveedores.RazonSocial as [Proveedor],
	 #Auxiliar1.A_Detalle as [Comprobante],
	 #Auxiliar1.A_Fecha as [Fecha vto.],
	 #Auxiliar1.A_RubroFinanciero as [Rubro financiero],
	 #Auxiliar1.A_ImporteCuota as [Importe],
	 #Auxiliar1.A_SaldoCuota as [Saldo],
	 Case When #Auxiliar1.A_Dias>=0 Then #Auxiliar1.A_Dias Else Null End as [Ds.Venc.],
	 Case When #Auxiliar1.A_Dias>=0 Then Null Else #Auxiliar1.A_Dias * -1 End as [Ds.A Vencer],
	 Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else Null End as [Vencido],
	 Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else Null End as [0 a 30 dias],
	 Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else Null End as [30 a 60 dias],
	 Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else Null End as [60 a 90 dias],
	 Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else Null End as [90 a 120 dias],
	 Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else Null End as [120 a 150 dias],
	 Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else Null End as [150 a 180 dias],
	 Case When #Auxiliar1.A_Dias*-1>180 and #Auxiliar1.A_Dias*-1<=270 Then #Auxiliar1.A_SaldoCuota Else Null End as [180 a 270 dias],
	 Case When #Auxiliar1.A_Dias*-1>270 and #Auxiliar1.A_Dias*-1<=365 Then #Auxiliar1.A_SaldoCuota Else Null End as [270 a 365 dias],
	 Case When #Auxiliar1.A_Dias*-1>365 and #Auxiliar1.A_Dias*-1<=730 Then #Auxiliar1.A_SaldoCuota Else Null End as [1 a 2 años],
	 Case When #Auxiliar1.A_Dias*-1>730 and #Auxiliar1.A_Dias*-1<=1095 Then #Auxiliar1.A_SaldoCuota Else Null End as [2 a 3 años],
	 Case When #Auxiliar1.A_Dias*-1>1095 Then #Auxiliar1.A_SaldoCuota Else Null End as [Mas de 3 años],
	 #Auxiliar1.A_Observaciones as [Obs.],
	 #Auxiliar1.A_IdTipoComprobante as [IdTipoComprobante],
	 #Auxiliar1.A_IdComprobante as [IdComprobante],
	 Obras.NumeroObra as [Obra],
	 #Auxiliar1.A_IdOrdenPagoCancelacion as [IdOrdenPagoCancelacion],
	 #Auxiliar1.A_FechaComprobante as [FechaComprobante],
	 IsNull(Proveedores.CancelacionInmediataDeDeuda,'') as [CancelacionInmediataDeDeuda],
	 #Auxiliar1.A_DebitoAutomatico as [DebitoAutomatico],
	 #Auxiliar1.A_NumeroComprobanteCancelacion as [NumeroComprobanteCancelacion]
	FROM #Auxiliar1
	LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
	LEFT OUTER JOIN Obras ON #Auxiliar1.A_IdObra=Obras.IdObra
	WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0) 
	ORDER BY [K_Proveedor], [K_Codigo], [K_Orden], [NumeroComprobanteCancelacion], [K_FechaVencimiento], [K_NumeroComprobante]
  END
ELSE
  BEGIN
	IF @Modelo='01' or @Modelo='03'
	  BEGIN
		SELECT 
		 0 as [IdAux],
		 Proveedores.CodigoEmpresa as [K_Codigo],
		 Proveedores.RazonSocial as [K_Proveedor],
		 #Auxiliar1.A_Fecha as [K_FechaVencimiento],
		 #Auxiliar1.A_NumeroComprobante as [K_NumeroComprobante],
		 1 as [K_Orden],
		 Proveedores.CodigoEmpresa as [Codigo],
		 Proveedores.RazonSocial as [Proveedor],
		 #Auxiliar1.A_Detalle as [Comprobante],
		 #Auxiliar1.A_Fecha as [Fecha vto.],
		 #Auxiliar1.A_RubroFinanciero as [Rubro financiero],
		 #Auxiliar1.A_ImporteCuota as [Importe],
		 #Auxiliar1.A_SaldoCuota as [Saldo],
		 Case When #Auxiliar1.A_Dias>=0 Then #Auxiliar1.A_Dias Else Null End as [Ds.Venc.],
		 Case When #Auxiliar1.A_Dias>=0 Then Null Else #Auxiliar1.A_Dias * -1 End as [Ds.A Vencer],
		 Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else Null End as [Vencido],
		 Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else Null End as [0 a 30 dias],
		 Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else Null End as [30 a 60 dias],
		 Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else Null End as [60 a 90 dias],
		 Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else Null End as [90 a 120 dias],
		 Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else Null End as [120 a 150 dias],
		 Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else Null End as [150 a 180 dias],
		 Case When #Auxiliar1.A_Dias*-1>180 and #Auxiliar1.A_Dias*-1<=270 Then #Auxiliar1.A_SaldoCuota Else Null End as [180 a 270 dias],
		 Case When #Auxiliar1.A_Dias*-1>270 and #Auxiliar1.A_Dias*-1<=365 Then #Auxiliar1.A_SaldoCuota Else Null End as [270 a 365 dias],
		 Case When #Auxiliar1.A_Dias*-1>365 and #Auxiliar1.A_Dias*-1<=730 Then #Auxiliar1.A_SaldoCuota Else Null End as [1 a 2 años],
		 Case When #Auxiliar1.A_Dias*-1>730 and #Auxiliar1.A_Dias*-1<=1095 Then #Auxiliar1.A_SaldoCuota Else Null End as [2 a 3 años],
		 Case When #Auxiliar1.A_Dias*-1>1095 Then #Auxiliar1.A_SaldoCuota Else Null End as [Mas de 3 años],
		 #Auxiliar1.A_Observaciones as [Obs.],
		 Obras.NumeroObra as [Obra],
		 #Auxiliar1.A_FechaPrestacionServicio as [Fecha prest.serv.],
		 #Auxiliar1.A_Observaciones2 as [Obs.Comprobante],
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
		 Null as [K_NumeroComprobante],
		 2 as [K_Orden],
		 Proveedores.CodigoEmpresa as [Codigo],
		 Proveedores.RazonSocial as [Proveedor],
		 '    TOTAL PROVEEDOR' as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 SUM(IsNull(#Auxiliar1.A_ImporteCuota,0)) as [Importe],
		 SUM(IsNull(#Auxiliar1.A_SaldoCuota,0)) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0 a 30 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [30 a 60 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>180 and #Auxiliar1.A_Dias*-1<=270 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [180 a 270 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>270 and #Auxiliar1.A_Dias*-1<=365 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [270 a 365 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>365 and #Auxiliar1.A_Dias*-1<=730 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.A_Dias*-1>730 and #Auxiliar1.A_Dias*-1<=1095 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.A_Dias*-1>1095 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Mas de 3 años],
		 Null as [Obs.],
		 Null as [Obra],
		 Null as [Fecha prest.serv.],
		 Null as [Obs.Comprobante],
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
		 Null as [K_NumeroComprobante],
		 3 as [K_Orden],
		 Null as [Codigo],
		 Null as [Proveedor],
		 Null as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 Null as [Importe],
		 Null as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 Null as [Vencido],
		 Null as [0 a 30 dias],
		 Null as [30 a 60 dias],
		 Null as [60 a 90 dias],
		 Null as [90 a 120 dias],
		 Null as [120 a 150 dias],
		 Null as [150 a 180 dias],
		 Null as [180 a 270 dias],
		 Null as [270 a 365 dias],
		 Null as [1 a 2 años],
		 Null as [2 a 3 años],
		 Null as [Mas de 3 años],
		 Null as [Obs.],
		 Null as [Obra],
		 Null as [Fecha prest.serv.],
		 Null as [Obs.Comprobante],
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
		 Null as [K_NumeroComprobante],
		 4 as [K_Orden],
		 Null as [Codigo],
		 Null as [Proveedor],
		 '    TOTAL GENERAL' as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 SUM(IsNull(#Auxiliar1.A_ImporteCuota,0)) as [Importe],
		 SUM(IsNull(#Auxiliar1.A_SaldoCuota,0)) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0 a 30 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [30 a 60 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>180 and #Auxiliar1.A_Dias*-1<=270 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [180 a 270 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>270 and #Auxiliar1.A_Dias*-1<=365 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [270 a 365 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>365 and #Auxiliar1.A_Dias*-1<=730 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [1 a 2 años],
		 SUM(Case When #Auxiliar1.A_Dias*-1>730 and #Auxiliar1.A_Dias*-1<=1095 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [2 a 3 años],
		 SUM(Case When #Auxiliar1.A_Dias*-1>1095 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Mas de 3 años],
		 Null as [Obs.],
		 Null as [Obra],
		 Null as [Fecha prest.serv.],
		 Null as [Obs.Comprobante],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0) 
		
		ORDER BY [K_Proveedor], [K_Codigo], [K_Orden], [K_FechaVencimiento], [K_NumeroComprobante]
	  END

	--Para Homaq
	IF @Modelo='02'
	  BEGIN
		SET @vector_X='00000011111661166666666666133'
		SET @vector_T='00000000041333322222222222E00'

		SELECT 
		 0 as [IdAux],
		 Proveedores.CodigoEmpresa as [K_Codigo],
		 Proveedores.RazonSocial as [K_Proveedor],
		 #Auxiliar1.A_Fecha as [K_FechaVencimiento],
		 #Auxiliar1.A_NumeroComprobante as [K_NumeroComprobante],
		 1 as [K_Orden],
		 Proveedores.CodigoEmpresa as [Codigo],
		 Proveedores.RazonSocial as [Proveedor],
		 #Auxiliar1.A_Detalle as [Comprobante],
		 #Auxiliar1.A_Fecha as [Fecha vto.],
		 #Auxiliar1.A_RubroFinanciero as [Rubro financiero],
		 #Auxiliar1.A_ImporteCuota as [Importe],
		 #Auxiliar1.A_SaldoCuota as [Saldo],
		 Case When #Auxiliar1.A_Dias>=0 Then #Auxiliar1.A_Dias Else Null End as [Ds.Venc.],
		 Case When #Auxiliar1.A_Dias>=0 Then Null Else #Auxiliar1.A_Dias * -1 End as [Ds.A Vencer],
		 Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else Null End as [Vencido],
		 Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=7 Then #Auxiliar1.A_SaldoCuota Else Null End as [0 a 7 dias],
		 Case When #Auxiliar1.A_Dias*-1>7 and #Auxiliar1.A_Dias*-1<=15 Then #Auxiliar1.A_SaldoCuota Else Null End as [7 a 15 dias],
		 Case When #Auxiliar1.A_Dias*-1>15 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else Null End as [15 a 30 dias],
		 Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=45 Then #Auxiliar1.A_SaldoCuota Else Null End as [30 a 45 dias],
		 Case When #Auxiliar1.A_Dias*-1>45 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else Null End as [45 a 60 dias],
		 Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else Null End as [60 a 90 dias],
		 Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else Null End as [90 a 120 dias],
		 Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else Null End as [120 a 150 dias],
		 Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else Null End as [150 a 180 dias],
		 Case When #Auxiliar1.A_Dias*-1>180  Then #Auxiliar1.A_SaldoCuota Else Null End as [Mas de 180 dias],
		 #Auxiliar1.A_Observaciones as [Obs.],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		LEFT OUTER JOIN Proveedores ON #Auxiliar1.A_IdProveedor=Proveedores.IdProveedor
		WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0) 
		
		UNION ALL 
		
		SELECT 
		 0 as [IdAux],
		 Proveedores.CodigoEmpresa as [K_Codigo],
		 Proveedores.RazonSocial as [K_Proveedor],
		 Null as [K_FechaVencimiento],
		 Null as [K_NumeroComprobante],
		 2 as [K_Orden],
		 Null as [Codigo],
		 Null as [Proveedor],
		 '    TOTAL PROVEEDOR' as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 SUM(#Auxiliar1.A_ImporteCuota) as [Importe],
		 SUM(#Auxiliar1.A_SaldoCuota) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0 a 7 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>7 and #Auxiliar1.A_Dias*-1<=15 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [7 a 15 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>15 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [15 a 30 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=45 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [30 a 45 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>45 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [45 a 60 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Mas de 180 dias],
		 Null as [Obs.],
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
		 Null as [K_NumeroComprobante],
		 3 as [K_Orden],
		 Null as [Codigo],
		 Null as [Proveedor],
		 Null as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 Null as [Importe],
		 Null as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 Null as [Vencido],
		 Null as [0 a 7 dias],
		 Null as [7 a 15 dias],
		 Null as [15 a 30 dias],
		 Null as [30 a 45 dias],
		 Null as [45 a 60 dias],
		 Null as [60 a 90 dias],
		 Null as [90 a 120 dias],
		 Null as [120 a 150 dias],
		 Null as [150 a 180 dias],
		 Null as [Mas de 180 dias],
		 Null as [Obs.],
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
		 Null as [K_NumeroComprobante],
		 4 as [K_Orden],
		 Null as [Codigo],
		 Null as [Proveedor],
		 '    TOTAL GENERAL' as [Comprobante],
		 Null as [Fecha vto.],
		 Null as [Rubro financiero],
		 SUM(#Auxiliar1.A_ImporteCuota) as [Importe],
		 SUM(#Auxiliar1.A_SaldoCuota) as [Saldo],
		 Null as [Ds.Venc.],
		 Null as [Ds.A Vencer],
		 SUM(Case When #Auxiliar1.A_Dias>0 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Vencido],
		 SUM(Case When #Auxiliar1.A_Dias*-1>=0 and #Auxiliar1.A_Dias*-1<=7 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [0 a 7 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>7 and #Auxiliar1.A_Dias*-1<=15 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [7 a 15 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>15 and #Auxiliar1.A_Dias*-1<=30 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [15 a 30 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>30 and #Auxiliar1.A_Dias*-1<=45 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [30 a 45 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>45 and #Auxiliar1.A_Dias*-1<=60 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [45 a 60 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>60 and #Auxiliar1.A_Dias*-1<=90 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [60 a 90 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>90 and #Auxiliar1.A_Dias*-1<=120 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [90 a 120 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>120 and #Auxiliar1.A_Dias*-1<=150 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [120 a 150 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>150 and #Auxiliar1.A_Dias*-1<=180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [150 a 180 dias],
		 SUM(Case When #Auxiliar1.A_Dias*-1>180 Then #Auxiliar1.A_SaldoCuota Else 0 End) as [Mas de 180 dias],
		 Null as [Obs.],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar1
		WHERE (@IncluirNoVencido='SI' or A_Dias>0) and (A_ImporteCuota<>0 or A_SaldoCuota<0) 
		
		ORDER BY [K_Proveedor], [K_Codigo], [K_Orden], [K_FechaVencimiento], [K_NumeroComprobante]
	  END
  END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar111