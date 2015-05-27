CREATE Procedure [dbo].[PresupuestoObrasNodos_EliminarNodosSinPadre]

AS

DELETE PresupuestoObrasNodos
WHERE PresupuestoObrasNodos.IdNodoPadre is not null and 
	Not exists(Select Top 1 p.IdPresupuestoObrasNodo From PresupuestoObrasNodos p Where p.IdPresupuestoObrasNodo=PresupuestoObrasNodos.IdNodoPadre)
