CREATE PROCEDURE [dbo].[InformeResumenGastosPorRubroContable_TX_2]

@Desde datetime,
@Hasta datetime,
@Salida varchar(10),
@IdCentroCosto int = Null

AS

SET NOCOUNT ON

SET @IdCentroCosto=IsNull(@IdCentroCosto,-1)

DECLARE @Desde1 datetime, @Hasta1 datetime, @Desde2 datetime, @Hasta2 datetime, @Desde3 datetime, @Hasta3 datetime, @TotalVentas numeric(18,2), 
		@TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, @IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), 
		@Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int, @Año int, @Mes int

SET @Desde1=0
SET @Hasta1=0
SET @Desde3=0
SET @Hasta3=0

IF @Salida='VENTAS' or @Salida='GASTOS' or @Salida='GASTOSRES'
  BEGIN
	SET @Desde1=DateAdd(m,1,@Desde)
--	SET @Hasta1=DateAdd(d,-1,DateAdd(m,1,@Desde1))
	SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))
  END

IF @Salida='VENTAS2' or @Salida='GASTOS2'
  BEGIN
	SET @Desde1=DateAdd(m,1,@Desde)
	SET @Hasta1=DateAdd(d,-1,DateAdd(m,13,@Desde1))
	SET @Hasta=DateAdd(d,-1,DateAdd(m,13,@Desde))
  END

IF @Salida='VENTAS3'
  BEGIN
	SET @Desde1=DateAdd(m,1,@Desde)
	SET @Hasta1=DateAdd(m,1,@Hasta)
  END

IF @Salida='GASTOS3'
  BEGIN
	SET @Desde3=DateAdd(year,-1,@Desde)
	SET @Hasta3=DateAdd(year,-1,@Hasta)
  END

IF @Salida='GASTOS4'
  BEGIN
	SET @Desde1=DateAdd(m,1,@Desde)
	SET @Hasta1=DateAdd(d,-1,DateAdd(year,1,@Desde1))
  END
--select @Desde,@Hasta,@Desde1,@Hasta1,@Desde3,@Hasta3

SET @IdObraAdministracion=IsNull((Select Top 1 IdObraStockDisponible From Parametros Where IdParametro=1),0)

CREATE TABLE #Auxiliar2 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Fecha DATETIME,
			 FechaParaInforme DATETIME,
			 IdObra INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar3 
			(
			 IdObra INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 Porcentaje NUMERIC(6, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdObra,Año,Mes) ON [PRIMARY]

CREATE TABLE #Auxiliar4 
			(
			 Año INTEGER,
			 Mes INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (Año,Mes) ON [PRIMARY]

CREATE TABLE #Auxiliar6 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 Fecha DATETIME,
			 Importe NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar7 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 DistribuirGastosEnResumen VARCHAR(2),
			 Importe NUMERIC(18, 2),
			 Año INTEGER,
			 Mes INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 (IdObra, IdRubroContable) ON [PRIMARY]

CREATE TABLE #Auxiliar8 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2),
			 Año INTEGER,
			 Mes INTEGER
			)

CREATE TABLE #Auxiliar9 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2),
			 Año INTEGER,
			 Mes INTEGER
			)

CREATE TABLE #Auxiliar10 
			(
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2),
			 Año INTEGER,
			 Mes INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (IdRubroContable, Año, Mes) ON [PRIMARY]

CREATE TABLE #Auxiliar11 
			(
			 Concepto VARCHAR(100),
			 Importe NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar20 
			(
			 IdFactura INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar20 (IdFactura) ON [PRIMARY]

/*  ============= VENTAS =============  */

/* Identifico las facturas apuntadas en notas de credito */
INSERT INTO #Auxiliar20  
 SELECT DISTINCT ccd.IdComprobante
 FROM DetalleNotasCreditoImputaciones dnci
 LEFT OUTER JOIN NotasCredito On NotasCredito.IdNotaCredito=dnci.IdNotaCredito  
 LEFT OUTER JOIN CuentasCorrientesDeudores ccd On ccd.IdCtaCte=dnci.IdImputacion  
 WHERE IsNull(NotasCredito.Anulada,'')<>'SI' and dnci.IdImputacion>0 and IsNull(ccd.IdTipoComp,0)=1

INSERT INTO #Auxiliar2 
 SELECT 
	1,
	Fac.IdFactura,
	Fac.FechaFactura,
	DateAdd(m,-1,Fac.FechaFactura),
	Fac.IdObra,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or (Fac.PorcentajeIva1=0)
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End,
	(Select Sum(IsNull(df.Cantidad,0)) From DetalleFacturas df Where df.IdFactura=Fac.IdFactura)
 FROM Facturas Fac
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) and 
		(@IdCentroCosto=-1 or Fac.IdObra=@IdCentroCosto) and Not Exists(Select Top 1 aux.IdFactura From #Auxiliar20 aux Where aux.IdFactura=Fac.IdFactura)

INSERT INTO #Auxiliar2 
 SELECT 
	5,
	Dev.IdDevolucion,
	Dev.FechaDevolucion,
	DateAdd(m,-1,Dev.FechaDevolucion),
	Dev.IdObra,
	Case When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 and Dev.PorcentajeIva1<>0
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - 
			IsNull(Dev.PercepcionIVA,0)) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9 or (Dev.PorcentajeIva1=0)
		 Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - 
			IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
	End * -1,
	(Select Sum(IsNull(dd.Cantidad,0)) From DetalleDevoluciones dd Where dd.IdDevolucion=Dev.IdDevolucion) * -1
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and IsNull(Dev.IdObra,0)>0 and Dev.FechaDevolucion between @Desde1 and DATEADD(n,1439,@Hasta1) and (@IdCentroCosto=-1 or Dev.IdObra=@IdCentroCosto)

INSERT INTO #Auxiliar2 
 SELECT 
	3,
	Deb.IdNotaDebito,
	Deb.FechaNotaDebito,
	DateAdd(m,-1,Deb.FechaNotaDebito),
	Deb.IdObra,
	IsNull((Select Sum(IsNull(dnd.Importe,0) - IsNull(dnd.IvaNoDiscriminado,0)) From DetalleNotasDebito dnd Where dnd.IdNotaDebito=Deb.IdNotaDebito),0),
	0
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and IsNull(Deb.IdObra,0)>0 and Deb.FechaNotaDebito between @Desde1 and DATEADD(n,1439,@Hasta1) and (@IdCentroCosto=-1 or Deb.IdObra=@IdCentroCosto)

/*
INSERT INTO #Auxiliar2 
 SELECT 
	4,
	Cre.IdNotaCredito,
	Cre.FechaNotaCredito,
	DateAdd(m,-1,Cre.FechaNotaCredito),
	Cre.IdObra,
	IsNull((Select Sum(IsNull(dnc.Importe,0) - IsNull(dnc.IvaNoDiscriminado,0)) From DetalleNotasCredito dnc Where dnc.IdNotaCredito=Cre.IdNotaCredito),0) * -1,
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and IsNull(Cre.IdObra,0)>0 and Cre.FechaNotaCredito between @Desde1 and DATEADD(n,1439,@Hasta1) and (@IdCentroCosto=-1 or Cre.IdObra=@IdCentroCosto)
*/

IF @Salida='VENTAS'
	INSERT INTO #Auxiliar3 
	 SELECT IdObra, 0, 0, Sum(IsNull(NetoGravado,0)), Sum(IsNull(Cantidad,0)), 0
	 FROM #Auxiliar2
	 GROUP BY IdObra
ELSE
	INSERT INTO #Auxiliar3 
	 SELECT IdObra, Year(FechaParaInforme), Month(FechaParaInforme), Sum(IsNull(NetoGravado,0)), Sum(IsNull(Cantidad,0)), 0
	 FROM #Auxiliar2
	 GROUP BY IdObra, Year(FechaParaInforme), Month(FechaParaInforme)

INSERT INTO #Auxiliar4 
 SELECT Año, Mes
 FROM #Auxiliar3
 GROUP BY Año, Mes

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Año, Mes FROM #Auxiliar4 ORDER BY Año, Mes
OPEN Cur
FETCH NEXT FROM Cur INTO @Año, @Mes
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @TotalVentas=IsNull((Select Sum(IsNull(NetoGravado,0)) From #Auxiliar3 Where Año=@Año and Mes=@Mes),0)
	IF @TotalVentas<>0
		UPDATE #Auxiliar3
		SET Porcentaje=Round(NetoGravado/@TotalVentas*100,2)
		WHERE Año=@Año and Mes=@Mes
	SET @TotalPorcentaje=IsNull((Select Sum(IsNull(Porcentaje,0)) From #Auxiliar3 Where Año=@Año and Mes=@Mes),0)
	SET @IdObra=IsNull((Select Top 1 IdObra From #Auxiliar3 Where IdObra<>@IdObraAdministracion and Año=@Año and Mes=@Mes),0)
	IF @IdObra>0
		UPDATE #Auxiliar3
		SET Porcentaje=Porcentaje+(100-@TotalPorcentaje)
		WHERE IdObra=@IdObra and Año=@Año and Mes=@Mes

	FETCH NEXT FROM Cur INTO @Año, @Mes
  END
CLOSE Cur
DEALLOCATE Cur


/*  ============= GASTOS =============  */

INSERT INTO #Auxiliar6 
 SELECT 
	IsNull(DetCP.IdObra,cp.IdObra),
	RubrosContables.IdRubroContable,
	cp.FechaRecepcion,
	DetCP.Importe * cp.CotizacionMoneda * tc.Coeficiente
 FROM DetalleComprobantesProveedores DetCP
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 WHERE ((IsNull(RubrosContables.TomarMesDeVentaEnResumen,'')<>'SI' and cp.FechaRecepcion Between @Desde And @Hasta) or 
		(IsNull(RubrosContables.TomarMesDeVentaEnResumen,'')='SI' and cp.FechaRecepcion Between @Desde1 And @Hasta1) or (cp.FechaRecepcion Between @Desde3 And @Hasta3)) and 
		IsNull(cp.Confirmado,'')<>'NO' and IsNull(DetCP.IdObra,IsNull(cp.IdObra,0))>0 and RubrosContables.IdRubroContable is not null and IsNull(cp.TomarEnCuboDeGastos,'')<>'NO' and 
		(IsNull(RubrosContables.CodigoAgrupacion,1)=1 or IsNull(RubrosContables.CodigoAgrupacion,1)=3) and (@IdCentroCosto=-1 or IsNull(DetCP.IdObra,cp.IdObra)=@IdCentroCosto) 

INSERT INTO #Auxiliar6 
 SELECT 
	rcd.IdObra,
	rcd.IdRubroContable,
	Convert(datetime,'01/'+Convert(varchar,rcd.Mes)+'/'+Convert(varchar,rcd.Año),103),
	rcd.Importe
 FROM _TempRubrosContablesDatos rcd 
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=rcd.IdRubroContable
 WHERE ((IsNull(RubrosContables.TomarMesDeVentaEnResumen,'')<>'SI' and Convert(datetime,'01/'+Convert(varchar,rcd.Mes)+'/'+Convert(varchar,rcd.Año),103) Between @Desde And @Hasta) or 
		(IsNull(RubrosContables.TomarMesDeVentaEnResumen,'')='SI' and Convert(datetime,'01/'+Convert(varchar,rcd.Mes)+'/'+Convert(varchar,rcd.Año),103) Between @Desde1 And @Hasta1) or 
		(Convert(datetime,'01/'+Convert(varchar,rcd.Mes)+'/'+Convert(varchar,rcd.Año),103) Between @Desde3 And @Hasta3)) and 
 		(IsNull(RubrosContables.CodigoAgrupacion,1)=2 or IsNull(RubrosContables.CodigoAgrupacion,1)=3) and (@IdCentroCosto=-1 or rcd.IdObra=@IdCentroCosto)

IF @Salida='GASTOS' or @Salida='GASTOS4'
	UPDATE #Auxiliar6
	SET Fecha=@Desde

INSERT INTO #Auxiliar7 
 SELECT a6.IdObra, a6.IdRubroContable, IsNull(RubrosContables.DistribuirGastosEnResumen,'NO'), Sum(IsNull(a6.Importe,0)), Year(a6.Fecha), Month(a6.Fecha)
 FROM #Auxiliar6 a6 
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=a6.IdRubroContable
 LEFT OUTER JOIN Obras ON Obras.IdObra=a6.IdObra
 WHERE Obras.IdObra is not null
 GROUP BY a6.IdObra, a6.IdRubroContable, RubrosContables.DistribuirGastosEnResumen, Year(a6.Fecha), Month(a6.Fecha)

--select * from #Auxiliar3 order by Año,Mes,IdObra
--select * from #Auxiliar7 order by Año,Mes,IdRubroContable,IdObra

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdObra, IdRubroContable, Importe, Año, Mes FROM #Auxiliar7 WHERE IdObra=@IdObraAdministracion and DistribuirGastosEnResumen='SI' ORDER BY IdObra, IdRubroContable
OPEN Cur
FETCH NEXT FROM Cur INTO @IdObra, @IdRubroContable, @Importe, @Año, @Mes
WHILE @@FETCH_STATUS = 0
  BEGIN
	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdObra, Porcentaje FROM #Auxiliar3 WHERE Año=@Año and Mes=@Mes ORDER BY IdObra
	OPEN Cur2
	FETCH NEXT FROM Cur2 INTO @IdObra2, @Porcentaje
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @Importe2=Round(@Importe*@Porcentaje/100,2)
		INSERT INTO #Auxiliar8
		(IdObra, IdRubroContable, Importe, Año, Mes)
		VALUES
		(@IdObra2, @IdRubroContable, @Importe2, @Año, @Mes)
		FETCH NEXT FROM Cur2 INTO @IdObra2, @Porcentaje
	  END
	CLOSE Cur2
	DEALLOCATE Cur2

	FETCH NEXT FROM Cur INTO @IdObra, @IdRubroContable, @Importe, @Año, @Mes
  END
CLOSE Cur
DEALLOCATE Cur

INSERT INTO #Auxiliar8 
 SELECT IdObra, IdRubroContable, Importe, Año, Mes
 FROM #Auxiliar7
 WHERE IdObra<>@IdObraAdministracion or (IdObra=@IdObraAdministracion and DistribuirGastosEnResumen<>'SI')

INSERT INTO #Auxiliar9 
 SELECT IdObra, IdRubroContable, Sum(IsNull(Importe,0)), Año, Mes
 FROM #Auxiliar8
 GROUP BY IdObra, IdRubroContable, Año, Mes

-- Verificar si hay rubros con distribucion predefinida --
INSERT INTO #Auxiliar10 
 SELECT a9.IdRubroContable,	Sum(IsNull(a9.Importe,0)), a9.Año, a9.Mes
 FROM #Auxiliar9 a9
 WHERE Exists(Select Top 1 drc.IdRubroContable From DetalleRubrosContables drc Where drc.IdRubroContable=a9.IdRubroContable)
 GROUP BY a9.IdRubroContable, a9.Año, a9.Mes

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdRubroContable, Importe, Año, Mes FROM #Auxiliar10 ORDER BY IdRubroContable, Año, Mes
OPEN Cur
FETCH NEXT FROM Cur INTO @IdRubroContable, @Importe, @Año, @Mes
WHILE @@FETCH_STATUS = 0
  BEGIN
	DELETE #Auxiliar9 WHERE IdRubroContable=@IdRubroContable and Año=@Año and Mes=@Mes

	INSERT INTO #Auxiliar9
	 SELECT IdObra, IdRubroContable, IsNull(@Importe*Porcentaje/100,0), @Año, @Mes
	 FROM DetalleRubrosContables
	 WHERE IdRubroContable=@IdRubroContable

	FETCH NEXT FROM Cur INTO @IdRubroContable, @Importe, @Año, @Mes
  END
CLOSE Cur
DEALLOCATE Cur

INSERT INTO #Auxiliar11
 SELECT IsNull(TiposRubrosFinancierosGrupos.Descripcion,RubrosContables.Descripcion), #Auxiliar9.Importe
 FROM #Auxiliar9
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar9.IdRubroContable
 LEFT OUTER JOIN TiposRubrosFinancierosGrupos ON TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo=RubrosContables.IdTipoRubroFinancieroGrupo

SET NOCOUNT OFF

IF @Salida='VENTAS' or @Salida='VENTAS3'
	SELECT IsNull(a3.IdObra,0) as [IdObra], IsNull(Obras.Descripcion,'') as [Obra], 
			IsNull(a3.NetoGravado,0) as [NetoGravado], IsNull(a3.Cantidad,0) as [Cantidad], IsNull(a3.Porcentaje,0) as [Porcentaje]
	FROM #Auxiliar3 a3 
	LEFT OUTER JOIN Obras ON Obras.IdObra=a3.IdObra
	ORDER BY a3.IdObra

IF @Salida='VENTAS2'
	SELECT IsNull(a2.IdObra,0) as [IdObra], IsNull(Obras.Descripcion,'') as [Obra], Year(a2.FechaParaInforme) as [Año], Month(a2.FechaParaInforme) as [Mes], 
			Sum(IsNull(NetoGravado,0)) as [NetoGravado], Sum(IsNull(Cantidad,0)) as [Cantidad]
	FROM #Auxiliar2 a2
	LEFT OUTER JOIN Obras ON Obras.IdObra=a2.IdObra
	GROUP BY a2.IdObra, Obras.Descripcion, Year(a2.FechaParaInforme), Month(a2.FechaParaInforme)
	ORDER BY Obras.Descripcion, Year(a2.FechaParaInforme), Month(a2.FechaParaInforme)

IF @Salida='GASTOS' or @Salida='GASTOS4'
	SELECT RubrosContables.IdRubroContable, IsNull(TiposRubrosFinancierosGrupos.Descripcion,RubrosContables.Descripcion) as [Grupo], RubrosContables.Descripcion as [RubroContable], 
			IsNull(a9.IdObra,0) as [IdObra], Obras.Descripcion as [Obra], IsNull(a9.Importe,0) as [Importe]
	FROM RubrosContables
	LEFT OUTER JOIN #Auxiliar9 a9 ON a9.IdRubroContable=RubrosContables.IdRubroContable
	LEFT OUTER JOIN Obras ON Obras.IdObra=a9.IdObra
	LEFT OUTER JOIN TiposRubrosFinancierosGrupos ON TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo=RubrosContables.IdTipoRubroFinancieroGrupo
	WHERE IsNull(a9.Importe,0)<>0
	ORDER BY TiposRubrosFinancierosGrupos.Codigo, [Grupo], RubrosContables.Codigo, a9.IdObra

IF @Salida='GASTOS2'
	SELECT RubrosContables.IdRubroContable, IsNull(TiposRubrosFinancierosGrupos.Descripcion,RubrosContables.Descripcion) as [Grupo], RubrosContables.Descripcion as [RubroContable], 
			IsNull(a9.IdObra,0) as [IdObra], Obras.Descripcion as [Obra], IsNull(a9.Importe,0) as [Importe], a9.Año, a9.Mes
	FROM RubrosContables
	LEFT OUTER JOIN #Auxiliar9 a9 ON a9.IdRubroContable=RubrosContables.IdRubroContable
	LEFT OUTER JOIN Obras ON Obras.IdObra=a9.IdObra
	LEFT OUTER JOIN TiposRubrosFinancierosGrupos ON TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo=RubrosContables.IdTipoRubroFinancieroGrupo
	WHERE IsNull(a9.Importe,0)<>0
	ORDER BY TiposRubrosFinancierosGrupos.Codigo, [Grupo], RubrosContables.Descripcion, a9.IdObra, a9.Año, a9.Mes

IF @Salida='GASTOS3'
	SELECT DISTINCT RubrosContables.IdRubroContable, IsNull(TiposRubrosFinancierosGrupos.Descripcion,RubrosContables.Descripcion) as [Grupo], RubrosContables.Descripcion as [RubroContable]
	FROM RubrosContables
	LEFT OUTER JOIN #Auxiliar9 a9 ON a9.IdRubroContable=RubrosContables.IdRubroContable
	LEFT OUTER JOIN Obras ON Obras.IdObra=a9.IdObra
	LEFT OUTER JOIN TiposRubrosFinancierosGrupos ON TiposRubrosFinancierosGrupos.IdTipoRubroFinancieroGrupo=RubrosContables.IdTipoRubroFinancieroGrupo
	WHERE IsNull(a9.Importe,0)<>0
	ORDER BY TiposRubrosFinancierosGrupos.Codigo, [Grupo], RubrosContables.Descripcion

IF @Salida='GASTOSRES'
	SELECT Concepto as [Concepto], Sum(IsNull(Importe,0)) as [Importe]
	FROM #Auxiliar11
	GROUP BY Concepto
	ORDER BY [Importe] Desc

DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar20