﻿
CREATE Procedure [dbo].[wDetRequerimientos_A]

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
@IdComprador int,
@NumeroFacturaCompra1 int,
@FechaFacturaCompra datetime,
@ImporteFacturaCompra numeric(12,2),
@IdProveedor int,
@NumeroFacturaCompra2 int,
@Cumplido varchar(2),
@DescripcionManual varchar(250),
@IdRequerimientoOriginal int,
@IdDetalleRequerimientoOriginal int,
@IdOrigenTransmision int,
@IdAutorizoCumplido int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
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
@IdDetalleObraDestino int

AS

IF IsNull(@IdDetalleRequerimiento,0)<=0
    BEGIN
	INSERT INTO DetalleRequerimientos
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
	 IdComprador,
	 NumeroFacturaCompra1,
	 FechaFacturaCompra,
	 ImporteFacturaCompra,
	 IdProveedor,
	 NumeroFacturaCompra2,
	 Cumplido,
	 DescripcionManual,
	 IdRequerimientoOriginal,
	 IdDetalleRequerimientoOriginal,
	 IdOrigenTransmision,
	 IdAutorizoCumplido,
	 IdDioPorCumplido,
	 FechaDadoPorCumplido,
	 ObservacionesCumplido,
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
	 IdDetalleObraDestino
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
	 @IdComprador,
	 @NumeroFacturaCompra1,
	 @FechaFacturaCompra,
	 @ImporteFacturaCompra,
	 @IdProveedor,
	 @NumeroFacturaCompra2,
	 @Cumplido,
	 @DescripcionManual,
	 @IdRequerimientoOriginal,
	 @IdDetalleRequerimientoOriginal,
	 @IdOrigenTransmision,
	 @IdAutorizoCumplido,
	 @IdDioPorCumplido,
	 @FechaDadoPorCumplido,
	 @ObservacionesCumplido,
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
	 @IdDetalleObraDestino
	)
	
	SELECT @IdDetalleRequerimiento=@@identity
    END
ELSE
    BEGIN
	UPDATE DetalleRequerimientos
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
	 IdComprador=@IdComprador,
	 NumeroFacturaCompra1=@NumeroFacturaCompra1,
	 FechaFacturaCompra=@FechaFacturaCompra,
	 ImporteFacturaCompra=@ImporteFacturaCompra,
	 IdProveedor=@IdProveedor,
	 NumeroFacturaCompra2=@NumeroFacturaCompra2,
	 Cumplido=@Cumplido,
	 DescripcionManual=@DescripcionManual,
	 IdRequerimientoOriginal=@IdRequerimientoOriginal,
	 IdDetalleRequerimientoOriginal=@IdDetalleRequerimientoOriginal,
	 IdOrigenTransmision=@IdOrigenTransmision,
	 IdAutorizoCumplido=@IdAutorizoCumplido,
	 IdDioPorCumplido=@IdDioPorCumplido,
	 FechaDadoPorCumplido=@FechaDadoPorCumplido,
	 ObservacionesCumplido=@ObservacionesCumplido,
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
	 IdDetalleObraDestino=@IdDetalleObraDestino
	WHERE (IdDetalleRequerimiento=@IdDetalleRequerimiento)
    END

IF @@ERROR <> 0
	RETURN -1
ELSE
	RETURN @IdDetalleRequerimiento

