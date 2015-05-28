CREATE Procedure [dbo].[DetRequerimientos_M]

@IdDetalleRequerimiento int,
@IdRequerimiento int,
@NumeroItem int,
@Cantidad numeric(12,2),
@IdUnidad int,
@IdArticulo int,
@FechaEntrega datetime,
@Observaciones ntext,
@Cantidad1 numeric(12,2),
@Cantidad2 numeric(12,2),
@IdDetalleLMateriales int,
@IdControlCalidad int,
@Adjunto varchar(2),
@ArchivoAdjunto varchar(50),
@IdCentroCosto int,
@IdComprador int,
@NumeroFacturaCompra1 int,
@FechaFacturaCompra datetime,
@ImporteFacturaCompra numeric(12,2),
@IdProveedor int,
@NumeroFacturaCompra2 int,
@EsBienDeUso varchar(2),
@IdCuenta int,
@Cumplido varchar(2),
@Usuario1 varchar(6),
@FechaIngreso1 datetime,
@ArchivoAdjunto1 varchar(100),
@ArchivoAdjunto2 varchar(100),
@ArchivoAdjunto3 varchar(100),
@ArchivoAdjunto4 varchar(100),
@ArchivoAdjunto5 varchar(100),
@ArchivoAdjunto6 varchar(100),
@ArchivoAdjunto7 varchar(100),
@ArchivoAdjunto8 varchar(100),
@ArchivoAdjunto9 varchar(100),
@ArchivoAdjunto10 varchar(100),
@DescripcionManual varchar(250),
@EnviarEmail tinyint,
@IdRequerimientoOriginal int,
@IdDetalleRequerimientoOriginal int,
@IdOrigenTransmision int,
@IdLlamadoAProveedor int,
@FechaLlamadoAProveedor datetime,
@IdLlamadoRegistradoPor int,
@FechaRegistracionLlamada datetime,
@ObservacionesLlamada ntext,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@IdAproboAlmacen int,
@IdEquipo int,
@FechaEntrega_Tel datetime,
@PRESTOConcepto varchar(13),
@Costo numeric(18,2),
@OrigenDescripcion int,
@TipoDesignacion varchar(3),
@IdLiberoParaCompras int,
@FechaLiberacionParaCompras datetime,
@Recepcionado varchar(2),
@Pagina int,
@Item int,
@Figura int,
@CodigoDistribucion varchar(3),
@IdEquipoDestino int,
@Entregado varchar(2),
@FechaAsignacionComprador datetime,
@MoP varchar(1),
@IdDetalleObraDestino int,
@IdPresupuestoObraRubro int,
@ObservacionesFirmante ntext,
@IdFirmanteObservo int,
@FechaUltimaObservacionFirmante datetime,
@IdPresupuestoObrasNodo int

AS 

SET NOCOUNT ON

DECLARE @Modalidad varchar(2), @TipoDeCompraEnRMHabilitado varchar(2), @TipoDesignacionActual varchar(3), @IdDetallePedido int

SET @TipoDeCompraEnRMHabilitado=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
										Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
										Where pic.Clave='Habilitar tipo de compra en RM'),'')

IF @TipoDeCompraEnRMHabilitado='SI'
  BEGIN
	SET @Modalidad=IsNull((Select Top 1 TiposCompra.Modalidad From Requerimientos
							Left Outer Join TiposCompra On TiposCompra.IdTipoCompra=Requerimientos.IdTipoCompra
							Where Requerimientos.IdRequerimiento=@IdRequerimiento),'CC')
	SET @TipoDesignacionActual=(Select Top 1 TipoDesignacion From DetalleRequerimientos Where IdDetalleRequerimiento=@IdDetalleRequerimiento)
	SET @IdDetallePedido=IsNull((Select Top 1 dp.IdDetallePedido From DetallePedidos dp 
								 Left Outer Join Pedidos On Pedidos.IdPedido = dp.IdPedido
								 Where dp.IdDetalleRequerimiento=@IdDetalleRequerimiento and IsNull(dp.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'),0)

	IF @Modalidad='CR' and @IdDetallePedido=0 and @TipoDesignacionActual is null
		SET @TipoDesignacion='S/D'
	IF @Modalidad='CO' and @IdDetallePedido=0 and isNull(@TipoDesignacionActual,'')='S/D'
		SET @TipoDesignacion=Null
	IF @Modalidad='CN' and @IdDetallePedido=0 and isNull(@TipoDesignacionActual,'')='S/D'
		SET @TipoDesignacion=Null
  END

IF @IdComprador is null
  BEGIN
	DECLARE @AsignarLiberadorComoCompradorEnRM varchar(3), @Aprobo int, @Sector varchar(50)
	SET @AsignarLiberadorComoCompradorEnRM=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='AsignarLiberadorComoCompradorEnRM'),'NO')
	SET @Aprobo=IsNull((Select Top 1 Requerimientos.Aprobo From Requerimientos Where Requerimientos.IdRequerimiento=@IdRequerimiento),0)
	SET @Sector=IsNull((Select Top 1 Sectores.Descripcion From Empleados 
						Left Outer Join Sectores On Sectores.IdSector=Empleados.IdSector
						Where Empleados.IdEmpleado=@Aprobo),'')
	IF @AsignarLiberadorComoCompradorEnRM='SI' and @Aprobo<>0 and Upper(@Sector)='COMPRAS'
	  BEGIN
		SET @IdComprador=@Aprobo
		SET @FechaAsignacionComprador=GetDate()
	  END
  END

SET NOCOUNT OFF

UPDATE [DetalleRequerimientos]
SET 
 IdRequerimiento=@IdRequerimiento,
 NumeroItem=@NumeroItem,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 IdArticulo=@IdArticulo,
 FechaEntrega=@FechaEntrega,
 Observaciones=@Observaciones,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 IdDetalleLMateriales=@IdDetalleLMateriales,
 IdControlCalidad=@IdControlCalidad,
 Adjunto=@Adjunto,
 ArchivoAdjunto=@ArchivoAdjunto,
 IdCentroCosto=@IdCentroCosto,
 IdComprador=@IdComprador,
 NumeroFacturaCompra1=@NumeroFacturaCompra1,
 FechaFacturaCompra=@FechaFacturaCompra,
 ImporteFacturaCompra=@ImporteFacturaCompra,
 IdProveedor=@IdProveedor,
 NumeroFacturaCompra2=@NumeroFacturaCompra2,
 EsBienDeUso=@EsBienDeUso,
 IdCuenta=@IdCuenta,
 Cumplido=@Cumplido,
 Usuario1=@Usuario1,
 FechaIngreso1=@FechaIngreso1,
 ArchivoAdjunto1=@ArchivoAdjunto1,
 ArchivoAdjunto2=@ArchivoAdjunto2,
 ArchivoAdjunto3=@ArchivoAdjunto3,
 ArchivoAdjunto4=@ArchivoAdjunto4,
 ArchivoAdjunto5=@ArchivoAdjunto5,
 ArchivoAdjunto6=@ArchivoAdjunto6,
 ArchivoAdjunto7=@ArchivoAdjunto7,
 ArchivoAdjunto8=@ArchivoAdjunto8,
 ArchivoAdjunto9=@ArchivoAdjunto9,
 ArchivoAdjunto10=@ArchivoAdjunto10,
 DescripcionManual=@DescripcionManual,
 EnviarEmail=@EnviarEmail,
 IdRequerimientoOriginal=@IdRequerimientoOriginal,
 IdDetalleRequerimientoOriginal=@IdDetalleRequerimientoOriginal,
 IdOrigenTransmision=@IdOrigenTransmision,
 IdLlamadoAProveedor=@IdLlamadoAProveedor,
 FechaLlamadoAProveedor=@FechaLlamadoAProveedor,
 IdLlamadoRegistradoPor=@IdLlamadoRegistradoPor,
 FechaRegistracionLlamada=@FechaRegistracionLlamada,
 ObservacionesLlamada=@ObservacionesLlamada,
 IdAutorizoCumplido=@IdAutorizoCumplido,
 IdDioPorCumplido=@IdDioPorCumplido,
 FechaDadoPorCumplido=@FechaDadoPorCumplido,
 ObservacionesCumplido=@ObservacionesCumplido,
 IdAproboAlmacen=@IdAproboAlmacen,
 IdEquipo=@IdEquipo,
 FechaEntrega_Tel=@FechaEntrega_Tel,
 PRESTOConcepto=@PRESTOConcepto,
 Costo=@Costo,
 OrigenDescripcion=@OrigenDescripcion,
 TipoDesignacion=@TipoDesignacion,
 IdLiberoParaCompras=@IdLiberoParaCompras,
 FechaLiberacionParaCompras=@FechaLiberacionParaCompras,
 Recepcionado=@Recepcionado,
 Pagina=@Pagina,
 Item=@Item,
 Figura=@Figura,
 CodigoDistribucion=@CodigoDistribucion,
 IdEquipoDestino=@IdEquipoDestino,
 Entregado=@Entregado,
 FechaAsignacionComprador=@FechaAsignacionComprador,
 MoP=@MoP,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 IdPresupuestoObraRubro=@IdPresupuestoObraRubro,
 ObservacionesFirmante=@ObservacionesFirmante,
 IdFirmanteObservo=@IdFirmanteObservo,
 FechaUltimaObservacionFirmante=@FechaUltimaObservacionFirmante,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo
WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)

RETURN(@IdDetalleRequerimiento)