CREATE  Procedure [dbo].[PartesProduccion_M]

@IdParteProduccion int ,
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

UPDATE PartesProduccion
SET
 NumeroParteProduccion=@NumeroParteProduccion,
 FechaParteProduccion=@FechaParteProduccion,
 IdObra=@IdObra,
 IdArticulo=@IdArticulo,
 Cantidad=@Cantidad,
 IdUnidad=@IdUnidad,
 Importe=@Importe,
 IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo,
 Observaciones=@Observaciones,
 IdObraDestino=@IdObraDestino,
 IdPresupuestoObrasNodoMateriales=@IdPresupuestoObrasNodoMateriales,
 IdDetalleSalidaMateriales=@IdDetalleSalidaMateriales
WHERE (IdParteProduccion=@IdParteProduccion)

RETURN(@IdParteProduccion)