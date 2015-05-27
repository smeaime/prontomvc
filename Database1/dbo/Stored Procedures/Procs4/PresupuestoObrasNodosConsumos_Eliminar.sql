CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_Eliminar]

@IdObra int, 
@FechaDesde datetime, 
@FechaHasta datetime

AS

DELETE PresupuestoObrasNodosConsumos
WHERE IsNull(IdObraOrigen,0)=@IdObra and Fecha between @FechaDesde and @FechaHasta