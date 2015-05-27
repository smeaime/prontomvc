CREATE  Procedure [dbo].[Valores_TX_GastosPorIdConDatos]

@IdValor int

AS

SELECT 
 Valores.*,
 TiposComprobante.Descripcion as [TipoDocumento], Bancos.Nombre as [Banco],
 Monedas.Abreviatura as [Moneda],
 CuentasBancarias.Cuenta as [Cuenta],
 Obras.NumeroObra as [Obra],
 Cuentas.Descripcion as [CuentaIVA]
FROM Valores 
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON CuentasBancarias.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Obras ON Valores.IdObra=Obras.IdObra
LEFT OUTER JOIN Cuentas ON Valores.IdCuentaIVA=Cuentas.IdCuenta
WHERE (IdValor=@IdValor)