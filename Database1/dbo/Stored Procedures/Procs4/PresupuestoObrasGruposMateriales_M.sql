


CREATE Procedure [dbo].[PresupuestoObrasGruposMateriales_M]

@IdPresupuestoObraGrupoMateriales int,
@Codigo varchar(20),
@Descripcion varchar(256)

AS

UPDATE PresupuestoObrasGruposMateriales
SET 
 Codigo=@Codigo,
 Descripcion=@Descripcion
WHERE (IdPresupuestoObraGrupoMateriales=@IdPresupuestoObraGrupoMateriales)

RETURN(@IdPresupuestoObraGrupoMateriales)


