CREATE Procedure [dbo].[DetOrdenesCompra_A]

@IdDetalleOrdenCompra int  output,
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
 
INSERT INTO [DetalleOrdenesCompra]
(
 IdOrdenCompra,
 NumeroItem,
 Cantidad,
 IdUnidad,
 IdArticulo,
 Precio,
 Observaciones,
 OrigenDescripcion,
 TipoCancelacion,
 Cumplido,
 FacturacionAutomatica,
 FechaComienzoFacturacion,
 CantidadMesesAFacturar,
 FacturacionCompletaMensual,
 PorcentajeBonificacion,
 IdDetalleObraDestino,
 FechaNecesidad,
 FechaEntrega,
 IdColor,
 IdDioPorCumplido,
 FechaDadoPorCumplido,
 ObservacionesCumplido,
 Estado,
 IdUsuarioCambioEstado,
 FechaCambioEstado
)
VALUES
(
 @IdOrdenCompra,
 @NumeroItem,
 @Cantidad,
 @IdUnidad,
 @IdArticulo,
 @Precio,
 @Observaciones,
 @OrigenDescripcion,
 @TipoCancelacion,
 @Cumplido,
 @FacturacionAutomatica,
 @FechaComienzoFacturacion,
 @CantidadMesesAFacturar,
 @FacturacionCompletaMensual,
 @PorcentajeBonificacion,
 @IdDetalleObraDestino,
 @FechaNecesidad,
 @FechaEntrega,
 @IdColor,
 @IdDioPorCumplido,
 @FechaDadoPorCumplido,
 @ObservacionesCumplido,
 @Estado,
 @IdUsuarioCambioEstado,
 @FechaCambioEstado
)

SELECT @IdDetalleOrdenCompra=@@identity

RETURN(@IdDetalleOrdenCompra)