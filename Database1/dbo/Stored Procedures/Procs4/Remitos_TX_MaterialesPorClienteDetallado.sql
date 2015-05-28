CREATE PROCEDURE [dbo].[Remitos_TX_MaterialesPorClienteDetallado]

@Desde datetime,
@Hasta datetime,
@IdPuntoVenta int,
@IdCliente int,
@Valorizado varchar(2) = Null,
@Formato int = Null

AS

SET NOCOUNT ON

SET @Valorizado=IsNull(@Valorizado,'NO')
SET @Formato=IsNull(@Formato,0)

CREATE TABLE #Auxiliar 
			(
			 IdDetalleRemito INTEGER,
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 IdCliente INTEGER,
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2)
			)
INSERT INTO #Auxiliar 
 SELECT dr.IdDetalleRemito, dr.IdArticulo, dr.IdUnidad, Remitos.IdCliente, Isnull(dr.Cantidad,0), IsNull(DetalleOrdenesCompra.Precio,0)
 FROM DetalleRemitos dr
 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=dr.IdRemito
 LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleOrdenesCompra.IdDetalleOrdenCompra=dr.IdDetalleOrdenCompra
 WHERE Remitos.FechaRemito>=@Desde and Remitos.FechaRemito<=@Hasta and 
	IsNull(Remitos.Anulado,'')<>'SI' and 
	(@IdPuntoVenta=-1 or Remitos.IdPuntoVenta=@IdPuntoVenta) and 
	(@IdCliente=-1 or Remitos.IdCliente=@IdCliente)

SET NOCOUNT OFF

DECLARE @Vector_X varchar(30), @Vector_T varchar(30), @Vector_E varchar(500)
SET @Vector_X='00000011111111111111111133'
IF @Valorizado='SI'
	SET @Vector_T='0000001142E2E1233222222900'
ELSE
	SET @Vector_T='0000001142E2E1299222222900'
SET @Vector_E='  |  |  |  |  |  |  |  | CEN,NUM:#COMMA##0.00 | CUR | CUR |  |  |  |  |  |  '

IF @Formato=0
    BEGIN
	SELECT 
	 #Auxiliar.IdDetalleRemito as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 #Auxiliar.IdArticulo as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 Articulos.Codigo as [IdAux5],
	 10 as [IdAux6],
	 Clientes.Codigo as [Cliente],
	 Clientes.RazonSocial as [Razon social],
	 Remitos.FechaRemito [Fecha],
	 'REMITO' as [Comprobante],
	 Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Numero],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion as [Descripcion],
	 Unidades.Abreviatura as [Unidad],
	 #Auxiliar.Cantidad as [Cantidad],
	 #Auxiliar.Precio as [Precio],
	 #Auxiliar.Cantidad*#Auxiliar.Precio as [Total],
	 Remitos.OrdenCarga as [Orden carga],
	 IsNull(Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra),Remitos.OrdenCompra) as [Orden compra],
	 Remitos.Patente as [Patente],
	 Remitos.Chofer as [Chofer],
	 Remitos.NumeroDocumento as [Documento],
	 Remitos.Observaciones as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleOrdenesCompra.IdDetalleOrdenCompra=DetalleRemitos.IdDetalleOrdenCompra
	LEFT OUTER JOIN OrdenesCompra ON OrdenesCompra.IdOrdenCompra=DetalleOrdenesCompra.IdOrdenCompra
	
	UNION ALL
	
	SELECT 
	 0 as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 #Auxiliar.IdArticulo as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 Articulos.Codigo as [IdAux5],
	 20 as [IdAux6],
	 Null as [Cliente],
	 Null as [Razon social],
	 Null [Fecha],
	 Null as [Comprobante],
	 Null as [Numero],
	 Null as [Codigo],
	 'TOTAL MATERIAL' as [Descripcion],
	 Null as [Unidad],
	 Sum(#Auxiliar.Cantidad) as [Cantidad],
	 Null as [Precio],
	 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
	 Null as [Orden carga],
	 Null as [Orden compra],
	 Null as [Patente],
	 Null as [Chofer],
	 Null as [Documento],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	GROUP BY #Auxiliar.IdCliente, #Auxiliar.IdArticulo, Clientes.Codigo, Articulos.Codigo
	
	UNION ALL
	
	SELECT 
	 0 as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 #Auxiliar.IdArticulo as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 Articulos.Codigo as [IdAux5],
	 30 as [IdAux6],
	 Null as [Cliente],
	 Null as [Razon social],
	 Null [Fecha],
	 Null as [Comprobante],
	 Null as [Numero],
	 Null as [Codigo],
	 Null as [Descripcion],
	 Null as [Unidad],
	 Null as [Cantidad],
	 Null as [Precio],
	 Null as [Total],
	 Null as [Orden carga],
	 Null as [Orden compra],
	 Null as [Patente],
	 Null as [Chofer],
	 Null as [Documento],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	GROUP BY #Auxiliar.IdCliente, #Auxiliar.IdArticulo, Clientes.Codigo, Articulos.Codigo
	
	UNION ALL
	
	SELECT 
	 0 as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 #Auxiliar.IdArticulo as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 'zzzzz' as [IdAux5],
	 40 as [IdAux6],
	 Null as [Cliente],
	 Null as [Razon social],
	 Null [Fecha],
	 Null as [Comprobante],
	 Null as [Numero],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion as [Descripcion],
	 Null as [Unidad],
	 Sum(#Auxiliar.Cantidad) as [Cantidad],
	 Null as [Precio],
	 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
	 Null as [Orden carga],
	 Null as [Orden compra],
	 Null as [Patente],
	 Null as [Chofer],
	 Null as [Documento],
	 Null as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	GROUP BY #Auxiliar.IdCliente, #Auxiliar.IdArticulo, Clientes.Codigo, Articulos.Codigo, Articulos.Descripcion
	
	UNION ALL
	
	SELECT 
	 0 as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 Null as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 'zzzzz' as [IdAux5],
	 50 as [IdAux6],
	 Null as [Cliente],
	 Null as [Razon social],
	 Null [Fecha],
	 Null as [Comprobante],
	 Null as [Numero],
	 Null as [Codigo],
	 '' as [Descripcion],
	 Null as [Unidad],
	 Sum(#Auxiliar.Cantidad) as [Cantidad],
	 Null as [Precio],
	 Sum(#Auxiliar.Cantidad*#Auxiliar.Precio) as [Total],
	 Null as [Orden carga],
	 Null as [Orden compra],
	 Null as [Patente],
	 Null as [Chofer],
	 Null as [Documento],
	 Null as [Observaciones],
	 ' SAL,PST | SUB |  |  |  |  |  |  | CEN,NUM:#COMMA##0.00 | CUR | CUR |  |  |  |  |  |  ' as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	GROUP BY #Auxiliar.IdCliente, Clientes.Codigo
	
	ORDER BY [IdAux4], [IdAux5], [IdAux6], [Comprobante], [Fecha], [Codigo], [Unidad]
    END

IF @Formato=1
    BEGIN
	SELECT 
	 #Auxiliar.IdDetalleRemito as [IdAux1],
	 #Auxiliar.IdCliente as [IdAux2],
	 #Auxiliar.IdArticulo as [IdAux3],
	 Clientes.Codigo as [IdAux4],
	 Articulos.Codigo as [IdAux5],
	 10 as [IdAux6],
	 Clientes.Codigo as [Cliente],
	 Clientes.RazonSocial as [Razon social],
	 Remitos.FechaRemito [Fecha],
	 'REMITO' as [Comprobante],
	 Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Numero],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion as [Descripcion],
	 Unidades.Abreviatura as [Unidad],
	 #Auxiliar.Cantidad as [Cantidad],
	 #Auxiliar.Precio as [Precio],
	 #Auxiliar.Cantidad*#Auxiliar.Precio as [Total],
	 Remitos.OrdenCarga as [Orden carga],
	 IsNull(Substring('00000000',1,8-Len(Convert(varchar,OrdenesCompra.NumeroOrdenCompra)))+Convert(varchar,OrdenesCompra.NumeroOrdenCompra),Remitos.OrdenCompra) as [Orden compra],
	 Remitos.Patente as [Patente],
	 Remitos.Chofer as [Chofer],
	 Remitos.NumeroDocumento as [Documento],
	 Remitos.Observaciones as [Observaciones],
	 @Vector_E as Vector_E,
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar
	LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=#Auxiliar.IdDetalleRemito
	LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar.IdArticulo
	LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar.IdUnidad
	LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar.IdCliente
	LEFT OUTER JOIN DetalleOrdenesCompra ON DetalleOrdenesCompra.IdDetalleOrdenCompra=DetalleRemitos.IdDetalleOrdenCompra
	LEFT OUTER JOIN OrdenesCompra ON OrdenesCompra.IdOrdenCompra=DetalleOrdenesCompra.IdOrdenCompra
	ORDER BY [IdAux4], [IdAux5], [IdAux6], [Comprobante], [Fecha], [Codigo], [Unidad]
    END

DROP TABLE #Auxiliar