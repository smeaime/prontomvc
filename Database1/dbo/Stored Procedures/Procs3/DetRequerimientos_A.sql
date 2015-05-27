CREATE Procedure [dbo].[DetRequerimientos_A]

@IdDetalleRequerimiento int  output,
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

DECLARE @Modalidad varchar(2), @TipoDeCompraEnRMHabilitado varchar(2)

IF IsNull((Select Top 1 P.ActivarSolicitudMateriales From Parametros P Where P.IdParametro=1),'NO')='SI' 
	SET @TipoDesignacion='S/D'

SET @TipoDeCompraEnRMHabilitado=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Habilitar tipo de compra en RM'),'')

IF @TipoDeCompraEnRMHabilitado='SI'
  BEGIN
	SET @Modalidad=IsNull((Select Top 1 TiposCompra.Modalidad From Requerimientos
				Left Outer Join TiposCompra On TiposCompra.IdTipoCompra=Requerimientos.IdTipoCompra
				Where Requerimientos.IdRequerimiento=@IdRequerimiento),'CC')
	IF @Modalidad='CR'
		SET @TipoDesignacion='S/D'
	IF @Modalidad='CO'
		SET @TipoDesignacion=Null
	IF @Modalidad='CN'
		SET @TipoDesignacion=Null
  END

IF @IdComprador is null
  BEGIN
	DECLARE @AsignarLiberadorComoCompradorEnRM varchar(3), @Aprobo int, @Sector varchar(50)
	SET @AsignarLiberadorComoCompradorEnRM=IsNull((Select Top 1 Valor From Parametros2 Where Campo='AsignarLiberadorComoCompradorEnRM'),'NO')
	SET @Aprobo=IsNull((Select Top 1 Aprobo From Requerimientos Where IdRequerimiento=@IdRequerimiento),0)
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

INSERT INTO [DetalleRequerimientos]
(
 IdRequerimiento,
 NumeroItem,
 Cantidad,
 IdUnidad,
 IdArticulo,
 FechaEntrega,
 Observaciones,
 Cantidad1,
 Cantidad2,
 IdDetalleLMateriales,
 IdControlCalidad,
 Adjunto,
 ArchivoAdjunto,
 IdCentroCosto,
 IdComprador,
 NumeroFacturaCompra1,
 FechaFacturaCompra,
 ImporteFacturaCompra,
 IdProveedor,
 NumeroFacturaCompra2,
 EsBienDeUso,
 IdCuenta,
 Cumplido,
 Usuario1,
 FechaIngreso1,
 ArchivoAdjunto1,
 ArchivoAdjunto2,
 ArchivoAdjunto3,
 ArchivoAdjunto4,
 ArchivoAdjunto5,
 ArchivoAdjunto6,
 ArchivoAdjunto7,
 ArchivoAdjunto8,
 ArchivoAdjunto9,
 ArchivoAdjunto10,
 DescripcionManual,
 EnviarEmail,
 IdRequerimientoOriginal,
 IdDetalleRequerimientoOriginal,
 IdOrigenTransmision,
 IdLlamadoAProveedor,
 FechaLlamadoAProveedor,
 IdLlamadoRegistradoPor,
 FechaRegistracionLlamada,
 ObservacionesLlamada,
 IdAutorizoCumplido,
 IdDioPorCumplido,
 FechaDadoPorCumplido,
 ObservacionesCumplido,
 IdAproboAlmacen,
 IdEquipo,
 FechaEntrega_Tel,
 PRESTOConcepto,
 Costo,
 OrigenDescripcion,
 TipoDesignacion,
 IdLiberoParaCompras,
 FechaLiberacionParaCompras,
 Recepcionado,
 Pagina,
 Item,
 Figura,
 CodigoDistribucion,
 IdEquipoDestino,
 Entregado,
 FechaAsignacionComprador,
 MoP,
 IdDetalleObraDestino,
 IdPresupuestoObraRubro,
 ObservacionesFirmante,
 IdFirmanteObservo,
 FechaUltimaObservacionFirmante,
 IdPresupuestoObrasNodo
)
VALUES 
(
 @IdRequerimiento,
 @NumeroItem,
 @Cantidad,
 @IdUnidad,
 @IdArticulo,
 @FechaEntrega,
 @Observaciones,
 @Cantidad1,
 @Cantidad2,
 @IdDetalleLMateriales,
 @IdControlCalidad,
 @Adjunto,
 @ArchivoAdjunto,
 @IdCentroCosto,
 @IdComprador,
 @NumeroFacturaCompra1,
 @FechaFacturaCompra,
 @ImporteFacturaCompra,
 @IdProveedor,
 @NumeroFacturaCompra2,
 @EsBienDeUso,
 @IdCuenta,
 @Cumplido,
 @Usuario1,
 @FechaIngreso1,
 @ArchivoAdjunto1,
 @ArchivoAdjunto2,
 @ArchivoAdjunto3,
 @ArchivoAdjunto4,
 @ArchivoAdjunto5,
 @ArchivoAdjunto6,
 @ArchivoAdjunto7,
 @ArchivoAdjunto8,
 @ArchivoAdjunto9,
 @ArchivoAdjunto10,
 @DescripcionManual,
 @EnviarEmail,
 @IdRequerimientoOriginal,
 @IdDetalleRequerimientoOriginal,
 @IdOrigenTransmision,
 @IdLlamadoAProveedor,
 @FechaLlamadoAProveedor,
 @IdLlamadoRegistradoPor,
 @FechaRegistracionLlamada,
 @ObservacionesLlamada,
 @IdAutorizoCumplido,
 @IdDioPorCumplido,
 @FechaDadoPorCumplido,
 @ObservacionesCumplido,
 @IdAproboAlmacen,
 @IdEquipo,
 @FechaEntrega_Tel,
 @PRESTOConcepto,
 @Costo,
 @OrigenDescripcion,
 @TipoDesignacion,
 @IdLiberoParaCompras,
 @FechaLiberacionParaCompras,
 @Recepcionado,
 @Pagina,
 @Item,
 @Figura,
 @CodigoDistribucion,
 @IdEquipoDestino,
 @Entregado,
 @FechaAsignacionComprador,
 @MoP,
 @IdDetalleObraDestino,
 @IdPresupuestoObraRubro,
 @ObservacionesFirmante,
 @IdFirmanteObservo,
 @FechaUltimaObservacionFirmante,
 @IdPresupuestoObrasNodo
)
SELECT @IdDetalleRequerimiento=@@identity

RETURN(@IdDetalleRequerimiento)