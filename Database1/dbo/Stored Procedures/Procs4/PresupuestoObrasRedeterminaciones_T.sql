CREATE Procedure [dbo].[PresupuestoObrasRedeterminaciones_T]

@IdPresupuestoObraRedeterminacion int

AS 

SELECT *
FROM PresupuestoObrasRedeterminaciones
WHERE (IdPresupuestoObraRedeterminacion=@IdPresupuestoObraRedeterminacion)