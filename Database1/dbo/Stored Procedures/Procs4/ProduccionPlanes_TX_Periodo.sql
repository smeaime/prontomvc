
create procedure  ProduccionPlanes_TX_Periodo
@idArticuloProducido int,
@idArticuloMaterial int,
@FechaIni datetime,
@FechaFin datetime

as

declare @stock int
declare @proporcion NUMERIC(18,2)

---------------------------
--no encontré cómo hacer para que el exec no devolviera una tabla. Así que voy a hacer el select
--a lo macho -podés usar "Insert into #temp from dbo.sp"
/*
set nocount on
exec @stock=dbo.Stock_TX_ExistenciaPorArticulo @idArticuloMaterial 
set nocount off
*/

SELECT @stock=Sum(IsNull(Stock.CantidadUnidades,0))
FROM Stock 
WHERE Stock.IdArticulo=@idArticuloMaterial

DECLARE @hoy DATETIME

SET @hoy=GETDATE()

--verificar stock inicial -El problema es que no está tomando en cuenta las RMs que genera el mismo planificador

---------------------------


--pero hay que traerlo pára esa fecha!!!!
set @proporcion=(select top 1 Det.cantidad/ProduccionFichas.cantidad
		FROM DetalleProduccionFichas Det
		LEFT OUTER JOIN ProduccionFichas ON ProduccionFichas.IdProduccionFicha=Det.IdProduccionFicha
		where  ProduccionFichas.idArticuloAsociado=@idArticuloProducido and   
			Det.idArticulo=@idArticuloMaterial)
/*
me tengo que traer el stock inicial
tambien las OPs
y lo que gastan del material


CREATE TABLE #Auxiliar1	
			(
			 IdDetalleProduccionOrden INTEGER,
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdUbicacion INTEGER,
			 IdObra INTEGER,
			 DescargaPorKit VARCHAR(2)
			)

INSERT INTO #Auxiliar1 
*/


/*
--este select solo toma las op con el articulo producido. NO ME SIRVE
select 'op'+cast(idProduccionOrden as varchar(10)) as id,FechaInicioPrevista as Fecha,'OP '+ cast(NumeroOrdenProduccion as varchar(10)) as Documento,Cliente,
	Cantidad,@stock as StockInicial,cantidad*@proporcion as AConsumir,0 as IngresosPrevistos,
	0 as StockFinal,0 as PedidosPrevistos,0 as OPPrevista
from ProduccionOrdenes
where (FechaInicioPrevista between @FechaIni and @FechaFin)
	and idArticuloGenerado=@idArticuloProducido
*/




	--paso un renglon sí o sí, para devolver el stock
	SELECT  ' STOCKINI' as id,
		--@FechaIni as Fecha,
		0 as Fecha,
		'' as Documento,
		'' as Cliente,
		0 AS Cantidad,
		dbo.fProduccion_StockPrevistoPorDia(@idArticuloMaterial,@FechaIni,@hoy) as StockInicial,
		0 as AConsumir,
		0 as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		'' as [Codigo]
	
union
	--OPs que lo producen
	select distinct 'op'+cast(CAB.idProduccionOrden as varchar(10)) as id,
		FechaInicioPrevista as Fecha,
		'OP '+ cast(NumeroOrdenProduccion as varchar(10)) as Documento,
		cast(Clientes.RazonSocial as varchar(20)) as Cliente,
		CAB.Cantidad,
		dbo.fProduccion_StockPrevistoPorDia(@idArticuloMaterial,@FechaIni,@hoy) as StockInicial,
		0 as AConsumir,
		--CAB.cantidad*dbo.fProduccionOrden_Proporcion(@idArticuloProducido,@idArticuloMaterial) as AConsumir,
		CAB.cantidad as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		 Clientes.Codigo as [Codigo]
	from ProduccionOrdenes CAB 
	left outer join ProduccionPartes PARTES on PARTES.idProduccionOrden=CAB.idProduccionOrden
	LEFT OUTER JOIN Clientes ON CAB.Cliente = Clientes.IdCliente
	where (FechaInicioPrevista between @FechaIni and @FechaFin)
		and CAB.idArticuloGenerado=@idArticuloMaterial
		AND (CAB.Anulada<>'SI' OR CAB.anulada IS NULL)	
		AND NOT FechaInicioPrevista IS null
	--select * from  ProduccionOrdenes
		and (not aprobo is null or not partes.idproduccionOrden is null) --está aprobada o en ejecucion
				/*
				o        No está mostrando las OP generadas en el período que se le solicita
				(por lo menos cuando hice la op manualmente). A su vez, una OP sólo puede mostrarse
				en el Plan cuando ya está “liberada” y por lo tanto toma “Estado: ABIERTA”.
				
				
				*/

union
	--OPs que lo gastan
	select distinct 'op'+cast(CAB.idProduccionOrden as varchar(10)) as id,
		FechaInicioPrevista as Fecha,
		'OP '+ cast(NumeroOrdenProduccion as varchar(10)) as Documento,
		cast(Clientes.RazonSocial as varchar(20)) as Cliente,
		CAB.Cantidad,
		dbo.fProduccion_StockPrevistoPorDia(@idArticuloMaterial,@FechaIni,@hoy) as StockInicial,
		CASE 
			WHEN (not aprobo is null or not partes.idproduccionOrden is null) THEN  DET.cantidad
			ELSE '0'
		END as AConsumir,
		--CAB.cantidad*dbo.fProduccionOrden_Proporcion(@idArticuloProducido,@idArticuloMaterial) as AConsumir,
		0 as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		 Clientes.Codigo as [Codigo]
	from DetalleProduccionOrdenes DET
	left outer join ProduccionOrdenes CAB on DET.idProduccionOrden=CAB.idProduccionOrden
	left outer join ProduccionPartes PARTES on PARTES.idProduccionOrden=CAB.idProduccionOrden
	LEFT OUTER JOIN Clientes ON CAB.Cliente = Clientes.IdCliente
	where (FechaInicioPrevista between @FechaIni and @FechaFin)
		and DET.idArticulo=@idArticuloMaterial
		AND (CAB.Anulada<>'SI' OR CAB.anulada IS NULL)	
		AND NOT FechaInicioPrevista IS null
	--select * from  ProduccionOrdenes
		--and (not aprobo is null or not partes.idproduccionOrden is null) --está aprobada o en ejecucion
				/*
				o        No está mostrando las OP generadas en el período que se le solicita
				(por lo menos cuando hice la op manualmente). A su vez, una OP sólo puede mostrarse
				en el Plan cuando ya está “liberada” y por lo tanto toma “Estado: ABIERTA”.
				
				
				*/



union

	select 
	   --'rm'+cast(idDetalleRequerimiento as varchar(10)) as id,
	   	'rm'+cast(CAB.idRequerimiento as varchar(10)) as id,
		FechaEntrega as Fecha,
		'RM '+ cast(CAB.NumeroRequerimiento as varchar(10)) as Documento,
		cast(Clientes.RazonSocial as varchar(20)) as Cliente,
		Cantidad,
		dbo.fProduccion_StockPrevistoPorDia(@idArticuloMaterial,@FechaIni,@hoy) as StockInicial,
		0 as AConsumir,
		Cantidad as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		Clientes.Codigo as [Codigo]
	
	from DetalleRequerimientos DET
	left join Requerimientos CAB on CAB.idRequerimiento=DET.idRequerimiento
	LEFT OUTER JOIN Clientes ON CAB.IdComprador = Clientes.IdCliente
	where (FechaEntrega between @FechaIni and @FechaFin)
		and idArticulo=@idArticuloMaterial
		AND DET.IdDetalleRequerimiento NOT IN (SELECT IdDetalleRequerimientoOriginal FROM dbo.DetallePedidos where not IdDetalleRequerimientoOriginal is null)
	
	--select * from  Requerimientos

union

	select 'NP'+cast(idDetalleRequerimiento as varchar(10)) as id,
		Fechanecesidad as Fecha,
		'NP '+ cast(CAB.numeropedido as varchar(10)) as Documento,
		cast(Clientes.RazonSocial as varchar(20)) as Cliente,
		Cantidad,
		dbo.fProduccion_StockPrevistoPorDia(@idArticuloMaterial,@FechaIni,@hoy) as StockInicial,
		0 as AConsumir,
		Cantidad as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		Clientes.Codigo as [Codigo]
	
	from DetallePedidos DET
	left join pedidos CAB on CAB.idpedido=DET.idpedido
	LEFT OUTER JOIN Clientes ON CAB.IdComprador = Clientes.IdCliente
	where (Fechanecesidad between @FechaIni and @FechaFin)
		and idArticulo=@idArticuloMaterial
	--select * from  Requerimientos

union

	--es con los pedidos o con las ordenes de compra???? 
	--ORDENES DE COMPRA!!!!!!! (en capen cambian nada más los labels)
	--Pero acá pasa lo mismo. Necesitás que 

	select distinct 'OC'+cast(OrdenesCompra.idOrdenCompra as varchar(10))  as id,
		--FechaNecesidad,
		isnull(FechaEntrega,FechaNecesidad) as FechaEntrega,
		'OC '+cast(NumeroOrdenCompra as varchar(10)) as Documento,
		cast(Clientes.RazonSocial as varchar(20)) as cliente,
		det.Cantidad,
		@stock,
		det.cantidad, --*@proporcion,
		0 as IngresosPrevistos,
		0 as StockFinal,
		'' as PedidosPrevistos,
		'' as OPPrevista,
		Clientes.Codigo as [Codigo]
	from DetalleOrdenesCompra det
	inner join OrdenesCompra  on det.idOrdenCompra=OrdenesCompra.idOrdenCompra
	LEFT OUTER JOIN Clientes ON OrdenesCompra.IdCliente = Clientes.IdCliente
	where 
		(isnull(FechaEntrega,fechaNecesidad) between @FechaIni and @FechaFin)
		and 

		det.idArticulo=@idArticuloProducido
		AND (Anulada<>'SI' OR anulada IS NULL)	
		--AND NOT FechaNecesidad IS null
		--AND NOT FechaEntrega IS null --y esto me está matando!!!

	
	--select * from OrdenesCompra
	--select * from DetalleOrdenesCompra

ORDER BY fecha,id
/*
union

	select 
	cast(IdProduccionPlan as varchar(10)) as id,
	Fecha,
	Documento,
	cast(Cliente as varchar(20)) collate database_default as cliente,
	Cantidad,
	StockInicial,	
	AConsumir,	
	IngresosPrevistos,
	StockFinal,
	PedidosPrevistos,
	OPPrevista,
	'' as [Codigo]
	from ProduccionPlanes
	where (Fecha between @FechaIni and @FechaFin)
		and (idArticuloProducido=@idArticuloProducido or @idArticuloProducido=-1)
		and idArticuloMaterial=@idArticuloMaterial
*/

