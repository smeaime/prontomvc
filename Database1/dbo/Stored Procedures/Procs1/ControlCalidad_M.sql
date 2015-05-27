





























CREATE Procedure [dbo].[ControlCalidad_M]
@IdDetalleRecepcion int,
@IdRecepcion int,
@Cantidad numeric(18,2),
@IdUnidad int,
@IdArticulo int,
@IdControlCalidad int,
@Observaciones ntext,
@Cantidad1 numeric(18,2),
@Cantidad2 numeric(18,2),
@IdDetallePedido int,
@Controlado varchar(2),
@CantidadAdicional numeric(18,2),
@Partida varchar(20),
@CantidadCC numeric(18,2),
@Cantidad1CC numeric(18,2),
@Cantidad2CC numeric(18,2),
@CantidadAdicionalCC numeric(18,2),
@ObservacionesCC ntext,
@CantidadRechazadaCC numeric(18,2),
@IdMotivoRechazo int,
@IdRealizo int,
@IdDetalleRequerimiento int,
@Trasabilidad varchar(10),
@IdDetalleAcopios int
as
Update [DetalleRecepciones]
SET 
IdRecepcion=@IdRecepcion,
Cantidad=@Cantidad,
IdUnidad=@IdUnidad,
IdArticulo=@IdArticulo,
IdControlCalidad=@IdControlCalidad,
Observaciones=@Observaciones,
Cantidad1=@Cantidad1,
Cantidad2=@Cantidad2,
IdDetallePedido=@IdDetallePedido,
Controlado=@Controlado,
CantidadAdicional=@CantidadAdicional,
Partida=@Partida,
CantidadCC=@CantidadCC,
Cantidad1CC=@Cantidad1CC,
Cantidad2CC=@Cantidad2CC,
CantidadAdicionalCC=@CantidadAdicionalCC,
ObservacionesCC=@ObservacionesCC,
CantidadRechazadaCC=@CantidadRechazadaCC,
IdMotivoRechazo=@IdMotivoRechazo,
IdRealizo=@IdRealizo,
IdDetalleRequerimiento=@IdDetalleRequerimiento,
Trasabilidad=@Trasabilidad,
IdDetalleAcopios=@IdDetalleAcopios
where (IdDetalleRecepcion=@IdDetalleRecepcion)
Return(@IdDetalleRecepcion)






























