CREATE Procedure [dbo].[Clientes_TX_Entregas]

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
			 Cantidad NUMERIC(18,2)
			)
IF @Ambito='T' or @Ambito='R'
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 
		22,
		Det.IdRemito,
		Remitos.FechaRemito,
		Remitos.IdCliente,
		Det.IdArticulo,
		UnidadesEmpaque.IdColor,
		Det.Partida,
		Det.Cantidad
	 FROM DetalleRemitos Det 
	 LEFT OUTER JOIN Remitos ON Remitos.IdRemito=Det.IdRemito
	 LEFT OUTER JOIN UnidadesEmpaque ON UnidadesEmpaque.NumeroUnidad = Det.NumeroCaja
	 WHERE (Remitos.FechaRemito between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Remitos.Anulado,'')<>'SI' 
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
		Det.Cantidad * -1
	 FROM DetalleDevoluciones Det 
	 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=Det.IdDevolucion
	 LEFT OUTER JOIN UnidadesEmpaque ON UnidadesEmpaque.NumeroUnidad = Det.NumeroCaja
	 WHERE (Devoluciones.FechaDevolucion between @FechaDesde and DATEADD(n,1439,@FechaHasta)) and IsNull(Devoluciones.Anulada,'')<>'SI'
    END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0000111111133'
SET @vector_T='00006D122F300'

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
		When Remitos.IdRemito is not null
		 Then 'REM '+
			Substring('0000',1,4-Len(Convert(varchar,IsNull(Remitos.PuntoVenta,0))))+Convert(varchar,IsNull(Remitos.PuntoVenta,0))+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Remitos.NumeroRemito)))+Convert(varchar,Remitos.NumeroRemito)
		Else ''
	End as [Comprobante],
	#Auxiliar1.Cantidad as [Cantidad],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Colores ON Colores.IdColor=#Auxiliar1.IdColor
LEFT OUTER JOIN Clientes ON Clientes.IdCliente=#Auxiliar1.IdCliente
LEFT OUTER JOIN Remitos ON Remitos.IdRemito=#Auxiliar1.IdComprobante and #Auxiliar1.IdTipoComprobante=22
LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=#Auxiliar1.IdComprobante and #Auxiliar1.IdTipoComprobante=5

ORDER BY [K_Articulo], [K_Color], [K_Orden]

DROP TABLE #Auxiliar1