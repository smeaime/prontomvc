
CREATE Procedure [dbo].[PresupuestoObrasNodosDatos_E]

@IdPresupuestoObrasNodoDatos int  

AS 

DELETE PresupuestoObrasNodosDatos
WHERE (IdPresupuestoObrasNodoDatos=@IdPresupuestoObrasNodoDatos)
