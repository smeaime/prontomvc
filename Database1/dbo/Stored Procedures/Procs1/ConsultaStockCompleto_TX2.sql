CREATE Procedure [dbo].[ConsultaStockCompleto_TX2]

@IdDeposito int = Null

AS

SET @IdDeposito=IsNull(@IdDeposito,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30),@Clave varchar(3)
SET @vector_X='0111111111666666661133'
SET @vector_T='093D209222444445452300'
SET @Clave='SCR'

SET NOCOUNT ON

EXEC Stock_CalcularEquivalencias

SET NOCOUNT OFF

SELECT 
 Stk.IdArticulo as [IdArticulo],
 @Clave as [Stock],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 SUM(Stk.CantidadUnidades) as [Cantidad],
 U1.Abreviatura as [En :],
 Stk.IdArticulo as [IdAux],
 U2.Abreviatura as [Equiv. a],
 Stk.Equivalencia as [Equiv.],
 SUM(Stk.CantidadEquivalencia) as [Cant.Equiv.],
 Max(IsNull(Articulos.CostoPPP,0)) as [Costo PPP $],
 SUM(Stk.CantidadEquivalencia)*Max(IsNull(Articulos.CostoPPP,0)) as [Stock val. $],
 Max(IsNull(Articulos.CostoPPPDolar,0)) as [Costo PPP u$s],
 SUM(Stk.CantidadEquivalencia)*Max(IsNull(Articulos.CostoPPPDolar,0)) as [Stock val. u$s],
 Max(IsNull(Articulos.CostoReposicion,0)) as [Costo Rep. $],
 SUM(Stk.CantidadEquivalencia)*Max(IsNull(Articulos.CostoReposicion,0)) as [Stock val. rep. $],
 Max(IsNull(Articulos.CostoReposicionDolar,0)) as [Costo Rep u$s.],
 SUM(Stk.CantidadEquivalencia)*Max(IsNull(Articulos.CostoReposicionDolar,0)) as [Stock val. rep. u$s],
 Rubros.Descripcion as [Rubro],
 Max(IsNull(Articulos.StockMinimo,0)) as [Stock Min.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Stock Stk
LEFT OUTER JOIN Articulos ON Stk.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades U1 ON Stk.IdUnidad = U1.IdUnidad
LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN Ubicaciones ON Stk.IdUbicacion = Ubicaciones.IdUbicacion
LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
WHERE NOT Stk.CantidadUnidades=0 and (@IdDeposito=-1 or Ubicaciones.IdDeposito=@IdDeposito) and 
	IsNull(Articulos.Activo,'SI')='SI' and IsNull(Articulos.RegistrarStock,'SI')='SI'
GROUP by Stk.IdArticulo, Articulos.Codigo, Articulos.Descripcion, U1.Abreviatura, U2.Abreviatura, Rubros.Descripcion, Stk.Equivalencia