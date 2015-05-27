




CREATE Procedure [dbo].[DetReservas_M]
@IdDetalleReserva int,
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
Update [DetalleReservas]
Set 
 IdReserva=@IdReserva,
 IdArticulo=@IdArticulo,
 IdStock=@IdStock,
 Partida=@Partida,
 CantidadUnidades=@CantidadUnidades,
 CantidadAdicional=@CantidadAdicional,
 IdUnidad=@IdUnidad,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Retirada=@Retirada,
 Estado=@Estado,
 IdDetalleLMateriales=@IdDetalleLMateriales,
 IdDetalleRequerimiento=@IdDetalleRequerimiento,
 IdDetalleAcopios=@IdDetalleAcopios,
 IdCentroCosto=@IdCentroCosto,
 IdObra=@IdObra,
 EnviarEmail=@EnviarEmail,
 IdDetalleReservaOriginal=@IdDetalleReservaOriginal,
 IdReservaOriginal=@IdReservaOriginal,
 IdOrigenTransmision=@IdOrigenTransmision
Where (IdDetalleReserva=@IdDetalleReserva)
Return(@IdDetalleReserva)




