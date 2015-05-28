

CREATE Procedure ProduccionOrdenes_TX_TieneProcesosObligatoriosSinCumplir
@IdProduccionOrden int
AS 


/*
--procesos en el detalle de productos
SELECT DET.idProduccionOrden,DET.idProduccionProceso
FROM DetalleProduccionOrdenes DET
left outer join produccionpartes PP 
	on PP.idProduccionProceso=DET.idProduccionProceso
	and PP.idProduccionOrden=DET.idProduccionOrden
left outer join Produccionprocesos PROCS 
	on PROCS.idProduccionProceso=PP.idProduccionProceso
WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
and PROCS.obligatorio='SI'
*/

--procesos del detalle de procesos
SELECT DET.idProduccionOrden,DET.idProduccionProceso,PP.idProduccionParte,PROCS.Descripcion,PP.FechaFinal
FROM DetalleProduccionOrdenProcesos DET

left outer join produccionpartes PP 
	on PP.idProduccionProceso=DET.idProduccionProceso
	and PP.idProduccionOrden=DET.idProduccionOrden
left outer join Produccionprocesos PROCS 
	on PROCS.idProduccionProceso=DET.idProduccionProceso
WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
and PROCS.obligatorio='SI'
and PP.FechaFinal is null

