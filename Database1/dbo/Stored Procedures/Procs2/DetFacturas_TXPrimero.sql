CREATE PROCEDURE [dbo].[DetFacturas_TXPrimero]

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
 DetFac.IdDetalleFactura,
 DetFac.IdFactura,
 DetFac.NumeroFactura,
 DetFac.IdArticulo,
 DetFac.IdUnidad,
 Articulos.Codigo as [Codigo],
 Case When @SistemaVentasPorTalle='SI' Then Articulos.Descripcion Else Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') End as [Articulo],
 DetFac.Talle as [Ta],
 Colores.Descripcion as [Color],
 DetFac.Cantidad as [Cantidad],
 Unidades.Abreviatura as [Unidad],
 DetFac.Costo,
 DetFac.PrecioUnitario as [Precio U.],
 DetFac.Bonificacion as [Bonif.],
 Round((DetFac.Cantidad*DetFac.PrecioUnitario)*(1-(DetFac.Bonificacion/100)),2) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleFacturas DetFac
LEFT OUTER JOIN Articulos ON DetFac.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetFac.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON DetFac.IdColor = Colores.IdColor