CREATE PROCEDURE [dbo].[DetObrasEquiposInstalados_TXPrimero]

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111133'
SET @vector_T='04C02255500'

SELECT TOP 1 
 DetEI.IdDetalleObraEquipoInstalado,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Equipo],
 DetEI.Cantidad as [Cant.],
 (Select Top 1 Codigo From Articulos Where Articulos.IdArticulo=0) as [Subequipo 1],
 (Select Top 1 Codigo From Articulos Where Articulos.IdArticulo=0) as [Subequipo 2],
 DetEI.FechaInstalacion as [Fecha Inst.],
 DetEI.FechaDesinstalacion as [Fecha Desinst.],
 DetEI.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasEquiposInstalados DetEI
LEFT OUTER JOIN Articulos ON DetEI.IdArticulo=Articulos.IdArticulo