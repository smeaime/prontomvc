

--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////

CREATE Procedure ProduccionOrdenes_M

@IdProduccionOrden int,
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

UPDATE ProduccionOrdenes
SET
 NumeroOrdenProduccion=@NumeroOrdenProduccion,
 FechaOrdenProduccion=@FechaOrdenProduccion,
 IdObra=@IdObra,
 Observaciones=@Observaciones,
 Aprobo=@Aprobo,

 IdTransportista1=@IdTransportista1,
 Cliente=@Cliente,
 Direccion=@Direccion,
 Localidad=@Localidad,
 CodigoPostal=@CodigoPostal,
 CondicionIva=@CondicionIva,
 Cuit=@Cuit,
 ACargo=@ACargo,
 Emitio=@Emitio,
 ValePreimpreso=@ValePreimpreso,
 Referencia=@Referencia,
 NumeroDocumento=@NumeroDocumento,
 FechaRegistracion=@FechaRegistracion,
 Anulada=@Anulada,
 FechaAnulacion=@FechaAnulacion,
 IdUsuarioAnulo=@IdUsuarioAnulo,
 EnviarEmail=@EnviarEmail,
 IdOrigenTransmision=@IdOrigenTransmision,
 MotivoAnulacion=@MotivoAnulacion,
 NumeroOrdenesProduccion=@NumeroOrdenesProduccion,

 IdDepositoOrigen=@IdDepositoOrigen,
 IdUsuarioIngreso=@IdUsuarioIngreso,
 FechaIngreso=@FechaIngreso,
 IdUsuarioModifico=@IdUsuarioModifico,
 FechaModifico=@FechaModifico,

 ClaveTipoSalida=@ClaveTipoSalida,
 SalidaADepositoEnTransito=@SalidaADepositoEnTransito,
 ValorDeclarado=@ValorDeclarado,
 Bultos=@Bultos,
 IdColor=@IdColor,
 Embalo=@Embalo,
 CircuitoFirmasCompleto=@CircuitoFirmasCompleto,
 IdPuntoVenta=@IdPuntoVenta,
 NumeroRemitoTransporte=@NumeroRemitoTransporte,
 IdEquipo=@IdEquipo,

Codigo=@Codigo,
Descripcion=@Descripcion,
Cantidad=@Cantidad,
IdUnidad=@IdUnidad,

Programada=@Programada,
Confirmado=@Confirmado,
Reserva=@Reserva,
EnEjecucion=@EnEjecucion,

FechaInicioPrevista=@FechaInicioPrevista,
FechaFinalPrevista=@FechaFinalPrevista,
FechaInicioReal=@FechaInicioReal,
FechaFinalReal=@FechaFinalReal,
	
        IdArticuloGenerado=@IdArticuloGenerado ,
        IdStockGenerado=@IdStockGenerado,

	Cerro=@Cerro,

ArchivoAdjunto1=@ArchivoAdjunto1,
ArchivoAdjunto2=@ArchivoAdjunto2,

	
	IdDetalleOrdenCompraImputado1=@IdDetalleOrdenCompraImputado1,
	IdDetalleOrdenCompraImputado2=@IdDetalleOrdenCompraImputado2,
	IdDetalleOrdenCompraImputado3=@IdDetalleOrdenCompraImputado3,
	IdDetalleOrdenCompraImputado4=@IdDetalleOrdenCompraImputado4,
	IdDetalleOrdenCompraImputado5=@IdDetalleOrdenCompraImputado5

WHERE (IdProduccionOrden=@IdProduccionOrden)


RETURN(@IdProduccionOrden)
