CREATE Procedure [dbo].[PartesProduccion_A]

@IdParteProduccion int  output,
@NumeroParteProduccion int,
@FechaParteProduccion datetime,
@IdObra int,
@IdArticulo int,
@Cantidad numeric(18,2),
@IdUnidad int,
@Importe numeric(18,2),
@IdPresupuestoObrasNodo int,
@Observaciones ntext,
@IdObraDestino int,
@IdPresupuestoObrasNodoMateriales int,
@IdDetalleSalidaMateriales int

AS 

INSERT INTO PartesProduccion
(
 NumeroParteProduccion,
 FechaParteProduccion,
 IdObra,
 IdArticulo,
 Cantidad,
 IdUnidad,
 Importe,
 IdPresupuestoObrasNodo,
 Observaciones,
 IdObraDestino,
 IdPresupuestoObrasNodoMateriales,
 IdDetalleSalidaMateriales
)
VALUES
(
 @NumeroParteProduccion,
 @FechaParteProduccion,
 @IdObra,
 @IdArticulo,
 @Cantidad,
 @IdUnidad,
 @Importe,
 @IdPresupuestoObrasNodo,
 @Observaciones,
 @IdObraDestino,
 @IdPresupuestoObrasNodoMateriales,
 @IdDetalleSalidaMateriales
)

SELECT @IdParteProduccion=@@identity

RETURN(@IdParteProduccion)