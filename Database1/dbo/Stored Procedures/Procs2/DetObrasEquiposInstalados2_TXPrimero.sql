CREATE PROCEDURE [dbo].[DetObrasEquiposInstalados2_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111133'
SET @vector_T='04999C266500'

SELECT TOP 1 
 DetEI.IdDetalleObraEquipoInstalado2 as [IdDetalleObraEquipoInstalado2],
 Articulos.Codigo as [Codigo],
 DetEI.IdDetalleObraEquipoInstalado2 as [IdAux1],
 DetEI.IdDetalleObraEquipoInstalado as [IdAux2],
 DetEI.IdObra as [IdAux3],
 Articulos.Descripcion as [Linea],
 Articulos.CodigoLoteo as [NAM],
 DetEI.FechaInstalacion as [Fecha instalacion],
 DetEI.FechaDesinstalacion as [Fecha desinstalacion],
 DetEI.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasEquiposInstalados2 DetEI
LEFT OUTER JOIN Articulos ON DetEI.IdArticulo=Articulos.IdArticulo