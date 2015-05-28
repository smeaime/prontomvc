CREATE PROCEDURE [dbo].[DetPresupuestosVentas_TXDet]

@IdPresupuestoVenta int

AS

SET NOCOUNT ON

DECLARE @SistemaVentasPorTalle varchar(2)

SET @SistemaVentasPorTalle=IsNull((Select Top 1 Valor From Parametros2 Where Campo='SistemaVentasPorTalle'),'')

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0000111111188833'
IF @SistemaVentasPorTalle='SI'
	SET @vector_T='00001DGF0G11G200'
ELSE
	SET @vector_T='00004E990G11G300'

SELECT
 Det.IdDetallePresupuestoVenta,
 Det.IdPresupuestoVenta,
 Det.IdArticulo,
 Det.IdUnidad,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Det.Talle as [Ta],
 Colores.Descripcion as [Color],
 Det.Cantidad as [Cant.],
 Unidades.Abreviatura as [Un.],
 dbo.PresupuestosVentas_FacturadoPorIdDetalle(Det.IdDetallePresupuestoVenta) as [Fact.],
 Det.PrecioUnitario as [Precio U.],
 Det.Bonificacion as [Bon.],
 Round((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100)),2) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetallePresupuestosVentas Det
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON Colores.IdColor = Det.IdColor
WHERE (Det.IdPresupuestoVenta = @IdPresupuestoVenta)