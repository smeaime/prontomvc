﻿





























CREATE Procedure [dbo].[DetPresupuestos_M]
@IdDetallePresupuesto int,
@IdPresupuesto int,
@NumeroItem int,
@IdArticulo int,
@Cantidad numeric(12,2),
@IdUnidad int,
@Precio numeric(12,4),
@Adjunto varchar(2),
@ArchivoAdjunto  varchar(50),
@Cantidad1  numeric(18,2),
@Cantidad2  numeric(18,2),
@Observaciones  ntext,
@IdDetalleAcopios int,
@IdDetalleRequerimiento int,
@OrigenDescripcion int,
@IdDetalleLMateriales int,
@IdCuenta int,
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
@FechaEntrega datetime,
@IdCentroCosto int,
@PorcentajeBonificacion numeric(6,2),
@ImporteBonificacion numeric(18,4),
@PorcentajeIVA numeric(6,2),
@ImporteIVA numeric(18,4),
@ImporteTotalItem numeric(18,4)
AS
UPDATE [DetallePresupuestos]
SET 
 IdPresupuesto=@IdPresupuesto,
 NumeroItem=@NumeroItem,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 Precio=@Precio,
 Adjunto=@Adjunto,
 ArchivoAdjunto=@ArchivoAdjunto,
 Cantidad1=@Cantidad1,
 Cantidad2=@Cantidad2,
 Observaciones=@Observaciones,
 IdDetalleAcopios=@IdDetalleAcopios,
 IdDetalleRequerimiento=@IdDetalleRequerimiento,
 OrigenDescripcion=@OrigenDescripcion,
 IdDetalleLMateriales=@IdDetalleLMateriales,
 IdCuenta=@IdCuenta,
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
 FechaEntrega=@FechaEntrega,
 IdCentroCosto=@IdCentroCosto,
 PorcentajeBonificacion=@PorcentajeBonificacion,
 ImporteBonificacion=@ImporteBonificacion,
 PorcentajeIVA=@PorcentajeIVA,
 ImporteIVA=@ImporteIVA,
 ImporteTotalItem=@ImporteTotalItem
WHERE (IdDetallePresupuesto=@IdDetallePresupuesto)
RETURN(@IdDetallePresupuesto)






























