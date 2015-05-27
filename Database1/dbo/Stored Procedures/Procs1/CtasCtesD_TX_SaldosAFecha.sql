CREATE Procedure [dbo].[CtasCtesD_TX_SaldosAFecha]

@FechaHasta datetime,
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@Vendedor int,
@Cobrador int,
@IncluirSaldosCero varchar(2)

AS 

SET NOCOUNT ON

DECLARE @IdTipoComprobanteFacturaVenta int, @IdTipoComprobanteDevoluciones int, @IdTipoComprobanteNotaDebito int, @IdTipoComprobanteNotaCredito int,
	@IdTipoComprobanteRecibo int

SET @IdTipoComprobanteFacturaVenta=(Select Top 1 IdTipoComprobanteFacturaVenta From Parametros Where IdParametro=1)
SET @IdTipoComprobanteDevoluciones=(Select Top 1 IdTipoComprobanteDevoluciones From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaDebito=(Select Top 1 IdTipoComprobanteNotaDebito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteNotaCredito=(Select Top 1 IdTipoComprobanteNotaCredito From Parametros Where IdParametro=1)
SET @IdTipoComprobanteRecibo=(Select Top 1 IdTipoComprobanteRecibo From Parametros Where IdParametro=1)

CREATE TABLE #Auxiliar1 
			(
			 IdCliente INTEGER,
			 IdCuenta INTEGER,
			 Codigo VARCHAR(10),
			 Cliente VARCHAR(100),
			 Saldo NUMERIC(18, 2),
			 IdVendedor INTEGER,
			 IdCobrador INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  IsNull(CtaCte.IdCliente,0),
  Clientes.IdCuenta,
  Clientes.Codigo,
  Clientes.RazonSocial,
  Sum(IsNull(CtaCte.ImporteTotal,0)*IsNull(TiposComprobante.Coeficiente,1)),
  Max(IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,IsNull(Recibos.IdVendedor,IsNull(Clientes.Vendedor1,0))))))),
  Max(IsNull(Recibos.IdCobrador,IsNull(Clientes.Cobrador,0)))
 FROM CuentasCorrientesDeudores CtaCte
 LEFT OUTER JOIN Clientes ON Clientes.IdCliente=CtaCte.IdCliente
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Facturas ON Facturas.IdFactura=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteFacturaVenta
 LEFT OUTER JOIN Devoluciones ON Devoluciones.IdDevolucion=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteDevoluciones
 LEFT OUTER JOIN NotasDebito ON NotasDebito.IdNotaDebito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaDebito
 LEFT OUTER JOIN NotasCredito ON NotasCredito.IdNotaCredito=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteNotaCredito
 LEFT OUTER JOIN Recibos ON Recibos.IdRecibo=CtaCte.IdComprobante and CtaCte.IdTipoComp=@IdTipoComprobanteRecibo
 WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or (Clientes.RazonSocial>=@DesdeAlfa and Clientes.RazonSocial<=@HastaAlfa)) and 
	(@Vendedor=-1 or @Vendedor=IsNull(Facturas.IdVendedor,IsNull(Devoluciones.IdVendedor,IsNull(NotasDebito.IdVendedor,IsNull(NotasCredito.IdVendedor,IsNull(Recibos.IdVendedor,IsNull(Clientes.Vendedor1,0))))))) and 
	(@Cobrador=-1 or @Cobrador=IsNull(Recibos.IdCobrador,IsNull(Clientes.Cobrador,0)))  
 GROUP BY CtaCte.IdCliente, Clientes.Codigo, Clientes.RazonSocial, Clientes.IdCuenta

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='00011161111133'
SET @vector_T='00044180500500'

SELECT  
 IsNull(#Auxiliar1.IdCliente,0) as [IdCliente],
 Case When @ActivaRango=-1 Then #Auxiliar1.Codigo Else #Auxiliar1.Cliente End as [A_Clave],
 1 as [A_Orden],
 #Auxiliar1.Codigo as [Cod],
 #Auxiliar1.Cliente as [Cliente],
 Convert(varchar,Cuentas.Codigo)+' '+Cuentas.Descripcion as [Cuenta],
 #Auxiliar1.Saldo as [Saldo],
 Clientes.Direccion + ' ' + IsNull(Localidades.Nombre+' ','') + IsNull('('+Clientes.CodigoPostal+') ','') + 
	Case When IsNull(UPPER(Provincias.Nombre),'')<>'CAPITAL FEDERAL' Then IsNull(Provincias.Nombre+' ','') Else '' End as [Direccion],
 Clientes.Telefono as [Telefono], 
 V4.Nombre as [Cobrador], --IsNull(V2.Nombre,V4.Nombre) as [Cobrador], 
 V3.Nombre as [Vendedor], --IsNull(V1.Nombre,V3.Nombre) as [Vendedor], 
 Clientes.Observaciones as [Observaciones], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar1 
 LEFT OUTER JOIN Clientes ON #Auxiliar1.IdCliente=Clientes.IdCliente
 LEFT OUTER JOIN Localidades ON Clientes.IdLocalidad=Localidades.IdLocalidad
 LEFT OUTER JOIN Provincias ON Clientes.IdProvincia=Provincias.IdProvincia
 LEFT OUTER JOIN Cuentas ON #Auxiliar1.IdCuenta=Cuentas.IdCuenta
 LEFT OUTER JOIN Vendedores V1 ON V1.IdVendedor=#Auxiliar1.IdVendedor
 LEFT OUTER JOIN Vendedores V2 ON V2.IdVendedor=#Auxiliar1.IdCobrador
 LEFT OUTER JOIN Vendedores V3 ON V3.IdVendedor=Clientes.Vendedor1
 LEFT OUTER JOIN Vendedores V4 ON V4.IdVendedor=Clientes.Cobrador
 WHERE @IncluirSaldosCero="SI" or (@IncluirSaldosCero="NO" and #Auxiliar1.Saldo<>0)

UNION ALL

SELECT  
 0 as [IdCliente],
 Null as [A_Clave],
 2 as [A_Orden],
 Null as [Cod],
 Null as [Cliente],
 'TOTAL GENERAL' as [Cuenta],
 Sum(IsNull(#Auxiliar1.Saldo,0)) as [Saldo],
 Null as [Direccion],
 Null as [Telefono], 
 Null as [Cobrador], 
 Null as [Vendedor], 
 Null as [Observaciones], 
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar1 

ORDER BY [A_Orden], [A_Clave]

DROP TABLE #Auxiliar1