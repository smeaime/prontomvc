CREATE PROCEDURE [dbo].[Facturas_TXFecha_Contado]

@Desde datetime,
@Hasta datetime,
@IdAbonos varchar(100)

AS

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='00912F11F05554444251267034335100'

SELECT 
 Facturas.IdFactura, 
 Facturas.TipoABC as [A/B/E],
 Facturas.IdFactura as [IdAux], 
 Facturas.PuntoVenta as [Pto.vta.], 
 Facturas.NumeroFactura as [Factura], 
 Depositos.Descripcion as [Sucursal],
 Facturas.Anulada as [Anulada],
 Clientes.CodigoCliente as [Cod.Cli.], 
 Clientes.RazonSocial+IsNull(' ['+Facturas.Cliente COLLATE Modern_Spanish_CI_AS+']','') as [Cliente], 
 DescripcionIva.Descripcion as [Condicion IVA], 
 Clientes.Cuit as [Cuit], 
 Facturas.FechaFactura as [Fecha Factura], 
 Facturas.ImporteTotal-Facturas.ImporteIva1-Facturas.ImporteIva2-Facturas.RetencionIBrutos1-Facturas.RetencionIBrutos2-
		Facturas.RetencionIBrutos3-IsNull(Facturas.IvaNoDiscriminado,0)-IsNull(Facturas.PercepcionIVA,0) as [Neto gravado],
 Facturas.ImporteIva1+IsNull(Facturas.IvaNoDiscriminado,0) as [Iva],
 Facturas.RetencionIBrutos1+Facturas.RetencionIBrutos2+Facturas.RetencionIBrutos3 as [IIBB],
 Facturas.PercepcionIVA as [Perc.IVA],
 Facturas.ImporteTotal as [Total factura],
 Monedas.Abreviatura as [Mon.],
 Clientes.Telefono as [Telefono del cliente], 
 Vendedores.Nombre as [Vendedor],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Facturas.IdUsuarioIngreso) as [Ingreso],
 Facturas.FechaIngreso as [Fecha ingreso],
 Obras.NumeroObra as [Obra (x defecto)],
 Provincias.Nombre as [Provincia destino],
 (Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura) as [Cant.Items],
 (Select Count(*) From DetalleFacturas df Where df.IdFactura=Facturas.IdFactura and Patindex('%'+Convert(varchar,df.IdArticulo)+'%', @IdAbonos)<>0) as [Cant.Abonos],
 'Grupo '+Convert(varchar,
	(Select Top 1 oc.Agrupacion2Facturacion 
		From DetalleFacturasOrdenesCompra dfoc 
		Left Outer Join DetalleOrdenesCompra doc On doc.IdDetalleOrdenCompra=dfoc.IdDetalleOrdenCompra
		Left Outer Join OrdenesCompra oc On oc.IdOrdenCompra=doc.IdOrdenCompra
		Where dfoc.IdFactura=Facturas.IdFactura)) as [Grupo facturacion automatica],
 Facturas.ActivarRecuperoGastos as [Act.Rec.Gtos.],
 Case When IsNull(ContabilizarAFechaVencimiento,'NO')='NO' Then Facturas.FechaFactura Else Facturas.FechaVencimiento End as [Fecha Contab.],
 Substring(Substring('0000',1,4-Len(Convert(varchar,Recibos.PuntoVenta)))+Convert(varchar,Recibos.PuntoVenta)+'-'+
		Substring('0000000000',1,10-Len(Convert(varchar,Recibos.NumeroRecibo)))+Convert(varchar,Recibos.NumeroRecibo),1,20) as [Recibo contado],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Facturas 
LEFT OUTER JOIN Clientes ON Facturas.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN DescripcionIva ON IsNull(Facturas.IdCodigoIva,Clientes.IdCodigoIva) = DescripcionIva.IdCodigoIva 
LEFT OUTER JOIN Vendedores ON Clientes.Vendedor1 = Vendedores.IdVendedor
LEFT OUTER JOIN Monedas ON Facturas.IdMoneda = Monedas.IdMoneda
LEFT OUTER JOIN Obras ON Facturas.IdObra = Obras.IdObra
LEFT OUTER JOIN Provincias ON Facturas.IdProvinciaDestino = Provincias.IdProvincia
LEFT OUTER JOIN Recibos ON Facturas.IdReciboContado = Recibos.IdRecibo
LEFT OUTER JOIN Depositos ON Depositos.IdDeposito = Facturas.IdDeposito
WHERE Facturas.FechaFactura between @Desde and @hasta --and IsNull(FacturaContado,'NO')='SI'
ORDER BY Facturas.FechaFactura,Facturas.NumeroFactura