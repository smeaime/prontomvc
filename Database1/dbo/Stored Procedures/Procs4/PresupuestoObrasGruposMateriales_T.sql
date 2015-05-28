


CREATE Procedure [dbo].[PresupuestoObrasGruposMateriales_T]

@IdPresupuestoObraGrupoMateriales int

AS 

SELECT * 
FROM PresupuestoObrasGruposMateriales
WHERE (IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales)


