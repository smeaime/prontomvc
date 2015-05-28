

create Procedure PROD_Maquinas_M

@IdPROD_Maquina int output,

@IdArticulo int,

@ParoFrecuencia  numeric(18,2),
@ParoIdUnidad int,
@ParoConcepto  varchar(50) ,

@FueraDeServicio varchar (2),
@FueraDeServicioConcepto   varchar(50) ,
@FueraDeServicioFechaInicio smalldatetime,
@FueraDeServicioRetornoEstimado smalldatetime,
@FueraDeServicioRetornoEfectivo smalldatetime,

@TiempoArranque numeric(18,2),
@TiempoApagado numeric(18,2),
@IdUnidadTiempo int,

@CapacidadMinima numeric(18,2),
@CapacidadNormal  numeric(18,2),
@CapacidadMaxima numeric(18,2),
@IdUnidadCapacidad numeric(18,2),

@IdProduccionProceso int,
@IdProduccionLinea int,
@LineaOrden int


AS 

UPDATE PROD_Maquinas
SET
IdArticulo=@IdArticulo ,

ParoFrecuencia=@ParoFrecuencia ,
ParoIdUnidad=@ParoIdUnidad ,
ParoConcepto=@ParoConcepto ,

FueraDeServicio=@FueraDeServicio,
FueraDeServicioConcepto=@FueraDeServicioConcepto  ,
FueraDeServicioFechaInicio=@FueraDeServicioFechaInicio ,
FueraDeServicioRetornoEstimado=@FueraDeServicioRetornoEstimado ,
FueraDeServicioRetornoEfectivo=@FueraDeServicioRetornoEfectivo ,

TiempoArranque=@TiempoArranque ,
TiempoApagado=@TiempoApagado,
IdUnidadTiempo=@IdUnidadTiempo ,

CapacidadMinima=@CapacidadMinima,
CapacidadNormal=@CapacidadNormal ,
CapacidadMaxima=@CapacidadMaxima,
IdUnidadCapacidad=@IdUnidadCapacidad ,

IdProduccionProceso=@IdProduccionProceso ,
IdProduccionLinea=@IdProduccionLinea ,
LineaOrden=@LineaOrden 
where (IdPROD_Maquina=@IdPROD_Maquina)

RETURN(@IdPROD_Maquina)
