
CREATE Procedure [dbo].[PresupuestoObrasNodosConsumos_E]

@IdPresupuestoObrasNodoConsumo int  

AS 

DELETE PresupuestoObrasNodosConsumos
WHERE (IdPresupuestoObrasNodoConsumo=@IdPresupuestoObrasNodoConsumo)
