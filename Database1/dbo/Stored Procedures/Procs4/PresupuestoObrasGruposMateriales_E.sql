


CREATE Procedure [dbo].[PresupuestoObrasGruposMateriales_E]

@IdPresupuestoObraGrupoMateriales int  

AS

DELETE [DetallePresupuestoObrasGruposMateriales]
WHERE (IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales)

DELETE PresupuestoObrasGruposMateriales
WHERE (IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales)


