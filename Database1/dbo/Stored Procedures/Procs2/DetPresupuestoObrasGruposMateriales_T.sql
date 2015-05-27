
CREATE Procedure [dbo].[DetPresupuestoObrasGruposMateriales_T]

@IdDetallePresupuestoObraGrupoMateriales int

AS 

SELECT *
FROM [DetallePresupuestoObrasGruposMateriales]
WHERE (IdDetallePresupuestoObraGrupoMateriales=@IdDetallePresupuestoObraGrupoMateriales)
