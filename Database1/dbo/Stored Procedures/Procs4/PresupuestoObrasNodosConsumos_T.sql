
CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_T]

@IdPresupuestoObrasNodoConsumo int

AS 

SELECT *
FROM PresupuestoObrasNodosConsumos
WHERE IdPresupuestoObrasNodoConsumo=@IdPresupuestoObrasNodoConsumo
