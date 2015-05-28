
CREATE PROCEDURE [dbo].[DetPresupuestoObrasGruposMateriales_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01133'
SET @vector_T='06G00'

SELECT TOP 1 
 Det.IdDetallePresupuestoObraGrupoMateriales,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Material],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePresupuestoObrasGruposMateriales Det
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
