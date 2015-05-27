
CREATE Procedure ProduccionPartes_TX_ProcesoAnteriorObligatorioSinRendir
@IdProduccionOrden int,
@IdProduccionProceso int
AS 

declare @idDet int

--este proc debiera devolver todos los procesos anteriores que faltan empezar,
--siempre y cuando el proceso por el que se pregunta exija esa validacion



SELECT @idDet=DET.idDetalleProduccionOrdenProceso  --este select trae el proceso que me interesa del detalle de procesos de la OP
FROM DetalleProduccionOrdenProcesos DET
left outer join Produccionprocesos on DET.idProduccionProceso=Produccionprocesos.idProduccionProceso
WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
and DET.idproduccionproceso=@idproduccionproceso
and Produccionprocesos.valida='SI'

/*
if @iddet is null
begin
	return 
end
*/

SELECT *   -- y acá trae todos los procesos anteriores (de id menor) a ese detalle, que 
		   --             no tengan un parte abierto (al ver PP.idproduccionProceso is null)
FROM DetalleProduccionOrdenProcesos DET
left outer join ProduccionPartes PP on 
	PP.idProduccionProceso=DET.idProduccionProceso and 
	PP.idProduccionOrden=DET.idProduccionOrden
left outer join Produccionprocesos on DET.idProduccionProceso=Produccionprocesos.idProduccionProceso
WHERE 
	DET.IdProduccionOrden=@IdProduccionOrden
	AND
	(PP.idproduccionProceso is null) --PP.FechaFinal is null
	and
	(idDetalleProduccionOrdenProceso<@iddet)-- or @iddet is null)

