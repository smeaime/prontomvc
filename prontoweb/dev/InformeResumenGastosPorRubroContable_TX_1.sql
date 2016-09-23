/****** Object:  StoredProcedure [dbo].[InformeResumenGastosPorRubroContable_TX_1]    Script Date: 08/07/2014 12:10:26 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformeResumenGastosPorRubroContable_TX_1]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InformeResumenGastosPorRubroContable_TX_1]
GO

/****** Object:  StoredProcedure [dbo].[InformeResumenGastosPorRubroContable_TX_1]    Script Date: 08/07/2014 12:10:26 ******/
SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InformeResumenGastosPorRubroContable_TX_1]

@Desde datetime,
@Hasta datetime,
@Salida varchar(10)

AS

SET NOCOUNT ON

DECLARE @Desde1 datetime, @Hasta1 datetime, @TotalVentas numeric(18,2), @TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, 
		@IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), @Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int

SET @Desde1=DateAdd(m,1,@Desde)
--SET @Hasta1=DateAdd(d,-1,DateAdd(m,1,@Desde1))
SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))
SET @IdObraAdministracion=IsNull((Select Top 1 IdObraStockDisponible From Parametros Where IdParametro=1),0)


CREATE TABLE #Auxiliar1 
			(
			 IdDetalleFactura INTEGER,
			 Tipo VARCHAR(50) collate SQL_Latin1_General_CP1_CI_AS,
			 Cantidad NUMERIC(18, 2),
			 Observaciones  VARCHAR(200) collate SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar10 
			(
			 IdDetalleFactura INTEGER,
			 Tipo VARCHAR(50) collate SQL_Latin1_General_CP1_CI_AS,
			 Cantidad NUMERIC(18, 2),
			 Observaciones  VARCHAR(200) collate SQL_Latin1_General_CP1_CI_AS
			)

CREATE TABLE #Auxiliar2 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 IdArticulo INTEGER,
			 Tipo VARCHAR(50),
			 IdObra INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar3 
			(
			 IdObra INTEGER,
			 Tipo VARCHAR(50),
			 IdArticulo INTEGER,
			 NetoGravado NUMERIC(18, 2),
			 Cantidad NUMERIC(18, 2),
			 Porcentaje NUMERIC(6, 2)
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

/*  ============= VENTAS =============  */




INSERT INTO #Auxiliar10  
Select Det.IdDetalleFactura as [IdDetalleFactura], Case When CDP.Exporta='SI' Then 'ELEVACION'  Else 'ENTREGA' End as [Tipo],
  Sum(CDP.NetoFinal/1000) as [Cantidad],'' as [Observaciones] 
 From Detallefacturas Det
 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 Inner Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
 Group By Det.IdDetalleFactura, CDP.Exporta

 Union

 Select Det.IdDetalleFactura as [IdDetalleFactura], Art.descripcion as [Tipo],
  Sum(Det.Cantidad) as [Cantidad],'' as [Observaciones] 
 From Detallefacturas Det
 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 left Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 inner join Articulos Art On Art.idarticulo=Det.idarticulo   
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and
  (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
		 and (det.IdArticulo=57 or det.IdArticulo=6 or det.IdArticulo=60 or det.IdArticulo=66) and CDP.IdDetalleFactura is null
 Group By Det.IdDetalleFactura,  Art.descripcion 

 Union

 Select Det.IdDetalleFactura as [IdDetalleFactura], 'BUQUE' as [Tipo], 
 Sum(MOVS.Cantidad/1000) as [Cantidad],'' as [Observaciones] 
 --Sum(MOVS.Cantidad/1000000) as [Cantidad]
 From Detallefacturas Det
 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 Inner Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
 Group By Det.IdDetalleFactura
 

 Union
		  
 select Det.IdDetalleFactura as [IdDetalleFactura],
 'NOTA DE CREDITO' as [Tipo], 
 0  as [Cantidad],''
 from DetalleNotasCreditoImputaciones
 inner join  CuentasCorrientesDeudores on CuentasCorrientesDeudores.IdCtaCte=DetalleNotasCreditoImputaciones.IdImputacion and IdTipoComp=1 
 inner join  Facturas Fac on CuentasCorrientesDeudores.IdComprobante=Fac.idfactura and IdTipoComp=1 
 Inner Join Detallefacturas Det On Fac.IdFactura=Det.IdFactura  
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))




			
			
			
			
INSERT INTO #Auxiliar1  
			
SELECT *  FROM  #Auxiliar10
as Q

Union





Select Det.IdDetalleFactura as [IdDetalleFactura], 

Case When (select cast(count(*) as varchar) from Cartasdeporte where IdFacturaImputada=Det.IdFactura)=0 
	 Then 
		'EXCLUIR'  
	 Else 
		isnull(T.Tipo,'ENTREGA')
 End as [Tipo],

IsNull(Det.Cantidad,0)-IsNull(
		--T.Cantidad --no sirve restar T contra Det, porque T está divido por Tipos
		(select  SUM(Cantidad) from #Auxiliar10 where #Auxiliar10.IdDetalleFactura=Det.IdDetalleFactura)
	,0)   as [Cantidad], 

'SIN IMPUTAR' + '- idfac ' + cast(fac.idfactura as varchar) 
+ '-NCRED ' +(select cast(count(*) as varchar) from #Auxiliar10 where Tipo='NOTA DE CREDITO' and IdDetalleFactura=Det.IdDetalleFactura) 
+ '-CARTASENFAC ' +(select cast(count(*) as varchar) from Cartasdeporte where IdFacturaImputada=Det.IdFactura) 
+ '-' + art.descripcion + '- idart ' + cast(Det.idarticulo as varchar) + '  cant. ' + cast(Det.Cantidad as varchar)+ ' '
 +  cast(Det.Observaciones as varchar)  collate SQL_Latin1_General_CP1_CI_AS  as [Observaciones] 
From Detallefacturas Det
Left Outer Join
(Select G.IdDetalleFactura as [IdDetalleFactura],G.Tipo as [Tipo], Sum(G.Cantidad) as [Cantidad] 
 From	(
		Select  * FROM  #Auxiliar10

		 
		) as G
 Group By G.IdDetalleFactura,G.Tipo
) as T On Det.IdDetalleFactura=T.IdDetalleFactura 
Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
inner join Articulos Art On Art.idarticulo=Det.idarticulo   


Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then 
			Fac.FechaFactura 
			Else Fac.FechaVencimiento 
		End 
	   between @Desde1 and DATEADD(n,1439,@Hasta1)) and  (IsNull(Det.Cantidad,0)-IsNull(T.Cantidad,0)) <>0





Order By 
Q.IdDetalleFactura,
 Tipo
 ,cantidad



------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------

delete #Auxiliar1
where tipo='NOTA DE CREDITO' or tipo='EXCLUIR'




------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------



UPDATE #Auxiliar1
SET Tipo=IsNull((Select Top 1 
				 tnv.Descripcion 
				 From DetalleFacturas df 
				 Left Outer Join Facturas f On f.IdFactura=df.IdFactura  
				 Left Outer Join TiposNegociosVentas tnv On tnv.IdTipoNegocioVentas=f.IdTipoNegocioVentas
				 Where df.IdDetalleFactura=#Auxiliar1.IdDetalleFactura and f.IdTipoNegocioVentas is not null),Tipo)

INSERT INTO #Auxiliar2 
 SELECT 
	1,
	a1.IdDetalleFactura,
	Det.IdArticulo,
	a1.Tipo,
	Fac.IdObra,
	Round(a1.Cantidad * Det.PrecioUnitario * (1-(IsNull(Det.Bonificacion,0)/100)) * Fac.CotizacionMoneda,2),
	a1.Cantidad
 FROM #Auxiliar1 a1 
 LEFT OUTER JOIN DetalleFacturas Det ON Det.IdDetalleFactura=a1.IdDetalleFactura
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Det.IdFactura
 --LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente

INSERT INTO #Auxiliar2 
 SELECT 
	5,
	Dev.IdDevolucion,
	-1,
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
	(Select Sum(IsNull(dd.Cantidad,0)) From DetalleDevoluciones dd Where dd.IdDevolucion=Dev.IdDevolucion) * -1
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 WHERE IsNull(Dev.Anulada,'')<>'SI' and IsNull(Dev.IdObra,0)>0 and Dev.FechaDevolucion between @Desde1 and DATEADD(n,1439,@Hasta1)

INSERT INTO #Auxiliar2 
 SELECT 
	3,
	Deb.IdNotaDebito,
	-1,
	'z DEBITOS y CREDITOS',
	Deb.IdObra,
	IsNull((Select Sum(IsNull(dnd.Importe,0) - IsNull(dnd.IvaNoDiscriminado,0)) From DetalleNotasDebito dnd Where dnd.IdNotaDebito=Deb.IdNotaDebito),0),
	0
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 WHERE IsNull(Deb.Anulada,'')<>'SI' and IsNull(Deb.IdObra,0)>0 and Deb.FechaNotaDebito between @Desde1 and DATEADD(n,1439,@Hasta1)

INSERT INTO #Auxiliar2 
 SELECT 
	4,
	Cre.IdNotaCredito,
	-1,
	'z DEBITOS y CREDITOS',
	Cre.IdObra,
	IsNull((Select Sum(IsNull(dnc.Importe,0) - IsNull(dnc.IvaNoDiscriminado,0)) From DetalleNotasCredito dnc Where dnc.IdNotaCredito=Cre.IdNotaCredito),0) * -1,
	0
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 WHERE IsNull(Cre.Anulada,'')<>'SI' and IsNull(Cre.IdObra,0)>0 and Cre.FechaNotaCredito between @Desde1 and DATEADD(n,1439,@Hasta1)

INSERT INTO #Auxiliar3 
 SELECT IdObra, Tipo, IdArticulo, Sum(IsNull(NetoGravado,0)), Sum(IsNull(Cantidad,0)), 0
 FROM #Auxiliar2
 GROUP BY IdObra, Tipo, IdArticulo

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
	SELECT IsNull(a3.IdObra,0) as [IdObra], IsNull(Obras.Descripcion,'') as [Obra], a3.Tipo as [Tipo], IsNull(Articulos.Descripcion,'') as [Articulo], 
			IsNull(a3.NetoGravado,0) as [NetoGravado], IsNull(a3.Cantidad,0) as [Cantidad], IsNull(a3.Porcentaje,0) as [Porcentaje]
	FROM #Auxiliar3 a3 
	LEFT OUTER JOIN Obras ON Obras.IdObra=a3.IdObra
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=a3.IdArticulo
	ORDER BY [Tipo], [Articulo], a3.IdObra


IF @Salida='GASTOS'
	SELECT RubrosContables.IdRubroContable, RubrosContables.Descripcion as [RubroContable], IsNull(a9.IdObra,0) as [IdObra], Obras.Descripcion as [Obra], IsNull(a9.Importe,0) as [Importe]
	FROM  RubrosContables
	LEFT OUTER JOIN #Auxiliar9 a9 ON a9.IdRubroContable=RubrosContables.IdRubroContable
	LEFT OUTER JOIN Obras ON Obras.IdObra=a9.IdObra
	ORDER BY RubrosContables.Descripcion, a9.IdObra

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3

DROP TABLE #Auxiliar6
DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar9

GO





declare @Desde datetime,@Hasta datetime,@Salida varchar(10)
set @Desde=convert(datetime,'1/3/2014',103)
set @Hasta=convert(datetime,'31/3/2014',103)
set @Salida='VENTAS'

exec InformeResumenGastosPorRubroContable_TX_1 @desde,@hasta,@salida