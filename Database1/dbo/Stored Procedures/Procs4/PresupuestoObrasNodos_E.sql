CREATE Procedure [dbo].[PresupuestoObrasNodos_E]

@IdPresupuestoObrasNodo int  

AS 

DELETE PresupuestoObrasNodosPxQxPresupuesto
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)

DELETE PresupuestoObrasNodosConsumos
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)

DELETE PresupuestoObrasNodosPxQxPresupuestoPorDia
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)

DELETE PresupuestoObrasNodos
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)

DELETE PresupuestoObrasNodosDatos
WHERE (IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo)