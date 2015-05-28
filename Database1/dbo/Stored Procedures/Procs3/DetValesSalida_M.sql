


CREATE Procedure [dbo].[DetValesSalida_M]
@IdDetalleValeSalida int,
@IdValeSalida int,
@IdArticulo int,
@IdStock int,
@Partida varchar(20),
@Cantidad numeric(12,2),
@CantidadAdicional numeric(12,2),
@IdUnidad int,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@IdDetalleReserva int,
@IdDetalleLMateriales int,
@Estado varchar(2),
@IdCentroCosto int,
@Cumplido varchar(2),
@EnviarEmail tinyint,
@IdDetalleValeSalidaOriginal int,
@IdValeSalidaOriginal int,
@IdOrigenTransmision int,
@IdEquipoDestino int,
@IdDetalleSolicitudEntrega int,
@IdDetalleRequerimiento int
As
Update [DetalleValesSalida]
Set 
 IdValeSalida=@IdValeSalida,
 IdArticulo=@IdArticulo,
 IdStock=@IdStock,
 Partida=@Partida,
 Cantidad=@Cantidad,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 IdDetalleReserva=@IdDetalleReserva,
 IdDetalleLMateriales=@IdDetalleLMateriales,
 Estado=@Estado,
 IdCentroCosto=@IdCentroCosto,
 Cumplido=@Cumplido,
 EnviarEmail=@EnviarEmail,
 IdDetalleValeSalidaOriginal=@IdDetalleValeSalidaOriginal,
 IdValeSalidaOriginal=@IdValeSalidaOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdEquipoDestino=@IdEquipoDestino,
 IdDetalleSolicitudEntrega=@IdDetalleSolicitudEntrega,
 IdDetalleRequerimiento=@IdDetalleRequerimiento
Where (IdDetalleValeSalida=@IdDetalleValeSalida)
Return(@IdDetalleValeSalida)


