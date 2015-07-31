/****** Object:  StoredProcedure [dbo].[InformeResumenGastosPorRubroContable_TX_1]    Script Date: 07/24/2015 14:13:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

drop  PROCEDURE [dbo].[InformeResumenGastosPorRubroContable_TX_1_ConInfoDeImputacion]
go 

create PROCEDURE [dbo].[InformeResumenGastosPorRubroContable_TX_1_ConInfoDeImputacion]

@Desde datetime,
@Hasta datetime,
@Salida varchar(10),
@IdCentroCosto int = Null

AS

SET NOCOUNT ON

SET @IdCentroCosto=IsNull(@IdCentroCosto,-1)

DECLARE @Desde1 datetime, @Hasta1 datetime, @TotalVentas numeric(18,2), @TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, 
		@IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), @Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int,
		@IdTipoNegocioVentasBuque int, @IdTipoNegocioVentasElevacion int, @IdTipoNegocioVentasEntrega int

SET @Desde1=DateAdd(m,1,@Desde)
--SET @Hasta1=DateAdd(d,-1,DateAdd(m,1,@Desde1))
SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))
SET @IdObraAdministracion=IsNull((Select Top 1 IdObraStockDisponible From Parametros Where IdParametro=1),0)

SET @IdTipoNegocioVentasBuque=IsNull((Select Top 1 IdTipoNegocioVentas From TiposNegociosVentas Where Upper(Rtrim(Descripcion))='BUQUE'),0)
SET @IdTipoNegocioVentasElevacion=IsNull((Select Top 1 IdTipoNegocioVentas From TiposNegociosVentas Where Upper(Rtrim(Descripcion))='ELEVACION'),0)
SET @IdTipoNegocioVentasEntrega=IsNull((Select Top 1 IdTipoNegocioVentas From TiposNegociosVentas Where Upper(Rtrim(Descripcion))='ENTREGA'),0)

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleFactura INTEGER,
			 IdFactura INTEGER,
			 IdTipoNegocioVentas INTEGER,
			 Cantidad NUMERIC(18, 2),
			 Observaciones  VARCHAR(MAX)  collate SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar10 
			(
			 IdDetalleFactura INTEGER,
			 Tipo VARCHAR(50) collate SQL_Latin1_General_CP1_CI_AS,
			 Cantidad NUMERIC(18, 2),
			 Observaciones   VARCHAR(MAX)   collate SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar2 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 IdArticulo INTEGER,
			 CodigoTipo INTEGER,
			 Tipo VARCHAR(50),
			 Grupo VARCHAR(20),
			 IdObra INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 Grupo2 INTEGER,
			 Observaciones   VARCHAR(MAX)  collate SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar3 
			(
			 IdObra INTEGER,
			 CodigoTipo INTEGER,
			 Tipo VARCHAR(50),
			 Grupo VARCHAR(20),
			 IdArticulo INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 Porcentaje NUMERIC(6, 2),
			 Grupo2 INTEGER,
			 Observaciones  VARCHAR(MAX) collate SQL_Latin1_General_CP1_CI_AS 
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdObra, Tipo, IdArticulo) ON [PRIMARY]


CREATE TABLE #Auxiliar6 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar7 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 DistribuirGastosEnResumen VARCHAR(2),
			 Importe NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar7 ON #Auxiliar7 (IdObra, IdRubroContable) ON [PRIMARY]

CREATE TABLE #Auxiliar8 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar9 
			(
			 IdObra INTEGER,
			 IdRubroContable INTEGER,
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

INSERT INTO #Auxiliar1  
 SELECT Det.IdDetalleFactura, Det.IdFactura, 
		Case When Exists(Select Top 1 CDP.IdDetalleFactura From CartasDePorte CDP Where CDP.IdDetalleFactura=Det.IdDetalleFactura)
				Then Case When (Select Top 1 IsNull(CDP.Exporta,'') From CartasDePorte CDP Where CDP.IdDetalleFactura=Det.IdDetalleFactura)='SI'
							Then @IdTipoNegocioVentasElevacion
							Else @IdTipoNegocioVentasEntrega
					 End
				Else Case When Exists(Select Top 1 MOVS.IdDetalleFactura From CartasPorteMovimientos MOVS Where MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4) 
							Then @IdTipoNegocioVentasBuque
							Else IsNull(Fac.IdTipoNegocioVentas,0)
					 End
		End,
		--Case When CDP.IdDetalleFactura is not null Then Case When CDP.Exporta='SI' Then @IdTipoNegocioVentasElevacion  Else @IdTipoNegocioVentasEntrega End
		--		When MOVS.IdDetalleFactura is not null Then @IdTipoNegocioVentasBuque
		--		Else IsNull(Fac.IdTipoNegocioVentas,0)
		--End,
 	--	Case When CDP.IdDetalleFactura is not null Then Det.Cantidad --IsNull(CDP.NetoFinal/1000,0)
		--		When MOVS.IdDetalleFactura is not null Then Det.Cantidad --IsNull(MOVS.Cantidad/1000,0)
		--		Else 0
		--End, 
		Det.Cantidad,



		    (
				Select ','+ cast(CDP.numerocartadeporte as varchar(20)) + 'id' + cast(CDP.idcartadeporte  as varchar(20))     AS [text()]
				FROM CartasDePorte CDP 
				where  CDP.IdDetalleFactura=Det.IdDetalleFactura
				For XML PATH ('')
			) [asdad]




 FROM Detallefacturas Det
 LEFT OUTER JOIN Facturas Fac On Fac.IdFactura=Det.IdFactura  
-- LEFT OUTER JOIN CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
-- LEFT OUTER JOIN CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) and 
		(@IdCentroCosto=-1 or Fac.IdObra=@IdCentroCosto) and Not Exists(Select Top 1 aux.IdFactura From #Auxiliar20 aux Where aux.IdFactura=Det.IdFactura)

--INSERT INTO #Auxiliar1  
-- SELECT Det.IdDetalleFactura, Det.IdFactura, IsNull(Fac.IdTipoNegocioVentas,0), Det.Cantidad, ''
-- FROM Detallefacturas Det
-- LEFT OUTER JOIN Facturas Fac On Fac.IdFactura=Det.IdFactura  
-- LEFT OUTER JOIN CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
-- LEFT OUTER JOIN CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
-- WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) and 
--		CDP.IdDetalleFactura is null and MOVS.IdDetalleFactura is null and 
--		(@IdCentroCosto=-1 or Fac.IdObra=@IdCentroCosto) and Not Exists(Select Top 1 aux.IdFactura From #Auxiliar20 aux Where aux.IdFactura=Det.IdFactura)

/*
-- Control de IdTipoNegocioVentas faltantes
select 
 Case When Exists(Select Top 1 cta.IdCtaCte
  From CuentasCorrientesDeudores cta
  Where cta.IdComprobante=Det.IdFactura and cta.IdTipoComp=1 and Exists(Select Top 1 dnc.IdDetalleNotaCreditoImputaciones From DetalleNotasCreditoImputaciones dnc where dnc.IdImputacion=cta.IdCtaCte)
  ) Then 'Con NC' Else 'Sin NC' End as [NC],
 Empleados.Nombre,
 Case When Exists(Select Top 1 CDP.IdCartaDePorte From CartasDePorte CDP Where CDP.IdDetalleFactura=#Auxiliar1.IdDetalleFactura) Then 'Con Carta de porte' Else 'Sin Carta de porte' End as [Carta de porte],
 Case When Exists(Select Top 1 MOVS.IdCDPMovimiento From CartasPorteMovimientos MOVS Where MOVS.IdDetalleFactura=#Auxiliar1.IdDetalleFactura) Then 'Con Carta de porte movimiento' Else 'Sin Carta de porte movimiento' End as [Carta de porte movimiento],
 Fac.*
from #Auxiliar1
LEFT OUTER JOIN Detallefacturas Det On Det.IdDetalleFactura=#Auxiliar1.IdDetalleFactura  
LEFT OUTER JOIN Facturas Fac On Fac.IdFactura=Det.IdFactura  
LEFT OUTER JOIN Empleados On Empleados.IdEmpleado=Fac.IdUsuarioIngreso
LEFT OUTER JOIN CartasDePorte CDP On CDP.IdDetalleFactura=#Auxiliar1.IdDetalleFactura
LEFT OUTER JOIN CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=#Auxiliar1.IdDetalleFactura and MOVS.Tipo=4
where IsNull(#Auxiliar1.IdTipoNegocioVentas,0)=0
*/

UPDATE #Auxiliar1
SET IdTipoNegocioVentas=IsNull((Select Top 1 Case When cdp.Exporta='SI' Then @IdTipoNegocioVentasElevacion Else @IdTipoNegocioVentasEntrega End From CartasDePorte cdp Where cdp.IdFacturaImputada=#Auxiliar1.IdFactura),0)
WHERE IsNull(IdTipoNegocioVentas,0)=0

UPDATE #Auxiliar1
SET IdTipoNegocioVentas=IsNull((Select Top 1 Case When IsNull(cdpm.IdCDPMovimiento,0)>0 Then @IdTipoNegocioVentasBuque Else 0 End From CartasPorteMovimientos cdpm Where cdpm.IdFacturaImputada=#Auxiliar1.IdFactura),0)
WHERE IsNull(IdTipoNegocioVentas,0)=0

--select * 
--from #Auxiliar1 
--left outer join Facturas on Facturas.IdFactura=#Auxiliar1.IdFactura
--where IsNull(#Auxiliar1.IdTipoNegocioVentas,0)=0
--order by #Auxiliar1.IdFactura

INSERT INTO #Auxiliar2 
 SELECT 
	1,
	a1.IdDetalleFactura,
	Det.IdArticulo,
	IsNull(TiposNegociosVentas.Codigo,0),
	IsNull(TiposNegociosVentas.Descripcion,''),
	IsNull(TiposNegociosVentas.Grupo,''),
	Fac.IdObra,
	Round(a1.Cantidad * Det.PrecioUnitario * (1-(IsNull(Det.Bonificacion,0)/100)) * Fac.CotizacionMoneda,2),
	a1.Cantidad,
	IsNull(Tipos.Codigo,1),
	a1.Observaciones

 FROM #Auxiliar1 a1 
 LEFT OUTER JOIN DetalleFacturas Det ON Det.IdDetalleFactura=a1.IdDetalleFactura
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Det.IdFactura
 LEFT OUTER JOIN TiposNegociosVentas ON TiposNegociosVentas.IdTipoNegocioVentas=a1.IdTipoNegocioVentas
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdArticulo
 LEFT OUTER JOIN Tipos ON Tipos.IdTipo=Articulos.IdTipo

INSERT INTO #Auxiliar2 
 SELECT 
	5,
	Dev.IdDevolucion,
	-1,
	0,
	'',
	'',
	Dev.IdObra,
	Case When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 and Dev.PorcentajeIva1<>0
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - 
				IsNull(Dev.PercepcionIVA,0)) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9 or (Dev.PorcentajeIva1=0)
		 Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
		Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3 - 
				IsNull(Dev.OtrasPercepciones1,0) - IsNull(Dev.OtrasPercepciones2,0) - IsNull(Dev.PercepcionIVA,0)) * Dev.CotizacionMoneda
	End * -1,
	(Select Sum(IsNull(dd.Cantidad,0)) From DetalleDevoluciones dd Where dd.IdDevolucion=Dev.IdDevolucion) * -1,
	1,
	''
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and IsNull(Dev.IdObra,0)>0 and Dev.FechaDevolucion between @Desde1 and DATEADD(n,1439,@Hasta1) and (@IdCentroCosto=-1 or Dev.IdObra=@IdCentroCosto)

INSERT INTO #Auxiliar2 
 SELECT 
	3,
	Deb.IdNotaDebito,
	-1,
	999999,
	'z DEBITOS y CREDITOS',
	'zDEBCRED',
	Deb.IdObra,
	IsNull((Select Sum(IsNull(dnd.Importe,0) - IsNull(dnd.IvaNoDiscriminado,0)) From DetalleNotasDebito dnd Where dnd.IdNotaDebito=Deb.IdNotaDebito),0),
	0,
	1
	,''
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and IsNull(Deb.IdObra,0)>0 and Deb.FechaNotaDebito between @Desde1 and DATEADD(n,1439,@Hasta1) and (@IdCentroCosto=-1 or Deb.IdObra=@IdCentroCosto)

/*
INSERT INTO #Auxiliar2 
 SELECT 
	4,
	Cre.IdNotaCredito,
	-1,
	999999,
	'z DEBITOS y CREDITOS',
	'zDEBCRED',
	Cre.IdObra,
	IsNull((Select Sum(IsNull(dnc.Importe,0) - IsNull(dnc.IvaNoDiscriminado,0)) From DetalleNotasCredito dnc Where dnc.IdNotaCredito=Cre.IdNotaCredito),0) * -1,
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and IsNull(Cre.IdObra,0)>0 and Cre.FechaNotaCredito between @Desde1 and DATEADD(n,1439,@Hasta1)
*/

UPDATE #Auxiliar2
SET CodigoTipo=0, Tipo='OTROS', Grupo='OTROS'
WHERE Grupo2<>1



INSERT INTO #Auxiliar3 
 SELECT IdObra, CodigoTipo, Tipo, Grupo, IdArticulo, Sum(IsNull(NetoGravado,0)), Sum(IsNull(Cantidad,0)), 0, Grupo2, 
    (
				Select ','+ AUX.Observaciones   AS [text()]
				FROM #Auxiliar2 AUX
				where  #Auxiliar2.IdObra=AUX.IdObra and 
						#Auxiliar2.CodigoTipo=AUX.CodigoTipo and 
						#Auxiliar2.Grupo=AUX.Grupo and 
						#Auxiliar2.IdArticulo=AUX.IdArticulo and 
						#Auxiliar2.Grupo2=AUX.Grupo2  
				For XML PATH ('')
			) [asdad]

 FROM #Auxiliar2
 GROUP BY IdObra, CodigoTipo, Tipo, Grupo, IdArticulo, Grupo2




SET @TotalVentas=IsNull((Select Sum(IsNull(NetoGravado,0)) From #Auxiliar3),0)
IF @TotalVentas<>0
	UPDATE #Auxiliar3
	SET Porcentaje=Round(NetoGravado/@TotalVentas*100,2)
SET @TotalPorcentaje=IsNull((Select Sum(IsNull(Porcentaje,0)) From #Auxiliar3),0)
SET @IdObra=IsNull((Select Top 1 IdObra From #Auxiliar3 Where IdObra<>@IdObraAdministracion),0)
IF @IdObra>0
	UPDATE #Auxiliar3
	SET Porcentaje=Porcentaje+(100-@TotalPorcentaje)
	WHERE IdObra=@IdObra


/*  ============= GASTOS =============  */

INSERT INTO #Auxiliar6 
 SELECT 
	IsNull(DetCP.IdObra,cp.IdObra),
	RubrosContables.IdRubroContable,
	DetCP.Importe * cp.CotizacionMoneda * tc.Coeficiente
 FROM DetalleComprobantesProveedores DetCP
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=DetCP.IdComprobanteProveedor
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=DetCP.IdCuenta
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN CuentasGastos ON CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=CuentasGastos.IdRubroContable
 WHERE (cp.FechaRecepcion Between @Desde And @Hasta) and IsNull(cp.Confirmado,'')<>'NO' and IsNull(DetCP.IdObra,IsNull(cp.IdObra,0))>0 and RubrosContables.IdRubroContable is not null

INSERT INTO #Auxiliar7 
 SELECT a6.IdObra, a6.IdRubroContable, IsNull(RubrosContables.DistribuirGastosEnResumen,'NO'), Sum(IsNull(a6.Importe,0))
 FROM #Auxiliar6 a6 
 LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=a6.IdRubroContable
 LEFT OUTER JOIN Obras ON Obras.IdObra=a6.IdObra
 WHERE Obras.IdObra is not null
 GROUP BY a6.IdObra, a6.IdRubroContable, RubrosContables.DistribuirGastosEnResumen

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdObra, IdRubroContable, Importe FROM #Auxiliar7 WHERE IdObra=@IdObraAdministracion and DistribuirGastosEnResumen='SI' ORDER BY IdObra, IdRubroContable
OPEN Cur
FETCH NEXT FROM Cur INTO @IdObra, @IdRubroContable, @Importe
WHILE @@FETCH_STATUS = 0
  BEGIN
	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdObra, Porcentaje FROM #Auxiliar3 ORDER BY IdObra
	OPEN Cur2
	FETCH NEXT FROM Cur2 INTO @IdObra2, @Porcentaje
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @Importe2=Round(@Importe*@Porcentaje/100,2)
		INSERT INTO #Auxiliar8
		(IdObra, IdRubroContable, Importe)
		VALUES
		(@IdObra2, @IdRubroContable, @Importe2)
		FETCH NEXT FROM Cur2 INTO @IdObra2, @Porcentaje
	  END
	CLOSE Cur2
	DEALLOCATE Cur2

	FETCH NEXT FROM Cur INTO @IdObra, @IdRubroContable, @Importe
  END
CLOSE Cur
DEALLOCATE Cur

INSERT INTO #Auxiliar8 
 SELECT IdObra, IdRubroContable, Importe
 FROM #Auxiliar7
 WHERE IdObra<>@IdObraAdministracion or (IdObra=@IdObraAdministracion and DistribuirGastosEnResumen<>'SI')

INSERT INTO #Auxiliar9 
 SELECT IdObra, IdRubroContable, Sum(IsNull(Importe,0))
 FROM #Auxiliar8
 GROUP BY IdObra, IdRubroContable

SET NOCOUNT OFF

IF @Salida='VENTAS'
	SELECT IsNull(a3.IdObra,0) as [IdObra], IsNull(Obras.Descripcion,'') as [Obra], a3.CodigoTipo as [CodigoTipo], a3.Tipo as [Tipo], a3.Grupo as [Grupo], IsNull(Articulos.Descripcion,'') as [Articulo], 
			IsNull(a3.NetoGravado,0) as [NetoGravado], IsNull(a3.Cantidad,0) as [Cantidad], IsNull(a3.Porcentaje,0) as [Porcentaje], a3.Grupo2 as [Grupo2]
	FROM #Auxiliar3 a3 
	LEFT OUTER JOIN Obras ON Obras.IdObra=a3.IdObra
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=a3.IdArticulo
	ORDER BY a3.Grupo2, [CodigoTipo], [Tipo], [Grupo], [Articulo], a3.IdObra
  
IF @Salida='VENTAS_R'
  BEGIN
	SELECT IsNull(a3.IdObra,0) as [IdObra], IsNull(Obras.Descripcion,'') as [Obra], a3.CodigoTipo as [CodigoTipo], a3.Grupo as [Grupo], 
			Sum(IsNull(a3.NetoGravado,0)) as [NetoGravado], Sum(IsNull(a3.Cantidad,0)) as [Cantidad]
	FROM #Auxiliar3 a3 
	LEFT OUTER JOIN Obras ON Obras.IdObra=a3.IdObra
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=a3.IdArticulo
	GROUP BY a3.IdObra, Obras.Descripcion, a3.CodigoTipo, a3.Grupo
	ORDER BY a3.IdObra, [CodigoTipo], [Grupo]

	--SELECT Sum(IsNull(a3.NetoGravado,0)) as [NetoGravado], Sum(IsNull(a3.Cantidad,0)) as [Cantidad]
	--FROM #Auxiliar3 a3 
  END

IF @Salida='GASTOS'
	SELECT RubrosContables.IdRubroContable, RubrosContables.Descripcion as [RubroContable], IsNull(a9.IdObra,0) as [IdObra], Obras.Descripcion as [Obra], IsNull(a9.Importe,0) as [Importe]
	FROM  RubrosContables
	LEFT OUTER JOIN #Auxiliar9 a9 ON a9.IdRubroContable=RubrosContables.IdRubroContable
	LEFT OUTER JOIN Obras ON Obras.IdObra=a9.IdObra
	ORDER BY RubrosContables.Descripcion, a9.IdObra

select * from #Auxiliar3

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9
DROP TABLE #Auxiliar20

go




declare @Desde datetime,@Hasta datetime,@Salida varchar(10)
set @Desde=convert(datetime,'1/4/2015',103)
set @Hasta=convert(datetime,'30/4/2015',103)
set @Salida='VENTAS'

exec InformeResumenGastosPorRubroContable_TX_1_ConInfoDeImputacion @desde,@hasta,@salida
exec InformeResumenGastosPorRubroContable_TX_1 @desde,@hasta,@salida