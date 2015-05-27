
CREATE Procedure [dbo].[PresupuestoObrasRubros_E]
@IdPresupuestoObraRubro int  
AS 
DELETE PresupuestoObrasRubros
WHERE (IdPresupuestoObraRubro=@IdPresupuestoObraRubro)
