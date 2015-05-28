CREATE PROCEDURE [dbo].[PresupuestosVentas_TXFecha]

@Desde datetime,
@Hasta datetime

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
			 ImporteTotal NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPresupuestoVenta) ON [PRIMARY]

IF LEN(@NombreServidorWeb)>0
   BEGIN
	SET @sql1='Select IdPresupuestoVenta, Numero, IdCliente, Fecha, IdCondicionVenta, IdVendedor, Observaciones, Estado, TipoVenta, TipoOperacion, ImporteTotal 
			From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END
ELSE
   BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT IdPresupuestoVenta, Numero, IdCliente, Fecha, IdCondicionVenta, IdVendedor, Observaciones, Estado, TipoVenta, TipoOperacion, ImporteTotal
	 FROM PresupuestosVentas
	 WHERE PresupuestosVentas.Fecha between @Desde and @hasta 
   END

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111133'
SET @vector_T='03944520454444400'

SELECT 
 #Auxiliar1.IdPresupuestoVenta, 
 #Auxiliar1.Numero as [Numero], 
 #Auxiliar1.IdPresupuestoVenta as [IdAux1],
 #Auxiliar1.Fecha as [Fecha], 
 Case When IsNull(#Auxiliar1.TipoVenta,1)=1 Then 'Normal' Else 'Muestra' End as [Tipo venta],
 Case When IsNull(#Auxiliar1.TipoOperacion,'P')='P' Then 'Presupuesto' Else 'Devolucion' End as [Tipo operacion],
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial as [Cliente], 
 #Auxiliar1.ImporteTotal as [Total],
 Clientes.Cuit as [Cuit], 
 Clientes.Telefono as [Telefono del cliente], 
 Vendedores.Nombre as [Vendedor],
 #Auxiliar1.Observaciones as [Observaciones],
 Case When IsNull(#Auxiliar1.Estado,'')='C' Then 'Cerrado' When IsNull(#Auxiliar1.Estado,'')='P' Then 'Fac.Parcial' When IsNull(#Auxiliar1.Estado,'')='A' Then 'Anulado' Else 'Pendiente' End as [Estado],
 (Select Count(*) From DetallePresupuestosVentas df Where df.IdPresupuestoVenta=#Auxiliar1.IdPresupuestoVenta) as [Cant.Items],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Vendedores ON IsNull(#Auxiliar1.IdVendedor,Clientes.Vendedor1) = Vendedores.IdVendedor
WHERE ((@ConsolidacionDeBDs='NO' and IsNull(#Auxiliar1.TipoVenta,1)=1) or (@ConsolidacionDeBDs='SI' and IsNull(#Auxiliar1.TipoVenta,1)=2)) or @ConsolidacionDeBDs='NO' --Esto ultimo es para ver todos, incluidas las muestras
ORDER BY #Auxiliar1.Fecha, #Auxiliar1.Numero

DROP TABLE #Auxiliar1