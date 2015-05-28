
CREATE Procedure ProduccionPartes_TX_ProcesoIdenticoEnMarcha
@IdProduccionOrden int,
@IdProduccionProceso INT,
@IdEmpleado INT,
@Fecha DATETIME

AS 

/*
declare @idDet int

SELECT @idDet=idDetalleProduccionOrden 
FROM DetalleProduccionOrdenes DET
WHERE (DET.IdProduccionOrden=@IdProduccionOrden)
and idproduccionproceso=@idproduccionproceso
*/

SELECT * 
FROM ProduccionPartes PP
join Produccionprocesos on PP.idProduccionProceso=Produccionprocesos.idProduccionProceso
join DetalleProduccionOrdenes on PP.idProduccionProceso=DetalleProduccionOrdenes.idProduccionProceso
WHERE 
	(PP.IdProduccionOrden=@IdProduccionOrden)
and
	PP.idproduccionproceso=@IdProduccionProceso 
AND 
	IdEmpleado=@IdEmpleado
AND
	FechaFinal is null
--AND 
--	pp.FechaDia=@Fecha

