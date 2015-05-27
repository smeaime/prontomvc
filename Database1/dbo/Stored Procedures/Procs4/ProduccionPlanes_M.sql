

create Procedure ProduccionPlanes_M
@IdProduccionPlan int output,
@Fecha datetime,
@Documento varchar(30),
@Cliente varchar(30),
@Cantidad numeric(18,2),
@StockInicial numeric(18,2),	
@AConsumir numeric(18,2),	
@IngresosPrevistos numeric(18,2),
@StockFinal numeric(18,2),
@PedidosPrevistos numeric(18,2),
@OPPrevista int,

@PlanMaestro int,

@idArticuloProducido int,
@idArticuloMaterial int,

@GrillaSerializada varchar(2000)

AS 

UPDATE ProduccionPlanes
SET
Fecha=@Fecha ,
Documento=@Documento ,
Cliente=@Cliente ,
Cantidad=@Cantidad ,
StockInicial=@StockInicial ,	
AConsumir=@AConsumir ,	
IngresosPrevistos=@IngresosPrevistos ,
StockFinal=@StockFinal ,
PedidosPrevistos=@PedidosPrevistos ,
OPPrevista=@OPPrevista,
PlanMaestro=@PlanMaestro,
idArticuloProducido=@idArticuloProducido,
idArticuloMaterial=@idArticuloMaterial ,
GrillaSerializada=@GrillaSerializada

where (IdProduccionPlan=@IdProduccionPlan)

RETURN(@IdProduccionPlan)
