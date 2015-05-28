create Procedure ProduccionPartes_M

@IdProduccionParte int,
@IdEmpleado int ,
@FechaDia datetime,
@FechaInicio datetime,
@FechaFinal datetime,
@IdProduccionOrden int ,
@IdProduccionProceso int ,
@Horas numeric(12,2) , 
@HorasReales numeric(12,2) ,
@idMaquina int ,
@IdArticulo int ,
@IdStock int ,
@Partida varchar(20),
@Cantidad numeric(12,2),
@IdUnidad int,
@IdPROD_TiposControlCalidad int,
@Control1 numeric(18,2) ,
@Control2 numeric(18,2) ,
@Control3 numeric(18,2) ,
@Control4 numeric(18,2) ,
@Control5 numeric(18,2) ,

@ParoObservacion varchar(20),
@ParoInicio datetime ,
@ParoFinal datetime  ,

@IdArticuloGenerado int,
@CantidadGenerado numeric(12,2),
@IdUnidadGenerado int,

@IdArticuloDeshecho int,
@CantidadDeshecho numeric(12,2),

 @IdSMConsumo int,
 @IdOIProducto int,
 @IdOISubProducto int,

 @FechaRegistracion datetime,
 @Anulada varchar(2),
 @FechaAnulacion datetime,
 @IdUsuarioAnulo int,

	@IdUbicacion int,
	@Aux_txtStockActual numeric(18,2), 
	@Aux_txtPendiente numeric(18,2),
	@Aux_txtTolerancia numeric(18,2),
	
 @IdUsuarioCerro int
	 
AS 

UPDATE [ProduccionPartes]
SET

IdEmpleado=@IdEmpleado,
FechaDia=@FechaDia,
FechaInicio=@FechaInicio,
FechaFinal=@FechaFinal,
IdProduccionOrden=@IdProduccionOrden,
IdProduccionProceso=@IdProduccionProceso,
Horas=@Horas, 
HorasReales=@HorasReales,
idMaquina=@idMaquina,
IdArticulo=@IdArticulo,
IdStock=@IdStock,
Partida=@Partida,
Cantidad=@Cantidad,
IdUnidad=@IdUnidad,


IdPROD_TiposControlCalidad=@IdPROD_TiposControlCalidad ,
Control1=@Control1  ,
Control2=@Control2  ,
Control3=@Control3  ,
Control4=@Control4  ,
Control5=@Control5  ,

ParoObservacion=@ParoObservacion ,
ParoInicio=@ParoInicio  ,
ParoFinal=@ParoFinal   ,

IdArticuloGenerado=@IdArticuloGenerado,
CantidadGenerado=@CantidadGenerado,
IdUnidadGenerado=@IdUnidadGenerado,

IdArticuloDeshecho=@IdArticuloDeshecho,
CantidadDeshecho=@CantidadDeshecho,

IdSMConsumo= @IdSMConsumo ,
IdOIProducto= @IdOIProducto ,
IdOISubProducto= @IdOISubProducto ,

FechaRegistracion =@FechaRegistracion ,
Anulada =@Anulada,
FechaAnulacion= @FechaAnulacion ,
IdUsuarioAnulo= @IdUsuarioAnulo ,

	IdUbicacion=@IdUbicacion ,
	Aux_txtStockActual=@Aux_txtStockActual , 
	Aux_txtPendiente=@Aux_txtPendiente,
	Aux_txtTolerancia=@Aux_txtTolerancia,

 IdUsuarioCerro=@IdUsuarioCerro


WHERE (IdProduccionParte=@IdProduccionParte)

RETURN(@IdProduccionParte)

