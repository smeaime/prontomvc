


CREATE Procedure [dbo].[PresupuestoObrasGruposMateriales_TX_PorCodigo]

@Codigo varchar(20),
@IdPresupuestoObraGrupoMateriales int = Null

AS 

SET @IdPresupuestoObraGrupoMateriales=IsNull(@IdPresupuestoObraGrupoMateriales,-1)

SELECT * 
FROM PresupuestoObrasGruposMateriales
WHERE (IdPresupuestoObraGrupoMateriales<=0 or IdPresupuestoObraGrupoMateriales<>@IdPresupuestoObraGrupoMateriales) and Codigo=@Codigo


