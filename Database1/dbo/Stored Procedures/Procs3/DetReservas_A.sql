




CREATE Procedure [dbo].[DetReservas_A]
@IdDetalleReserva int  output,
@IdReserva int,
@IdArticulo int,
@IdStock int,
@Partida varchar(20),
@CantidadUnidades numeric(12,2),
@CantidadAdicional numeric(12,2),
@IdUnidad int,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@Retirada varchar(2),
@Estado varchar(2),
@IdDetalleLMateriales int,
@IdDetalleRequerimiento int,
@IdDetalleAcopios int,
@IdCentroCosto int,
@IdObra int,
@EnviarEmail tinyint,
@IdDetalleReservaOriginal int,
@IdReservaOriginal int,
@IdOrigenTransmision int
As 
Insert into [DetalleReservas]
(
 IdReserva,
 IdArticulo,
 IdStock,
 Partida,
 CantidadUnidades,
 CantidadAdicional,
 IdUnidad,
 Cantidad1,
 Cantidad2,
 Retirada,
 Estado,
 IdDetalleLMateriales,
 IdDetalleRequerimiento,
 IdDetalleAcopios,
 IdCentroCosto,
 IdObra,
 EnviarEmail,
 IdDetalleReservaOriginal,
 IdReservaOriginal,
 IdOrigenTransmision
)
Values
(
 @IdReserva,
 @IdArticulo,
 @IdStock,
 @Partida,
 @CantidadUnidades,
 @CantidadAdicional,
 @IdUnidad,
 @Cantidad1,
 @Cantidad2,
 @Retirada,
 @Estado,
 @IdDetalleLMateriales,
 @IdDetalleRequerimiento,
 @IdDetalleAcopios,
 @IdCentroCosto,
 @IdObra,
 @EnviarEmail,
 @IdDetalleReservaOriginal,
 @IdReservaOriginal,
 @IdOrigenTransmision
)
Select @IdDetalleReserva=@@identity
Return(@IdDetalleReserva)




