
CREATE Procedure [dbo].[PresupuestoObrasRubros_T]
@IdPresupuestoObraRubro int
AS 
SELECT *
FROM PresupuestoObrasRubros
WHERE (IdPresupuestoObraRubro=@IdPresupuestoObraRubro)
