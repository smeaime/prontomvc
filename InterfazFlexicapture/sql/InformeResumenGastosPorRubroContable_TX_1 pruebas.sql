declare @Desde datetime,@Hasta datetime,@Salida varchar(10)

set @Desde=convert(datetime,'1/2/2014',103)
set @Hasta=convert(datetime,'28/2/2014',103)

set @Salida='VENTAS'

exec InformeResumenGastosPorRubroContable_TX_1 @desde,@hasta,@salida




DECLARE @Desde1 datetime, @Hasta1 datetime, @TotalVentas numeric(18,2), @TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, 
		@IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), @Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int

SET @Desde1=DateAdd(m,1,@Desde)
--SET @Hasta1=DateAdd(d,-1,DateAdd(m,1,@Desde1))
SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))
SET @IdObraAdministracion=IsNull((Select Top 1 IdObraStockDisponible From Parametros Where IdParametro=1),0)

drop table #Auxiliar10

--select * from #Auxiliar10 where iddetallefactura=57950

CREATE TABLE #Auxiliar10 
			(
			 IdDetalleFactura INTEGER,
			 Tipo VARCHAR(50) collate SQL_Latin1_General_CP1_CI_AS,
			 Cantidad NUMERIC(18, 2),
			 Observaciones  VARCHAR(200) collate SQL_Latin1_General_CP1_CI_AS
			)


INSERT INTO #Auxiliar10  
Select Det.IdDetalleFactura as [IdDetalleFactura], Case When CDP.Exporta='SI' Then 'ELEVACION'  Else 'ENTREGA' End as [Tipo],
  Sum(CDP.NetoFinal/1000) as [Cantidad],'' as [Observaciones] 
 From Detallefacturas Det
 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 Inner Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
 (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'
	 Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
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
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
 (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' 
				Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
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




			
--SELECT IdDetalleFactura,sum(cantidad)  FROM  
--(			
			
		
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

--) as X
--group by X.IdDetalleFactura
--Order By  X.IdDetalleFactura
 

--select iddetallefactura,IdFacturaImputada,* from CartasPorteMovimientos


--select iddetallefactura,IdCartaDePorte from cartasdeporte where  
--iddetallefactura=1 
--idfacturaimputada=58205

--exec RefrescarCartasPorteDetalleFacturas 1


--print dbo.[DetalleFacturas_PorIdCartaPorte] (1412268)


--update CartasDePorte set IdDetalleFactura=1  where IdDetalleFactura is null  and IdCartaDePorte< 1400000


--select netofinal,idfacturaimputada, IdDetalleFactura,* from CartasDePorte where idfacturaimputada=57988 order by IdDetalleFactura

--select * from CartasDePorte where idfacturaimputada=57988

--select sum(cantidad) from DetalleFacturas where idfactura=58191




--esto solo suma las cantidades en las facturas. Generalmente es más, porque las cartas que se desimputaron (con notad de credito o no) se 
--facturaron más de una vez

 SELECT  --Sum(IsNull(df.Cantidad,0))
		iddetallefactura, IsNull(df.Cantidad,0) as [cantidad en factura]
 FROM Facturas Fac
   LEFT OUTER JOIN DetalleFacturas df ON df.IdFactura=Fac.IdFactura
 --LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE
  IsNull(Fac.Anulada,'')<>'SI'
  --and IsNull(Fac.IdObra,0)=@IdCentroCosto  
  and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
order by iddetallefactura asc



-- SELECT  --Sum(IsNull(df.Cantidad,0))
--		df.iddetallefactura, IsNull(df.Cantidad,0) as [cantidad en factura]
-- FROM Facturas Fac
--   LEFT OUTER JOIN DetalleFacturas df ON df.IdFactura=Fac.IdFactura
--   inner join CartasDePorte CDP on CDP.iddetallefactura=df.iddetallefactura
-- --LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
-- WHERE
--  IsNull(Fac.Anulada,'')<>'SI'
--  --and IsNull(Fac.IdObra,0)=@IdCentroCosto  
--  and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
--order by df.iddetallefactura asc
