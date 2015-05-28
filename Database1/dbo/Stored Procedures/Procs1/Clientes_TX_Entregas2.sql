CREATE Procedure [dbo].[Clientes_TX_Entregas2]

@FechaDesde datetime,
@FechaHasta datetime,
@Ambito varchar(1)

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 Fecha DATETIME,
			 IdCliente INTEGER,
			 IdArticulo INTEGER,
			 IdColor INTEGER,
			 Partida VARCHAR(20),
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2),
			 IdRemito INTEGER
			)
IF @Ambito='T' or @Ambito='R'
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
		1,
		Det.IdFactura,
		Facturas.FechaFactura,
		Facturas.IdCliente,
		Det.IdArticulo,
		UnidadesEmpaque.IdColor,
		DetalleRemitos.Partida,
		Det.Cantidad,
		Det.PrecioUnitario,
		DetalleRemitos.IdRemito
	 FROM DetalleFacturas Det 
	 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=Det.IdFactura
	 LEFT OUTER JOIN DetalleFacturasRemitos ON DetalleFacturasRemitos.IdDetalleFactura=Det.IdDetalleFactura
	 LEFT OUTER JOIN DetalleRemitos ON DetalleRemitos.IdDetalleRemito=DetalleFacturasRemitos.IdDetalleRemito
	 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=DetalleRemitos.IdRemito
	 LEFT OUTER JOIN UnidadesEmpaque ON UnidadesEmpaque.NumeroUnidad = DetalleRemitos.NumeroCaja
	 WHERE (Facturas.FechaFactura between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Facturas.Anulada,'')<>'SI' 
    END

IF @Ambito='T' or @Ambito='D'
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
		5,
		Det.IdDevolucion,
		Devoluciones.FechaDevolucion,
		Devoluciones.IdCliente,
		Det.IdArticulo,
		UnidadesEmpaque.IdColor,
		Det.Partida,
		Det.Cantidad * -1,
		Det.PrecioUnitario,
		Null
	 FROM DetalleDevoluciones Det 
	 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Det.IdDevolucion
	 LEFT OUTER JOIN UnidadesEmpaque ON UnidadesEmpaque.NumeroUnidad = Det.NumeroCaja
	 WHERE (Devoluciones.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Devoluciones.Anulada,'')<>'SI'
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111111111111133'
SET @vector_T='00006D122F341224F00'

SELECT 
	0 as [IdComprobante],
	Articulos.Descripcion as [K_Articulo],
	Colores.Descripcion as [K_Color],
	0 as [K_Orden],
	Articulos.Codigo as [Codigo],
	Articulos.Descripcion as [Articulo],
	Colores.Descripcion as [Color],
	#Auxiliar1.Partida as [Partida],
	Clientes.RazonSocial as [Cliente],
	Case When Devoluciones.IdDevolucion is not null
		 Then 'DEV '+Devoluciones.TipoABC+'-'+
			Substring('0000',1,4-Len(Convert(varchar,Devoluciones.PuntoVenta)))+Convert(varchar,Devoluciones.PuntoVenta)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Devoluciones.NumeroDevolucion)))+Convert(varchar,Devoluciones.NumeroDevolucion)
		When Facturas.IdFactura is not null
		 Then 'FAC '+Facturas.TipoABC+' '+
			Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura)
		Else ''
	End as [Comprobante],
	#Auxiliar1.Cantidad as [Cantidad],
	#Auxiliar1.Precio as [Precio],
	Monedas.Abreviatura as [Mon.],
	ListasPrecios.NumeroLista as [Lista],
	IsNull(Facturas.CotizacionMoneda,Devoluciones.CotizacionMoneda) as [Cotizacion],
	#Auxiliar1.Fecha as [Fecha],
	'REM '+Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito) as [Remito],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Colores ON Colores.IdColor=#Auxiliar1.IdColor
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar1.IdCliente
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=#Auxiliar1.IdComprobante and #Auxiliar1.IdTipoComprobante=1
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=#Auxiliar1.IdComprobante and #Auxiliar1.IdTipoComprobante=5
LEFT OUTER JOIN ListasPrecios ON ListasPrecios.IdListaPrecios=IsNull(Facturas.IdListaPrecios,Devoluciones.IdListaPrecios)
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=IsNull(Facturas.IdMoneda,Devoluciones.IdMoneda)
LEFT OUTER JOIN Remitos ON Remitos.IdRemito=#Auxiliar1.IdRemito
ORDER BY [K_Articulo], [K_Color], [K_Orden]

DROP TABLE #Auxiliar1