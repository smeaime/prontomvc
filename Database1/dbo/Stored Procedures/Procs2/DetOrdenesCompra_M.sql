CREATE Procedure [dbo].[DetOrdenesCompra_M]

@IdDetalleOrdenCompra int,
@IdOrdenCompra int,
@NumeroItem int,
@Cantidad numeric(18,3),
@IdUnidad int,
@IdArticulo int,
@Precio  numeric(19,8),
@Observaciones ntext,
@OrigenDescripcion int,
@TipoCancelacion int,
@Cumplido varchar(2),
@FacturacionAutomatica varchar(2),
@FechaComienzoFacturacion datetime,
@CantidadMesesAFacturar int,
@FacturacionCompletaMensual varchar(2),
@PorcentajeBonificacion numeric(6,2),
@IdDetalleObraDestino int,
@FechaNecesidad datetime,
@FechaEntrega datetime,
@IdColor int,
@IdDioPorCumplido int,
@FechaDadoPorCumplido datetime,
@ObservacionesCumplido ntext,
@Estado varchar(2),
@IdUsuarioCambioEstado int,
@FechaCambioEstado datetime

AS

UPDATE [DetalleOrdenesCompra]
SET 
 IdOrdenCompra=@IdOrdenCompra,
 NumeroItem=@NumeroItem,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 IdArticulo=@IdArticulo,
 Precio=@Precio,
 Observaciones=@Observaciones,
 OrigenDescripcion=@OrigenDescripcion,
 TipoCancelacion=@TipoCancelacion,
 Cumplido=@Cumplido,
 FacturacionAutomatica=@FacturacionAutomatica,
 FechaComienzoFacturacion=@FechaComienzoFacturacion,
 CantidadMesesAFacturar=@CantidadMesesAFacturar,
 FacturacionCompletaMensual=@FacturacionCompletaMensual,
 PorcentajeBonificacion=@PorcentajeBonificacion,
 IdDetalleObraDestino=@IdDetalleObraDestino,
 FechaNecesidad=@FechaNecesidad,
 FechaEntrega=@FechaEntrega,
 IdColor=@IdColor,
 IdDioPorCumplido=@IdDioPorCumplido,
 FechaDadoPorCumplido=@FechaDadoPorCumplido,
 ObservacionesCumplido=@ObservacionesCumplido,
 Estado=@Estado,
 IdUsuarioCambioEstado=@IdUsuarioCambioEstado,
 FechaCambioEstado=@FechaCambioEstado
WHERE (IdDetalleOrdenCompra=@IdDetalleOrdenCompra)

RETURN(@IdDetalleOrdenCompra)