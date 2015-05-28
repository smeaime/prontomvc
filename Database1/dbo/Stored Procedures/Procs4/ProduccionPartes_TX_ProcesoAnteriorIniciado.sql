
CREATE Procedure ProduccionPartes_TX_ProcesoAnteriorIniciado
@IdProduccionOrden int,
@IdProduccionProceso int
AS 

declare @idDet int

SELECT @idDet=idDetalleProduccionOrden 
FROM DetalleProduccionOrdenes DET
WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
and idproduccionproceso=@idproduccionproceso

print @iddet

SELECT * 
FROM ProduccionPartes PP
join Produccionprocesos on PP.idProduccionProceso=Produccionprocesos.idProduccionProceso
join DetalleProduccionOrdenes on PP.idProduccionProceso=DetalleProduccionOrdenes.idProduccionProceso
right outer join detalleproduccionordenprocesos DETPROCS on  PP.idProduccionProceso=DETPROCS.idProduccionProceso
WHERE (PP.IdProduccionOrden=@IdProduccionOrden)
AND
PP.FechaInicio is null
and
Produccionprocesos.valida='SI'
and
idDetalleProduccionOrden<@iddet

