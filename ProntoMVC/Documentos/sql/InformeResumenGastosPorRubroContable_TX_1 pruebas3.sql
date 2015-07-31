


declare @Desde datetime,@Hasta datetime,@Salida varchar(10),@IdCentroCosto int = Null
set @Desde=convert(datetime,'1/4/2015',103)
set @Hasta=convert(datetime,'30/4/2015',103)
set @Salida='VENTAS'
set @IdCentroCosto=-1


--El informe de contribución emitido para 04/2015 indica que se facturaron en BsAs 98,262.10 TN de Elevación.
--Al emitir el listado de descargas de Exportacion del 01/04/2015 al 30/04/2015 de BsAs el kilaje total da 216,634,870.
exec InformeResumenGastosPorRubroContable_TX_1 @desde,@hasta,@salida


exec InformeResumenGastosPorRubroContable_TX_1 '1/4/2015','30/4/2015','VENTAS'







DECLARE @Desde1 datetime, @Hasta1 datetime, @TotalVentas numeric(18,2), @TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, 
		@IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), @Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int

	SET @Desde1=DateAdd(m,1,@Desde)
--	SET @Hasta1=DateAdd(d,-1,DateAdd(m,1,@Desde1))
	SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))



--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
 inner join  CuentasCorrientesDeudores on CuentasCorrientesDeudores.IdCtaCte=DetalleNotasCreditoImputaciones.IdImputacion 
					and IdTipoComp=1 
 inner join  Facturas Fac on CuentasCorrientesDeudores.IdComprobante=Fac.idfactura and IdTipoComp=1 
 Inner Join Detallefacturas Det On Fac.IdFactura=Det.IdFactura  
 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////

drop table #Auxiliar2


CREATE TABLE #Auxiliar2 
			(
			 IdDetalleFactura INTEGER,
			 Cantidad NUMERIC(18, 2)
			)
			

INSERT INTO #Auxiliar2 
SELECT IdDetalleFactura,  Det.Cantidad
 FROM Detallefacturas Det
 left outer Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 --left outer Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 --left outer Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 
 and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
 --and (det.IdArticulo=57 or det.IdArticulo=6 or det.IdArticulo=60 or det.IdArticulo=66) 
--		and CDP.IdDetalleFactura is null
--		and MOVS.IdDetalleFactura is null
order by  IdDetalleFactura




select uuu.*, 

'SIN IMPUTAR' + '- idfac ' + cast(df.idfactura as varchar) 
	+ '-NCRED ' +(select cast(count(*) as varchar) from #Auxiliar10 where Tipo='NOTA DE CREDITO' 
			and #Auxiliar10.IdDetalleFactura=uuu.IdDetalleFactura) 
	+ '-CARTASENFAC ' +(select cast(count(*) as varchar) from Cartasdeporte where IdFacturaImputada=df.IdFactura) 
	+ '-CARTASENITEM ' +(select cast(count(*) as varchar) from Cartasdeporte where IdDetalleFactura=uuu.IdDetalleFactura) 
	--+ '-' + art.descripcion 
	+ '- idart ' + cast(df.idarticulo as varchar) + '  cant. ' + cast(Cantidad as varchar)+ ' '
	+  cast(df.Observaciones as varchar)  collate SQL_Latin1_General_CP1_CI_AS  as [Observaciones] 
		

from 

(

select xx.iddetallefactura, df.IdFactura, sum(NetoFinal) as amano,sum(#Auxiliar2.Cantidad) as posta
, abs(sum(NetoFinal)-sum(#Auxiliar2.Cantidad)) as dif  

		

from
(
select x.IdDetalleFactura,x.IdFactura,det.Cantidad,sum(NetoFinal) as netofinal,det.Cantidad-sum(NetoFinal) as dif  from 
(


--imputacion de cartas

 SELECT 1 as gg,fac.IdFactura, Det.IdDetalleFactura, Fac.IdObra, 0 as ggg,
		Case When CDP.IdDetalleFactura is not null Then IsNull(CDP.NetoFinal/1000,0)
--			When MOVS.IdDetalleFactura is not null Then IsNull(MOVS.Cantidad/1000,0)
			Else 0
		End as NetoFinal, 
		Det.Cantidad
		
		
	
		
		
		
		
		
 FROM Detallefacturas Det
 left outer Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 left outer Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
-- left outer Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
 Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1)
  and CDP.IdDetalleFactura is not null
) as x
left outer Join Detallefacturas Det On Det.IdDetalleFactura=x.IdDetalleFactura  
 group by x.IdDetalleFactura,x.IdFactura,det.Cantidad
--order by  det.Cantidad-sum(NetoFinal) desc ,x.IdDetalleFactura 

union

select x.IdDetalleFactura,x.IdFactura,det.Cantidad,sum(NetoFinal) as netofinal,det.Cantidad-sum(NetoFinal) as dif  from 
(

--imputacion de buques
 SELECT 1 as gg,fac.IdFactura, Det.IdDetalleFactura, Fac.IdObra, 0 as ggg,
		Case 
--			When CDP.IdDetalleFactura is not null Then IsNull(CDP.NetoFinal/1000,0)
			When MOVS.IdDetalleFactura is not null Then IsNull(MOVS.Cantidad/1000,0)
			Else 0
		End as NetoFinal, 
		Det.Cantidad
 FROM Detallefacturas Det
 left outer Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
-- left outer Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 left outer Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
 Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1)
  and MOVS.IdDetalleFactura is not null
) as x
left outer Join Detallefacturas Det On Det.IdDetalleFactura=x.IdDetalleFactura  
 group by x.IdDetalleFactura,x.IdFactura,det.Cantidad
--order by  det.Cantidad-sum(NetoFinal) desc ,x.IdDetalleFactura 

union

--todo lo que no está imputado
 SELECT Det.IdDetalleFactura, det.IdFactura ,  Det.Cantidad, Det.Cantidad as netofinal, 0
 FROM Detallefacturas Det
 left outer Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
 left outer Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
 left outer Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
 WHERE IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 
 and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
 --and (det.IdArticulo=57 or det.IdArticulo=6 or det.IdArticulo=60 or det.IdArticulo=66) 
		and CDP.IdDetalleFactura is null
		and MOVS.IdDetalleFactura is null
 
) as xx
left outer join #Auxiliar2 on #Auxiliar2.IdDetalleFactura=xx.IdDetalleFactura
left outer join DetalleFacturas df on df.IdDetalleFactura=xx.IdDetalleFactura
group by xx.IdDetalleFactura,df.IdFactura

 

) as uuu
left outer join DetalleFacturas df on df.IdDetalleFactura=uuu.IdDetalleFactura
where dif>0
order by  
dif desc,
uuu.IdDetalleFactura



--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////
--//////////////////////////////////////////////////////////////////////////////////////////////////////

--select IdFacturaImputada,IdDetalleFactura,* from CartasDePorte where IdFacturaImputada=61388
--select IdFacturaImputada,IdDetalleFactura,* from CartasDePorte where IdFacturaImputada=61388

--[RefrescarCartasPorteDetalleFacturas]
--update CartasPorteMovimientos
--set iddetallefactura=null

--select IdFacturaImputada,IdDetalleFactura,* from CartasPorteMovimientos where IdFacturaImputada=61332

--select MOVS.IdCDPMovimiento,movs.IdFacturaImputada,DETFAC.iddetallefactura
--					from facturas CABFAC
--					inner join detallefacturas DETFAC ON DETFAC.IdFactura = CABFAC.IdFactura
--					inner join   [CartasPorteMovimientos] MOVS ON MOVS.IdFacturaImputada = CABFAC.IdFactura
--					--left OUTER  join [CartasPorteMovimientos] MOVS2 ON DETFAC.iddetallefactura = MOVS2.iddetallefactura
--					where 
--					MOVS.IdCDPMovimiento=718					and
--					MOVS.Tipo=4
--					and DETFAC.Observaciones like 'BUQUE%'
--					and abs(detfac.Cantidad-movs.Cantidad/1000)<1
--					order by IdFacturaImputada