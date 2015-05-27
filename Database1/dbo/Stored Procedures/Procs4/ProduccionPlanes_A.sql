create Procedure ProduccionPlanes_A
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

INSERT INTO [ProduccionPlanes]
(
Fecha ,
Documento ,
Cliente ,
Cantidad ,
StockInicial ,	
AConsumir ,	
IngresosPrevistos ,
StockFinal ,
PedidosPrevistos ,
OPPrevista ,

PlanMaestro ,
idArticuloProducido,
idArticuloMaterial ,

GrillaSerializada

)
VALUES
(
@Fecha ,
@Documento ,
@Cliente ,
@Cantidad ,
@StockInicial ,	
@AConsumir ,	
@IngresosPrevistos ,
@StockFinal ,
@PedidosPrevistos ,
@OPPrevista, 
@PlanMaestro, 

@idArticuloProducido,
@idArticuloMaterial ,

@GrillaSerializada 

)

SELECT @IdProduccionPlan=@@identity
RETURN(@IdProduccionPlan)
