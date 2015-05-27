CREATE Procedure [dbo].[PresupuestosVentas_TX_DetallesPorIdPresupuestoVenta]

@IdPresupuestoVenta int

AS 

SET NOCOUNT ON
SET ANSI_WARNINGS ON
SET ANSI_NULLS ON

DECLARE @ConsolidacionDeBDs varchar(2), @NombreServidorWeb varchar(100), @UsuarioServidorWeb varchar(50), @PasswordServidorWeb varchar(50), @BaseDeDatosServidorWeb varchar(50), @sql1 nvarchar(4000)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')

CREATE TABLE #Auxiliar1	
			(
			 IdDetallePresupuestoVenta INTEGER,
			 IdPresupuestoVenta INTEGER,
			 Numero INTEGER,
			 IdCliente INTEGER,
			 Fecha DATETIME,
			 IdCondicionVenta INTEGER,
			 IdVendedor INTEGER,
			 Observaciones NTEXT,
			 Estado VARCHAR(1),
			 TipoVenta INTEGER,
			 TipoOperacion VARCHAR(1),
			 IdArticulo INTEGER,
			 Cantidad NUMERIC(18,2),
			 PrecioUnitario NUMERIC(18,2),
			 Bonificacion NUMERIC(18,2),
			 IdUnidad INTEGER,
			 Talle VARCHAR(2),
			 IdColor INTEGER,
			 EstadoItem VARCHAR(1),
			 PorcentajeBonificacion NUMERIC(18,2),
			 IdDetalleClienteLugarEntrega INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetallePresupuestoVenta) ON [PRIMARY]

IF LEN(@NombreServidorWeb)>0
  BEGIN
	SET @sql1='Select dpv.IdDetallePresupuestoVenta, dpv.IdPresupuestoVenta, pv.Numero, pv.IdCliente, pv.Fecha, pv.IdCondicionVenta, pv.IdVendedor, pv.Observaciones, pv.Estado, pv.TipoVenta, pv.TipoOperacion, 
				dpv.IdArticulo, dpv.Cantidad, dpv.PrecioUnitario, dpv.Bonificacion, dpv.IdUnidad, dpv.Talle, dpv.IdColor, dpv.Estado, pv.PorcentajeBonificacion, pv.IdDetalleClienteLugarEntrega
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetallePresupuestosVentas dpv 
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas pv On pv.IdPresupuestoVenta=dpv.IdPresupuestoVenta 
				Where dpv.IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta)
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT dpv.IdDetallePresupuestoVenta, dpv.IdPresupuestoVenta, pv.Numero, pv.IdCliente, pv.Fecha, pv.IdCondicionVenta, pv.IdVendedor, pv.Observaciones, pv.Estado, pv.TipoVenta, pv.TipoOperacion, 
			dpv.IdArticulo, dpv.Cantidad, dpv.PrecioUnitario, dpv.Bonificacion, dpv.IdUnidad, dpv.Talle, dpv.IdColor, dpv.Estado, pv.PorcentajeBonificacion, pv.IdDetalleClienteLugarEntrega
	 FROM DetallePresupuestosVentas dpv 
	 LEFT OUTER JOIN PresupuestosVentas pv ON pv.IdPresupuestoVenta=dpv.IdPresupuestoVenta 
	 Where dpv.IdPresupuestoVenta=@IdPresupuestoVenta
  END

SET NOCOUNT OFF

SELECT #Auxiliar1.*, 
		Articulos.Codigo, Articulos.Descripcion as [Articulo], Articulos.AlicuotaIVA, Articulos.CostoPPP, Colores.Descripcion as [Color], Unidades.Abreviatura as [Unidad], 
		dbo.PresupuestosVentas_FacturadoPorIdDetalle(#Auxiliar1.IdDetallePresupuestoVenta) as [Facturado]
FROM #Auxiliar1 
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=#Auxiliar1.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar1.IdUnidad
LEFT OUTER JOIN Colores ON Colores.IdColor=#Auxiliar1.IdColor

DROP TABLE #Auxiliar1