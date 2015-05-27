


CREATE Procedure [dbo].[PresupuestoObrasGruposMateriales_A]

@IdPresupuestoObraGrupoMateriales int  output,
@Codigo varchar(20),
@Descripcion varchar(256)

AS 

INSERT INTO PresupuestoObrasGruposMateriales
(
 Codigo,
 Descripcion
)
VALUES
(
 @Codigo,
 @Descripcion
)

SELECT @IdPresupuestoObraGrupoMateriales=@@identity
RETURN(@IdPresupuestoObraGrupoMateriales)


