CREATE Procedure [dbo].[Clientes_TX_Comprobantes_Modelo3]

@Desde datetime,
@Hasta datetime,
@TipoConsulta varchar(1) = Null

AS 

SET NOCOUNT ON

SET @TipoConsulta=IsNull(@TipoConsulta,'D')

DECLARE @ConsolidacionDeBDs VARCHAR(2), @NombreServidorWeb VARCHAR(100), @UsuarioServidorWeb VARCHAR(50), @PasswordServidorWeb VARCHAR(50), @BaseDeDatosServidorWeb VARCHAR(50), 
	@proc_name varchar(1000), @vector_X varchar(30), @vector_T varchar(30)

SET @vector_X='011111111111111111111133'
IF @TipoConsulta='D'
	SET @vector_T='00173400403D310555000000'
ELSE
	SET @vector_T='00173400403D999555000000'

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar10
			(
			 IdAux INTEGER,
			 Sucursal VARCHAR(50),
			 TipoComprobante VARCHAR(5),
			 Comprobante VARCHAR(16),
			 Numero INTEGER,
			 Fecha DATETIME,
			 Mes INTEGER,
			 Año INTEGER,
			 CodigoCliente INTEGER,
			 Cliente VARCHAR(100),
			 CodigoArticulo VARCHAR(20),
			 Articulo VARCHAR(300),
			 CodigoColor VARCHAR(5),
			 Color VARCHAR(50),
			 Talle VARCHAR(2),
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2),
			 Total NUMERIC(18,2),
			 Marca VARCHAR(50),
			 Rubro VARCHAR(50),
			 Subrubro VARCHAR(50),
			 Origen VARCHAR(1),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

CREATE TABLE #Auxiliar11
			(
			 IdAux INTEGER,
			 Sucursal VARCHAR(50),
			 TipoComprobante VARCHAR(5),
			 Comprobante VARCHAR(16),
			 Numero INTEGER,
			 Fecha DATETIME,
			 Mes INTEGER,
			 Año INTEGER,
			 CodigoCliente INTEGER,
			 Cliente VARCHAR(100),
			 CodigoArticulo VARCHAR(20),
			 Articulo VARCHAR(300),
			 CodigoColor VARCHAR(5),
			 Color VARCHAR(50),
			 Talle VARCHAR(2),
			 Cantidad NUMERIC(18,2),
			 Precio NUMERIC(18,2),
			 Total NUMERIC(18,2),
			 Marca VARCHAR(50),
			 Rubro VARCHAR(50),
			 Subrubro VARCHAR(50),
			 Origen VARCHAR(1),
			 Vector_T VARCHAR(100),
			 Vector_X VARCHAR(100)
			)

IF Len(@NombreServidorWeb)>0
  BEGIN
	EXEC sp_addlinkedserver @NombreServidorWeb
	SET @proc_name=@NombreServidorWeb+'.'+@BaseDeDatosServidorWeb+'.dbo.Clientes_TX_Comprobantes_Modelo3'
	INSERT INTO #Auxiliar10 
		EXECUTE @proc_name @Desde, @Hasta, @TipoConsulta
	EXEC sp_dropserver @NombreServidorWeb
--EXEC sp_dropserver 'serversql1'
	UPDATE #Auxiliar10 SET Origen='1'
  END

INSERT INTO #Auxiliar10
 SELECT 
  1,
  Depositos.Descripcion,
  'FA',
  f.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,f.PuntoVenta)))+Convert(varchar,f.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,f.NumeroFactura)))+Convert(varchar,f.NumeroFactura),
  f.NumeroFactura,
  f.FechaFactura,
  Month(f.FechaFactura),
  Year(f.FechaFactura),
  Clientes.CodigoCliente, 
  Clientes.RazonSocial+IsNull(' ['+f.Cliente COLLATE Modern_Spanish_CI_AS+']',''), 
  Articulos.Codigo,
  Articulos.Descripcion,
  Case When @TipoConsulta='D' Then Colores.Codigo2 Else '' End,
  Case When @TipoConsulta='D' Then Colores.Descripcion Else '' End,
  Case When @TipoConsulta='D' Then df.Talle Else '' End,
  df.Cantidad,
  Case When f.TipoABC='B' and IsNull(f.IdCodigoIva,Clientes.IdCodigoIva)<>8 and f.PorcentajeIva1<>0
	Then (df.PrecioUnitario*(1-(df.Bonificacion/100))) * (1-(f.PorcentajeBonificacion/100)) / (1+(f.PorcentajeIva1/100)) * f.CotizacionMoneda
	Else (df.PrecioUnitario*(1-(df.Bonificacion/100))) * (1-(f.PorcentajeBonificacion/100)) * f.CotizacionMoneda
  End,
  Case When f.TipoABC='B' and IsNull(f.IdCodigoIva,Clientes.IdCodigoIva)<>8 and f.PorcentajeIva1<>0
	Then ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * (1-(f.PorcentajeBonificacion/100)) / (1+(f.PorcentajeIva1/100)) * f.CotizacionMoneda
	Else ((df.Cantidad*df.PrecioUnitario)*(1-(df.Bonificacion/100))) * (1-(f.PorcentajeBonificacion/100)) * f.CotizacionMoneda
  End,
  Marcas.Descripcion,
  Rubros.Descripcion,
  Subrubros.Descripcion,
  '0',
  @Vector_T as [Vector_T],
  @Vector_X as [Vector_X]
 FROM DetalleFacturas df
 LEFT OUTER JOIN Facturas f ON f.IdFactura = df.IdFactura
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente = f.IdCliente
 LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = f.IdDeposito
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = df.IdArticulo
 LEFT OUTER JOIN Colores ON Colores.IdColor = df.IdColor
 LEFT OUTER JOIN Marcas ON Marcas.IdMarca = Articulos.IdMarca
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro = Articulos.IdRubro
 LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = Articulos.IdSubrubro
 WHERE (f.FechaFactura between @Desde and DATEADD(n,1439,@hasta)) and IsNull(f.Anulada,'')<>'SI'


INSERT INTO #Auxiliar10
 SELECT 
  1,
  Depositos.Descripcion,
  'CD',
  d.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,d.PuntoVenta)))+Convert(varchar,d.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,d.NumeroDevolucion)))+Convert(varchar,d.NumeroDevolucion),
  d.NumeroDevolucion,
  d.FechaDevolucion,
  Month(d.FechaDevolucion),
  Year(d.FechaDevolucion),
  Clientes.CodigoCliente, 
  Clientes.RazonSocial, 
  Articulos.Codigo,
  Articulos.Descripcion,
  Case When @TipoConsulta='D' Then Colores.Codigo2 Else '' End,
  Case When @TipoConsulta='D' Then Colores.Descripcion Else '' End,
  Case When @TipoConsulta='D' Then dv.Talle Else '' End,
  dv.Cantidad * -1,
  Case When d.TipoABC='B' and IsNull(d.IdCodigoIva,Clientes.IdCodigoIva)<>8 and d.PorcentajeIva1<>0
	Then (dv.PrecioUnitario*(1-(dv.Bonificacion/100))) * (1-(d.PorcentajeBonificacion/100)) / (1+(d.PorcentajeIva1/100)) * d.CotizacionMoneda
	Else (dv.PrecioUnitario*(1-(dv.Bonificacion/100))) * (1-(d.PorcentajeBonificacion/100)) * d.CotizacionMoneda
  End * -1,
  Case When d.TipoABC='B' and IsNull(d.IdCodigoIva,Clientes.IdCodigoIva)<>8 and d.PorcentajeIva1<>0
	Then ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * (1-(d.PorcentajeBonificacion/100)) / (1+(d.PorcentajeIva1/100)) * d.CotizacionMoneda
	Else ((dv.Cantidad*dv.PrecioUnitario)*(1-(dv.Bonificacion/100))) * (1-(d.PorcentajeBonificacion/100)) * d.CotizacionMoneda
  End * -1,
  Marcas.Descripcion,
  Rubros.Descripcion,
  Subrubros.Descripcion,
  '0',
  @Vector_T as [Vector_T],
  @Vector_X as [Vector_X]
 FROM DetalleDevoluciones dv
 LEFT OUTER JOIN Devoluciones d ON d.IdDevolucion = dv.IdDevolucion
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente = d.IdCliente
 LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = d.IdDeposito
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = dv.IdArticulo
 LEFT OUTER JOIN Colores ON Colores.IdColor = dv.IdColor
 LEFT OUTER JOIN Marcas ON Marcas.IdMarca = Articulos.IdMarca
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro = Articulos.IdRubro
 LEFT OUTER JOIN Subrubros ON Subrubros.IdSubrubro = Articulos.IdSubrubro
 WHERE (d.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and IsNull(d.Anulada,'')<>'SI'

INSERT INTO #Auxiliar11 
 SELECT IdAux, Sucursal, TipoComprobante, Comprobante, Numero, Fecha, Mes, Año, CodigoCliente, Cliente, CodigoArticulo, Articulo, CodigoColor, Color, Talle, 
		Sum(IsNull(Cantidad,0)), Max(Precio), Sum(IsNull(Total,0)), Marca, Rubro, Subrubro, Origen, Vector_T, Vector_X
 FROM #Auxiliar10
 GROUP BY IdAux, Sucursal, TipoComprobante, Comprobante, Numero, Fecha, Mes, Año, CodigoCliente, Cliente, CodigoArticulo, Articulo, CodigoColor, Color, Talle, Marca, Rubro, Subrubro, Origen, Vector_T, Vector_X

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar11
ORDER BY Fecha, Comprobante, Articulo, Color, Talle

DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11