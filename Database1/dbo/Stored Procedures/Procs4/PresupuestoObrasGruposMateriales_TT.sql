


CREATE  Procedure [dbo].[PresupuestoObrasGruposMateriales_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='03100'

SELECT 
 IdPresupuestoObraGrupoMateriales,
 Codigo as [Codigo],
 Descripcion as [Descripcion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PresupuestoObrasGruposMateriales
ORDER BY PresupuestoObrasGruposMateriales.Descripcion


