
CREATE Procedure [dbo].[DetPresupuestoObrasGruposMateriales_M]

@IdDetallePresupuestoObraGrupoMateriales int,
@IdPresupuestoObraGrupoMateriales int,
@IdArticulo int

AS

UPDATE [DetallePresupuestoObrasGruposMateriales]
SET 
 IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales,
 IdArticulo=@IdArticulo
WHERE (IdDetallePresupuestoObraGrupoMateriales=@IdDetallePresupuestoObraGrupoMateriales)

RETURN(@IdDetallePresupuestoObraGrupoMateriales)
