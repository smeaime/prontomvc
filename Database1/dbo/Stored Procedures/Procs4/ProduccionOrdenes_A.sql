--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure ProduccionOrdenes_A

@IdProduccionOrden int  output,
@NumeroOrdenProduccion int,
@FechaOrdenProduccion datetime,
@IdObra int,
@Observaciones ntext,
@Aprobo int,

@IdTransportista1 int,
@Cliente varchar(50),
@Direccion varchar(50),
@Localidad varchar(50),
@CodigoPostal varchar(30),
@CondicionIva varchar(30),
@Cuit varchar(13),
@ACargo varchar(1),

@Emitio int,
@ValePreimpreso int,
@Referencia varchar(50),
@NumeroDocumento varchar(30),
@FechaRegistracion datetime,
@Anulada varchar(2),
@FechaAnulacion datetime,
@IdUsuarioAnulo int,
@EnviarEmail tinyint,
@IdOrigenTransmision int,
@MotivoAnulacion ntext,
@NumeroOrdenesProduccion int,

@IdDepositoOrigen int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,

@ClaveTipoSalida varchar(30),
@SalidaADepositoEnTransito varchar(2),
@ValorDeclarado numeric(18,2),
@Bultos int,
@IdColor int,
@Embalo varchar(50),
@CircuitoFirmasCompleto varchar(2),
@IdPuntoVenta int,
@NumeroRemitoTransporte int,
@IdEquipo int,

@Codigo varchar(20) ,
@Descripcion varchar(50) ,
@Cantidad numeric(18,2),
@IdUnidad int,


	@Programada varchar (2)  ,
	@Confirmado varchar (2) ,
	@Reserva varchar (2) ,
	@EnEjecucion varchar (2) ,

	@FechaInicioPrevista datetime,
	@FechaFinalPrevista datetime,
	@FechaInicioReal datetime,
	@FechaFinalReal datetime,

	
        @IdArticuloGenerado int,
        @IdStockGenerado  int,

	@Cerro int,

	@ArchivoAdjunto1 varchar(100) =NULL,
	@ArchivoAdjunto2 varchar(100) =NULL,
	
	@IdDetalleOrdenCompraImputado1 int =NULL,
	@IdDetalleOrdenCompraImputado2 int =NULL,
	@IdDetalleOrdenCompraImputado3 int =NULL,
	@IdDetalleOrdenCompraImputado4 int =NULL,
	@IdDetalleOrdenCompraImputado5 int =NULL
	
AS 

BEGIN TRAN

DECLARE @NumeroOrdenProduccion1 int


INSERT INTO ProduccionOrdenes
(
 NumeroOrdenProduccion,
 FechaOrdenProduccion,
 IdObra,
 Observaciones,
 Aprobo,

 IdTransportista1,
 Cliente,
 Direccion,
 Localidad,
 CodigoPostal,
 CondicionIva,
 Cuit,
 ACargo,
 Emitio,
 ValePreimpreso,
 Referencia,
 NumeroDocumento,
 FechaRegistracion,
 Anulada,
 FechaAnulacion,
 IdUsuarioAnulo,
 EnviarEmail,
 IdOrigenTransmision,
 MotivoAnulacion,
 NumeroOrdenesProduccion,

 IdDepositoOrigen,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,

 ClaveTipoSalida,
 SalidaADepositoEnTransito,
 ValorDeclarado,
 Bultos, 
 IdColor,
 Embalo,
 CircuitoFirmasCompleto,
 IdPuntoVenta,
 NumeroRemitoTransporte,
 IdEquipo,

Codigo,
Descripcion,
Cantidad,
IdUnidad,

Programada,
Confirmado,
Reserva,
EnEjecucion,

FechaInicioPrevista,
FechaFinalPrevista,
FechaInicioReal,
FechaFinalReal,

	
IdArticuloGenerado,
IdStockGenerado,
Cerro,


ArchivoAdjunto1,
ArchivoAdjunto2,

	IdDetalleOrdenCompraImputado1,
	IdDetalleOrdenCompraImputado2,
	IdDetalleOrdenCompraImputado3,
	IdDetalleOrdenCompraImputado4,
	IdDetalleOrdenCompraImputado5
)
VALUES
(
 @NumeroOrdenProduccion,
 @FechaOrdenProduccion,
 @IdObra,
 @Observaciones,
 @Aprobo,

 @IdTransportista1,
 @Cliente,
 @Direccion,
 @Localidad,
 @CodigoPostal,
 @CondicionIva,
 @Cuit,
 @ACargo,
 @Emitio,
 @ValePreimpreso,
 @Referencia,
 @NumeroDocumento,
 GetDate(),
 @Anulada,
 @FechaAnulacion,
 @IdUsuarioAnulo,
 @EnviarEmail,
 @IdOrigenTransmision,
 @MotivoAnulacion,
 @NumeroOrdenesProduccion,

 @IdDepositoOrigen,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,

 @ClaveTipoSalida,
 @SalidaADepositoEnTransito,
 @ValorDeclarado,
 @Bultos, 
 @IdColor,
 @Embalo,
 @CircuitoFirmasCompleto,
 @IdPuntoVenta,
 @NumeroRemitoTransporte,
 @IdEquipo,

 @Codigo,
 @Descripcion,
 @Cantidad,
 @IdUnidad,

 @Programada,
 @Confirmado,
 @Reserva,
 @EnEjecucion,

 @FechaInicioPrevista,
 @FechaFinalPrevista,
 @FechaInicioReal,
 @FechaFinalReal,
	
        @IdArticuloGenerado,
        @IdStockGenerado,
	@Cerro,

	@ArchivoAdjunto1,
	@ArchivoAdjunto2,

	@IdDetalleOrdenCompraImputado1,
	@IdDetalleOrdenCompraImputado2,
	@IdDetalleOrdenCompraImputado3,
	@IdDetalleOrdenCompraImputado4,
	@IdDetalleOrdenCompraImputado5
)

SELECT @IdProduccionOrden=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdProduccionOrden)
