
CREATE PROCEDURE [spDetalleFacturas_PorTipoCartaPorte]
(
--	@IdDetalleFactura int,
	 -- 0 normal entrega (default)/ 1 exportacion / 2 embarque / 3 gasto administrativo

--@IdDetalleFacturaDesde int=1,
--@IdDetalleFacturaHasta int=null



    @FechaDesde DATETIME = NULL,
    @FechaHasta DATETIME = NULL
	)

AS 
    SET NOCOUNT ON

    SET @FechaDesde = ISNULL(@FechaDesde, CONVERT(DATETIME, '1/1/1900'))
    SET @FechaHasta = ISNULL(@FechaHasta, CONVERT(DATETIME, '1/1/2100'))


select * from 
(

select 
DETFAC.IdDetalleFactura, 
Case When CDP.Exporta='SI' Then 'EXPORTACION'  Else 'ENTREGA' End as Tipo -- When  DETFAC.IdArticulo=57 Then 'ADMINISTRATIVO'
,sum(CDP.NetoFinal/1000) as Cantidad
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta
group by DETFAC.IdDetalleFactura,CDP.Exporta

UNION
select 
DETFAC.IdDetalleFactura , 
'BUQUE' as Tipo,
sum(MOVS.Cantidad/1000000)
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
inner JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta
group by DETFAC.IdDetalleFactura

UNION

--select 
--DETFAC.IdDetalleFactura , 
--'SIN IMPUTAR' as Tipo,
--sum(DETFAC.cantidad) - sum(isnull(MOVS.Cantidad,0)) /1000 - SUM (isnull(CDP.NetoFinal,0))/1000   --cuando haces el join, la cantidad de DETFAC se multiplica por cada renglon...

--FROM Detallefacturas DETFAC
--left outer JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
--left outer JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
--where DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
--group by DETFAC.IdDetalleFactura


--UNION

select 
DETFAC.IdDetalleFactura , 
'TOTAL' as Tipo,
DETFAC.cantidad 
FROM Detallefacturas DETFAC
inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta

-------

) as Q


union



select DETFAC.IdDetalleFactura,'SIN IMPUTAR'
,isnull(DETFAC.Cantidad,0)-isnull(T.Cantidad,0)
from Detallefacturas 
DETFAC
left outer join 
(
	select  G.IdDetalleFactura as IdDetalleFactura,'IMPUTADO' as Tipo ,sum(G.Cantidad)  as Cantidad from  (
					select 
					DETFAC.IdDetalleFactura, 
					Case When CDP.Exporta='SI' Then 'EXPORTACION'  Else 'ENTREGA' End as Tipo -- When  DETFAC.IdArticulo=57 Then 'ADMINISTRATIVO'
					,sum(CDP.NetoFinal/1000) as Cantidad
					FROM Detallefacturas DETFAC
					inner JOIN CartasDePorte CDP on CDP.IdDetalleFactura=DETFAC.IdDetalleFactura
					inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
					where 
					--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
					CABFAC.FechaFactura between @FechaDesde and @FechaHasta
					group by DETFAC.IdDetalleFactura,CDP.Exporta

					UNION
					select 
					DETFAC.IdDetalleFactura , 
					'BUQUE' as Tipo,
					MOVS.Cantidad/1000000
					FROM Detallefacturas DETFAC
					inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  
					inner JOIN CartasPorteMovimientos MOVS ON MOVS.IdDetalleFactura = DETFAC.IdDetalleFactura and MOVS.Tipo=4
					where 
					--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
					CABFAC.FechaFactura between @FechaDesde and @FechaHasta

					) as G
					group by G.IdDetalleFactura

	) as T    on DETFAC.IdDetalleFactura=T.IdDetalleFactura 
	inner  join facturas CABFAC on	 DETFAC.IdFactura=CABFAC.IdFactura  

where 
--DETFAC.IdDetalleFactura between @IdDetalleFacturaDesde and @IdDetalleFacturaHasta
CABFAC.FechaFactura between @FechaDesde and @FechaHasta


-----
order by Q.IdDetalleFactura,Tipo




--comparar con la suma total de la factura
