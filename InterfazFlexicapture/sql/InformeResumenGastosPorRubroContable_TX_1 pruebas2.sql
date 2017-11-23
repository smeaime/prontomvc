declare @Desde datetime,@Hasta datetime,@Salida varchar(10),@IdCentroCosto int = Null
set @Desde=convert(datetime,'1/2/2014',103)
set @Hasta=convert(datetime,'28/2/2014',103)
set @IdCentroCosto = 8
--select * from obras


DECLARE @Desde1 datetime, @Hasta1 datetime, @TotalVentas numeric(18,2), @TotalPorcentaje numeric(6,2), @IdObraAdministracion int, @IdObra int, @IdObra2 int, 
		@IdRubroContable int, @Importe numeric(18,2), @Importe2 numeric(18,2), @Porcentaje numeric(6,2), @IdDetalleFactura int, @IdFactura int, @IdArticulo int

	SET @Desde1=DateAdd(m,1,@Desde)
	SET @Hasta1=DateAdd(d,-1,DateAdd(m,2,convert(datetime,'01/'+Convert(varchar,Month(@Hasta))+'/'+Convert(varchar,Year(@Hasta)),103)))




select idfactura, 
sum(Cantidad), sum(netofinal),sum(Cantidad)- sum(netofinal)
from

(
select fac.idfactura as idfactura, sum(det.Cantidad) as Cantidad  , 0 as netofinal
 from Facturas Fac 
 left outer Join  detallefacturas Det On Fac.IdFactura=Det.IdFactura
where
IsNull(Fac.Anulada,'')<>'SI' 
and IsNull(Fac.IdObra,0)=@IdCentroCosto  -- left outer join Obras on Obras.IdObra=#Auxiliar4.IdObra
  and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
group by fac.idfactura

union
select fac.idfactura, 0 , sum(netofinal/1000)
 from Facturas Fac 
 left outer Join cartasdeporte CDP On Fac.IdFactura=CDP.IdFacturaimputada
where
IsNull(Fac.Anulada,'')<>'SI' 
and IsNull(Fac.IdObra,0)=@IdCentroCosto 
  and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 
group by fac.idfactura
) as a
 --where ( sum(Cantidad)- sum(netofinal))<>0
group by idfactura
order by idfactura asc





 SELECT  Sum(IsNull(df.Cantidad,0))
 
 FROM Facturas Fac
   LEFT OUTER JOIN DetalleFacturas df ON df.IdFactura=Fac.IdFactura
 --LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 WHERE
  IsNull(Fac.Anulada,'')<>'SI'
  and IsNull(Fac.IdObra,0)=@IdCentroCosto  
  and Fac.FechaFactura between @Desde1 and DATEADD(n,1439,@Hasta1) 

