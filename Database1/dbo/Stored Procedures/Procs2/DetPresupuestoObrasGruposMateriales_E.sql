
CREATE Procedure [dbo].[DetPresupuestoObrasGruposMateriales_E]

@IdDetallePresupuestoObraGrupoMateriales int  

AS

DELETE [DetallePresupuestoObrasGruposMateriales]
WHERE (IdDetallePresupuestoObraGrupoMateriales=@IdDetallePresupuestoObraGrupoMateriales)
