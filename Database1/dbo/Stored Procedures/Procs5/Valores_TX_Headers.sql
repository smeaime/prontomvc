





























CREATE  Procedure [dbo].[Valores_TX_Headers]
AS 
SELECT TOP 1
Valores.IdValor,
(Select top 1 TiposComprobante.DescripcionAb
 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
Valores.NumeroInterno as [Nro.Int.],
Valores.NumeroValor as [Numero],
Valores.FechaValor as [Fecha Vto.],
Valores.Importe as [Importe],
(Select top 1 Bancos.Nombre
 from Bancos Where Valores.IdBanco=Bancos.IdBanco) as [Banco origen],
Valores.Estado as [Estado],
(Select top 1 TiposComprobante.DescripcionAb
 from TiposComprobante Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
Valores.NumeroComprobante as [Nro.Comp.],
Valores.FechaComprobante as [Fec.Comp.],
Clientes.RazonSocial as [Cliente],
(Select top 1 Bancos.Nombre
 from Bancos Where Valores.IdBancoDeposito=Bancos.IdBanco) as [Banco deposito],
Valores.NumeroDeposito as [Nro.Deposito],
Valores.FechaDeposito as [Fecha Deposito],
Proveedores.RazonSocial as [Proveedor pagado],
Valores.NumeroOrdenPago as [Nro.pago],
Valores.FechaOrdenPago as [Fec.pago],
Valores.IdCuenta as [Cuenta salida],
Valores.NumeroSalida as [Nro.salida],
Valores.FechaSalida as [Fec.salida]
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Cuentas ON Valores.IdCuenta=Cuentas.IdCuenta
ORDER BY Valores.FechaValor,Valores.NumeroInterno





























