CREATE PROCEDURE [dbo].[DetDevoluciones_TXPrimero]

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00000111111666633'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='000003CGF0011E300'
ELSE
	SET @vector_T='000005D990011E300'

SELECT TOP 1
 Det.IdDetalleDevolucion,
 Det.IdDevolucion,
 Det.NumeroDevolucion,
 Det.IdArticulo,
 Det.IdUnidad,
 Articulos.Codigo as [Codigo],
 Case When @SistemaVentasPorTalle='SI' Then Articulos.Descripcion Else Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') End as [Articulo],
 Det.Talle as [Ta],
 Colores.Descripcion as [Color],
 Det.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 Det.Costo,
 Det.PrecioUnitario as [Precio U.],
 Det.Bonificacion as [Bonif.],
 Round((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100)),2) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleDevoluciones Det
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON Det.IdColor = Colores.IdColor