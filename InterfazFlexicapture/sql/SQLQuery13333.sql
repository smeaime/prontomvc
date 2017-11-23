declare @Desde1 datetime
declare @Hasta1 datetime
set @Desde1='1/1/2014'
set @Hasta1='1/1/2015'



--SELECT * FROM 
--(
-- Select Det.IdDetalleFactura as [IdDetalleFactura], Case When CDP.Exporta='SI' Then 'EXPORTACION'  Else 'ENTREGA' End as [Tipo], Sum(CDP.NetoFinal/1000) as [Cantidad]
-- From Detallefacturas Det
-- Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
-- Inner Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
-- Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
-- Group By Det.IdDetalleFactura, CDP.Exporta

-- Union

-- Select Det.IdDetalleFactura as [IdDetalleFactura], 'BUQUE' as [Tipo], Sum(MOVS.Cantidad/1000000) as [Cantidad]
-- From Detallefacturas Det
-- Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
-- Inner Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
-- Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and
--  (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
-- Group By Det.IdDetalleFactura
--) as Q

--Union


--select idfactura, SUM(X.Cantidad),dbo.Factura_CantidadDeCartasPorteImputadas(IdFactura) from 
--(


Select dbo.Factura_CantidadDeCartasPorteImputadas(det.IdFactura), det.Observaciones,det.idarticulo,art.descripcion, det.IdFactura,  IsNull(Det.Cantidad,0) as cantfac, IsNull(T.Cantidad,0) as cantcartanetofinal, 
 Det.IdDetalleFactura as [IdDetalleFactura], 'SIN IMPUTAR' as [Tipo], IsNull(Det.Cantidad,0)-IsNull(T.Cantidad,0) as [Cantidad]
From Detallefacturas Det
Left Outer Join
(Select G.IdDetalleFactura as [IdDetalleFactura], 'IMPUTADO' as [Tipo], Sum(G.Cantidad) as [Cantidad] 
 From	(
 
 Select Det.IdDetalleFactura as [IdDetalleFactura], Case When CDP.Exporta='SI' Then 'EXPORTACION' Else 'ENTREGA' End as [Tipo], Sum(CDP.NetoFinal/1000) as [Cantidad]
		 From Detallefacturas Det
		 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
		 Inner Join CartasDePorte CDP On CDP.IdDetalleFactura=Det.IdDetalleFactura
		 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
		 Group By Det.IdDetalleFactura, CDP.Exporta

		 Union

		 Select Det.IdDetalleFactura as [IdDetalleFactura], 'BUQUE' as [Tipo]
		 --, MOVS.Cantidad/1000000 as [Cantidad] 
		 , MOVS.Cantidad/1000 as [Cantidad] 
		 From Detallefacturas Det
		 Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
		 Inner Join CartasPorteMovimientos MOVS On MOVS.IdDetalleFactura=Det.IdDetalleFactura and MOVS.Tipo=4
		 Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and 
		 (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then
		  Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
		) as G
 Group By G.IdDetalleFactura
) as T On Det.IdDetalleFactura=T.IdDetalleFactura 
Inner Join Facturas Fac On Fac.IdFactura=Det.IdFactura  
left outer Join articulos art On art.idarticulo=Det.idarticulo
Where IsNull(Fac.Anulada,'')<>'SI' and IsNull(Fac.IdObra,0)>0 and (Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde1 and DATEADD(n,1439,@Hasta1))
---
and abs(IsNull(Det.Cantidad,0)-IsNull(T.Cantidad,0))  >0 
and det.IdArticulo<>57
and det.IdArticulo<>60
and det.IdArticulo<>66
and det.IdArticulo<>67
and det.IdArticulo<>71

 order by dbo.Factura_CantidadDeCartasPorteImputadas(det.IdFactura)
--) as X
--Group By x.IdFactura
--order by dbo.Factura_CantidadDeCartasPorteImputadas(IdFactura sum(x.cantidad)
--Order By X.IdDetalleFactura, Tipo
--Order By Tipo, Cantidad



---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
---////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
select * from CartasDePorte where  IdFacturaImputada = 56357
                                     

select * from [Condiciones Compra]

--update CartasDePorte  set iddetallefactura=null  where IdDetalleFactura=1 and IdCartaDePorte>1000000




select IdDetalleFactura,IdFacturaimputada,CartasDePorte.IdArticulo, 
dbo.DetalleFacturas_PorIdCartaPorte( idcartadeporte),* from cartasdeporte where IdFacturaimputada=56420

select * from DetalleFacturas where IdFactura=56420
*/

/*

--select * from DetalleFacturas where IdFactura=55759
--

select NumeroExpedienteCertificacionObra from Facturas --where IdFactura>57111
select * from DetalleFacturas where IdFactura=57111

--select  IdDetalleFactura,* from  CartasPorteMovimientos MOVS

--select IdDetalleFactura,IdFacturaimputada,* from cartasdeporte 

select IdDetalleFactura,IdFacturaimputada,CartasDePorte.IdArticulo, 
dbo.DetalleFacturas_PorIdCartaPorte( idcartadeporte),* from cartasdeporte where IdFacturaimputada=57111
--print dbo.DetalleFacturas_PorIdCartaPorte( idcartadeporte)

print dbo.DetalleFacturas_PorIdCartaPorte( 1355967)
print dbo.DetalleFacturas_PorIdCartaPorte( 1360329)


select IdDetalleFactura,IdFacturaimputada,CartasDePorte.IdArticulo, 
dbo.DetalleFacturas_PorIdCartaPorte( idcartadeporte),* from cartasdeporte 
where IdFacturaimputada=55947
where IdDetalleFactura=97229




 select  IdDetalleFactura,* from  CartasPorteMovimientos MOVS where 
  MOVS.IdDetalleFactura=97220
 MOVS.IdDetalleFactura=97229
 MOVS.IdFacturaImputada=57757
 
 update CartasPorteMovimientos set IdDetalleFactura=null where IdFacturaImputada is null
 
  select  IdDetalleFactura,* from  CartasPorteMovimientos MOVS where IdFacturaImputada is null
  
  
  */