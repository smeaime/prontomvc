


CREATE  Procedure [dbo].[PresupuestoObrasGruposMateriales_TX_ParaCombo]

AS 

SELECT 
 IdPresupuestoObraGrupoMateriales,
 Descripcion+' [ '+Codigo+' ]' as [Titulo]
FROM PresupuestoObrasGruposMateriales
ORDER BY Descripcion


