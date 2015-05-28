CREATE Procedure [dbo].[PresupuestoObrasNodos_T]

@IdPresupuestoObrasNodo int

AS 

SELECT *
FROM PresupuestoObrasNodos p
WHERE p.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo