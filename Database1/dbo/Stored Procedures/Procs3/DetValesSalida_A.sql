CREATE Procedure [dbo].[DetValesSalida_A]

@IdDetalleValeSalida int  output,
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

AS 

INSERT INTO [DetalleValesSalida]
(
 IdValeSalida,
 IdArticulo,
 IdStock,
 Partida,
 Cantidad,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 IdDetalleReserva,
 IdDetalleLMateriales,
 Estado,
 IdCentroCosto,
 Cumplido,
 EnviarEmail,
 IdDetalleValeSalidaOriginal,
 IdValeSalidaOriginal,
 IdOrigenTransmision,
 IdEquipoDestino,
 IdDetalleSolicitudEntrega,
 IdDetalleRequerimiento
)
VALUES 
(
 @IdValeSalida,
 @IdArticulo,
 @IdStock,
 @Partida,
 @Cantidad,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @IdDetalleReserva,
 @IdDetalleLMateriales,
 @Estado,
 @IdCentroCosto,
 @Cumplido,
 @EnviarEmail,
 @IdDetalleValeSalidaOriginal,
 @IdValeSalidaOriginal,
 @IdOrigenTransmision,
 @IdEquipoDestino,
 @IdDetalleSolicitudEntrega,
 @IdDetalleRequerimiento
)

SELECT @IdDetalleValeSalida=@@identity

RETURN(@IdDetalleValeSalida)