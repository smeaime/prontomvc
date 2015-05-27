CREATE Procedure ProduccionPlanes_TT
--@IdArticulo int
AS 
Declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='0101033'
Set @vector_T='050E000'
SELECT distinct
-- ProduccionPlanes.PlanMaestro,
ProduccionPlanes.IdProduccionPlan,
Fecha,
ArtMaterial.Descripcion as Material,
ArtProducido.Descripcion as Elaborado,
'Administrador' as Usuario,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM ProduccionPlanes
LEFT OUTER JOIN Articulos ArtMaterial ON  ArtMaterial.IdArticulo = ProduccionPlanes.IdArticuloMaterial
LEFT OUTER JOIN Articulos ArtProducido ON  ArtProducido.IdArticulo = ProduccionPlanes.IdArticuloProducido
order by IdProduccionPlan


