CREATE  Procedure [dbo].[wValores_TX_GastosPorIdConDatos]

@IdValor int

AS

SELECT 
 Valores.*,
 IsNull(Valores.Importe,0)-IsNull(Valores.Iva,0) as [Subtotal],
 TiposComprobante.Descripcion as [TipoComprobante], 
 Bancos.Nombre as [Banco],
 Monedas.Abreviatura as [Moneda],
 IsNull(Valores.Conciliado,'NO') as [Conciliado1],
 IsNull(Valores.MovimientoConfirmadoBanco,'NO') as [MovimientoConfirmadoBanco1],
 CuentasBancarias.Cuenta as [CuentaBancaria],
 Conciliaciones.Numero as [NumeroExtracto],
 Conciliaciones.FechaIngreso as [FechaExtracto],
 E1.Nombre as [Confecciono],
 E2.Nombre as [Modifico],
 Obras.NumeroObra as [NumeroObra],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 Cuentas.Codigo as [CodigoCuentaIva],
 Cuentas.Descripcion as [CuentaIva]
FROM Valores 
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON CuentasBancarias.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN Conciliaciones ON Valores.IdConciliacion=Conciliaciones.IdConciliacion
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Valores.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Valores.IdUsuarioModifico
LEFT OUTER JOIN Obras ON Valores.IdObra=Obras.IdObra
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Valores.IdCuentaIVA
WHERE Valores.IdValor=@IdValor