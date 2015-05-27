create Procedure ProduccionPartes_A

@IdProduccionParte int output,
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
@ParoFinal datetime , 

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

INSERT INTO [ProduccionPartes]
(
IdEmpleado,
FechaDia,
FechaInicio,
FechaFinal,
IdProduccionOrden,
IdProduccionProceso,
Horas, 
HorasReales,
idMaquina,
IdArticulo,
IdStock,
Partida,
Cantidad,
IdUnidad,

IdPROD_TiposControlCalidad ,
Control1  ,
Control2  ,
Control3  ,
Control4  ,
Control5  ,

ParoObservacion ,
ParoInicio  ,
ParoFinal   ,

IdArticuloGenerado,
CantidadGenerado ,
IdUnidadGenerado ,

IdArticuloDeshecho,
CantidadDeshecho ,


 IdSMConsumo ,
 IdOIProducto ,
 IdOISubProducto ,

 FechaRegistracion ,
 Anulada ,
 FechaAnulacion ,
 IdUsuarioAnulo ,

	IdUbicacion ,
	Aux_txtStockActual , 
	Aux_txtPendiente ,
	Aux_txtTolerancia,
	 IdUsuarioCerro 

)
VALUES
(
@IdEmpleado,
@FechaDia,
@FechaInicio,
@FechaFinal,
@IdProduccionOrden,
@IdProduccionProceso,
@Horas, 
@HorasReales,
@idMaquina,
@IdArticulo,
@IdStock,
@Partida,
@Cantidad,
@IdUnidad,

@IdPROD_TiposControlCalidad ,
@Control1  ,
@Control2  ,
@Control3  ,
@Control4  ,
@Control5  ,

@ParoObservacion ,
@ParoInicio  ,
@ParoFinal   ,

@IdArticuloGenerado ,
@CantidadGenerado ,
@IdUnidadGenerado,

@IdArticuloDeshecho,
@CantidadDeshecho,

 @IdSMConsumo ,
 @IdOIProducto ,
 @IdOISubProducto ,

 @FechaRegistracion ,
 @Anulada ,
 @FechaAnulacion ,
 @IdUsuarioAnulo ,

	@IdUbicacion ,
	@Aux_txtStockActual, 
	@Aux_txtPendiente ,
	@Aux_txtTolerancia ,
		 @IdUsuarioCerro

)

SELECT @IdProduccionParte=@@identity
RETURN(@IdProduccionParte)


