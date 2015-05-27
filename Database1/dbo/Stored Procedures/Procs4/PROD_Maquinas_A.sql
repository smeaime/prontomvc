
create Procedure PROD_Maquinas_A

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

INSERT INTO [PROD_Maquinas]
(
IdArticulo ,

ParoFrecuencia ,
ParoIdUnidad ,
ParoConcepto ,

FueraDeServicio,
FueraDeServicioConcepto  ,
FueraDeServicioFechaInicio ,
FueraDeServicioRetornoEstimado ,
FueraDeServicioRetornoEfectivo ,

TiempoArranque ,
TiempoApagado,
IdUnidadTiempo ,

CapacidadMinima,
CapacidadNormal ,
CapacidadMaxima,
IdUnidadCapacidad ,

IdProduccionProceso ,
IdProduccionLinea ,
LineaOrden 
)
VALUES
(
@IdArticulo ,

@ParoFrecuencia ,
@ParoIdUnidad ,
@ParoConcepto ,

@FueraDeServicio,
@FueraDeServicioConcepto  ,
@FueraDeServicioFechaInicio ,
@FueraDeServicioRetornoEstimado ,
@FueraDeServicioRetornoEfectivo ,

@TiempoArranque ,
@TiempoApagado,
@IdUnidadTiempo ,

@CapacidadMinima,
@CapacidadNormal ,
@CapacidadMaxima,
@IdUnidadCapacidad ,

@IdProduccionProceso ,
@IdProduccionLinea ,
@LineaOrden 
)

SELECT @IdPROD_Maquina=@@identity
RETURN(@IdPROD_Maquina)
