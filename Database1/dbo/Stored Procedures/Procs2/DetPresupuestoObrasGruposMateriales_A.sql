
CREATE Procedure [dbo].[DetPresupuestoObrasGruposMateriales_A]

@IdDetallePresupuestoObraGrupoMateriales int  output,
@IdPresupuestoObraGrupoMateriales int,
@IdArticulo int

AS

INSERT INTO [DetallePresupuestoObrasGruposMateriales]
(
 IdPresupuestoObraGrupoMateriales,
 IdArticulo
)
VALUES
(
 @IdPresupuestoObraGrupoMateriales,
 @IdArticulo
)

SELECT @IdDetallePresupuestoObraGrupoMateriales=@@identity
RETURN(@IdDetallePresupuestoObraGrupoMateriales)
