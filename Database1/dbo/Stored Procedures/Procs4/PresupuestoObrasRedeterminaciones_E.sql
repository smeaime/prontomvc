CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_E]

@IdPresupuestoObraRedeterminacion int 

AS 

DELETE PresupuestoObrasRedeterminaciones
WHERE (IdPresupuestoObraRedeterminacion=@IdPresupuestoObraRedeterminacion)