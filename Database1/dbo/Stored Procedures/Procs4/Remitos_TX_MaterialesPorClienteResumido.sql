
CREATE PROCEDURE [dbo].[Remitos_TX_MaterialesPorClienteResumido]

@Desde datetime,
@Hasta datetime,
@IdPuntoVenta int,
@IdCliente int,
@Valorizado varchar(2) = Null

AS

SET NOCOUNT ON

SET @Valorizado=IsNull(@Valorizado,'NO')

CREATE TABLE #Auxiliar 
			(
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 IdCliente INTEGER,
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
 SELECT dr.IdArticulo, dr.IdUnidad, Remitos.IdCliente, Isnull(dr.Cantidad,0), IsNull(DetalleOrdenesCompra.Precio,0)
 FROM DetalleRemitos dr
 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=dr.IdRemito
 LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleOrdenesCompra.IdDetalleOrdenCompra=dr.IdDetalleOrdenCompra
 WHERE Remitos.FechaRemito>=@Desde and Remitos.FechaRemito<=@Hasta and 
	IsNull(Remitos.Anulado,'')<>'SI' and 
	(@IdPuntoVenta=-1 or Remitos.IdPuntoVenta=@IdPuntoVenta) and 
	(@IdCliente=-1 or Remitos.IdCliente=@IdCliente)

SET NOCOUNT OFF

DECLARE @Vector_X varchar(30), @Vector_T varchar(30), @Vector_E varchar(500)
SET @Vector_X='0001111111133'
IF @Valorizado='SI'
	SET @Vector_T='000112E023900'
ELSE
	SET @Vector_T='000112E029900'
SET @Vector_E='  |  |  |  |  | CEN,NUM:#COMMA##0.00 | NUM:#COMMA##0.00 '

SELECT 
 0 as [IdAux1],
 Clientes.Codigo as [IdAux2],
 10 as [IdAux3],
 Clientes.Codigo as [Cliente],
 Clientes.RazonSocial as [Razon social],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Descripcion],
 Unidades.Abreviatura as [Unidad],
 Sum(#Auxiliar.Cantidad) as [Cantidad],
 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
GROUP BY Clientes.Codigo, Clientes.RazonSocial, Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura

UNION ALL

SELECT 
 0 as [IdAux1],
 Clientes.Codigo as [IdAux2],
 20 as [IdAux3],
 Null as [Cliente],
 'TOTAL CLIENTE' as [Razon social],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Unidad],
 Sum(#Auxiliar.Cantidad) as [Cantidad],
 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
GROUP BY Clientes.Codigo

UNION ALL

SELECT 
 0 as [IdAux1],
 Clientes.Codigo as [IdAux2],
 30 as [IdAux3],
 Null as [Cliente],
 Null as [Razon social],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Unidad],
 Null as [Cantidad],
 Null as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
GROUP BY Clientes.Codigo

UNION ALL

SELECT 
 0 as [IdAux1],
 'zzzzz' as [IdAux2],
 40 as [IdAux3],
 Null as [Cliente],
 'TOTAL GENERAL' as [Razon social],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Unidad],
 Sum(#Auxiliar.Cantidad) as [Cantidad],
 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar

UNION ALL

SELECT 
 0 as [IdAux1],
 'zzzzz' as [IdAux2],
 50 as [IdAux3],
 Null as [Cliente],
 Null as [Razon social],
 Null as [Codigo],
 Null as [Descripcion],
 Null as [Unidad],
 Null as [Cantidad],
 Null as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 0 as [IdAux1],
 'zzzzz' as [IdAux2],
 60 as [IdAux3],
 Null as [Cliente],
 Null as [Razon social],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Descripcion],
 Unidades.Abreviatura as [Unidad],
 Sum(#Auxiliar.Cantidad) as [Cantidad],
 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
GROUP BY Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura

UNION ALL

SELECT 
 0 as [IdAux1],
 'zzzzz' as [IdAux2],
 70 as [IdAux3],
 Null as [Cliente],
 Null as [Razon social],
 Null as [Codigo],
 'TOTAL GENERAL' as [Descripcion],
 Null as [Unidad],
 Sum(#Auxiliar.Cantidad) as [Cantidad],
 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar

ORDER BY [IdAux2], [IdAux3], [Codigo], [Unidad]

DROP TABLE #Auxiliar
