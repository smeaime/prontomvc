

create function fProduccion_StockPrevistoPorDia(@idArticuloMaterial int,@Fecha DATETIME,@hoy DATETIME)
returns numeric(18,2)
as
begin

declare @stockhoy as numeric(18,2)

--no se puede usar getdate en funciones porque no es determinista....
--declare @hoy as datetime
--SET @hoy=SELECT getdate()

--SET @Fecha=DATEADD(d,-1,@Fecha)   --truco fulero

SELECT @stockhoy=ISNULL(Sum(IsNull(Stock.CantidadUnidades,0)),0)
FROM Stock 
WHERE Stock.IdArticulo=@idArticuloMaterial

--print 'Stock Original ' + @stockhoy 

--////////////////////////
--////   RESTAS (- OC de Cliente - OPs que usen ese articulo)
--////////////////////////
select @stockhoy=@stockhoy-ISNULL(sum(IsNull(DET.Cantidad,0)),0)
	from DetalleOrdenesCompra DET
--	where (FechaInicioPrevista between @hoy and @Fecha)
	where ( isnull(FechaEntrega,FechaNecesidad)>=@hoy  AND isnull(FechaEntrega,FechaNecesidad) <@Fecha)
		and idArticulo=@idArticuloMaterial
	--	AND (Anulada<>'SI' OR anulada IS NULL)	 --hacer el join con el encabezado para filtrar nulos, 


--no se pueden usar prints en una funcion, lo tenes que convertir a sp....
--print '-OC '
--print @stockhoy 


select @stockhoy=@stockhoy-ISNULL(sum(IsNull(DET.Cantidad,0)),0)
	from DetalleProduccionOrdenes DET
	left outer join ProduccionOrdenes CAB on DET.idProduccionOrden=CAB.idProduccionOrden
--	where (FechaInicioPrevista between @hoy and @Fecha)
	where ( FechaInicioPrevista>=@hoy  and	FechaInicioPrevista <@Fecha)
		and idArticulo=@idArticuloMaterial
		AND (Anulada<>'SI' OR anulada IS NULL)	
		AND NOT FechaInicioPrevista IS null

--print '-OP ' + @stockhoy 

--////////////////////////
--////   SUMAS   (OPs que produzcan ese articulo + RMs + NPdeProveedor)
--////////////////////////

select @stockhoy=@stockhoy+ISNULL(sum(IsNull(CAB.Cantidad,0)),0)
	from ProduccionOrdenes CAB 
--	left outer join ProduccionPartes PARTES on PARTES.idProduccionOrden=CAB.idProduccionOrden
--	where (FechaInicioPrevista between @hoy and @Fecha)
	where ( FechaInicioPrevista>=@hoy  and	FechaInicioPrevista <@Fecha)
		and idarticulogenerado=@idArticuloMaterial
		AND (Anulada<>'SI' OR anulada IS NULL)	
		AND NOT FechaInicioPrevista IS null
		and (not aprobo is null) -- or not partes.idproduccionOrden is null) --no quise hacer el join de partes por el distinct...

--print '+OP ' + @stockhoy 

select @stockhoy=@stockhoy+ISNULL(sum(IsNull(DET.Cantidad,0)),0)
	from DetalleRequerimientos DET
--	where (FechaEntrega between @hoy and @Fecha)
	where ( FechaEntrega>=@hoy  and	FechaEntrega <@Fecha)
		and idArticulo=@idArticuloMaterial
		AND DET.IdDetalleRequerimiento NOT IN (SELECT IdDetalleRequerimientoOriginal FROM dbo.DetallePedidos where not IdDetalleRequerimientoOriginal is null)
		--AND (Anulada<>'SI' OR anulada IS NULL)	--hacer el join con el encabezado para filtrar nulos, 

--print '+RM ' + @stockhoy 

--pedidos a Proveedor
select @stockhoy=@stockhoy+ISNULL(sum(IsNull(DET.Cantidad,0)),0)
	from DetallePedidos DET
--	where (FechaEntrega between @hoy and @Fecha)
	where ( FechaNecesidad>=@hoy  AND FechaNecesidad <@Fecha)
		and idArticulo=@idArticuloMaterial
		--AND (Anulada<>'SI' OR anulada IS NULL)	--hacer el join con el encabezado para filtrar nulos, 

--print '+PED ' + @stockhoy 

return @stockhoy

end

