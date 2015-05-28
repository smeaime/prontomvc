CREATE  Procedure [dbo].[Valores_TX_TodosNoEmitidos]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111116111111111111111111133'
SET @vector_T='0499145022420113424542414300'

SET NOCOUNT OFF

SELECT 
 Valores.IdValor,
 Valores.NumeroValor as [Numero Cheque],
 Valores.IdValor as [IdVal],
 Valores.IdCuentaBancaria,
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha Vto.],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 Proveedores.RazonSocial as [Proveedor],
 Case When Len(IsNull(depv.ChequesALaOrdenDe,''))>0 Then depv.ChequesALaOrdenDe COLLATE SQL_Latin1_General_CP1_CI_AS
	When Len(IsNull(Proveedores.ChequesALaOrdenDe,''))>0 Then Proveedores.ChequesALaOrdenDe COLLATE SQL_Latin1_General_CP1_CI_AS
	Else Proveedores.RazonSocial
 End as [Beneficiario],
 IsNull(depv.NoALaOrden,'NO') as [No a la orden],
 (Select top 1 Bancos.Nombre From Bancos Where Valores.IdBanco=Bancos.IdBanco) as [Banco origen],
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.Estado as [Estado],
 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
 Valores.NumeroComprobante as [Nro.Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 (Select top 1 Bancos.Nombre From Bancos Where Valores.IdBancoDeposito=Bancos.IdBanco) as [Banco deposito],
 Valores.NumeroDeposito as [Nro.Deposito],
 Valores.FechaDeposito as [Fecha Deposito],
 Cuentas.Descripcion as [Cuenta salida],
 Valores.NumeroSalida as [Nro.salida],
 Valores.FechaSalida as [Fec.salida],
 Valores.Emitido,
 Valores.FechaEmision as [Fec.emision],
 Empleados.Nombre as [Emitio],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Cuentas ON Valores.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Empleados ON Valores.IdEmitio=Empleados.IdEmpleado
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN DetalleOrdenesPagoValores depv ON Valores.IdDetalleOrdenPagoValores=depv.IdDetalleOrdenPagoValores
WHERE Valores.IdTipoComprobante=17 and 
	(Valores.Emitido is null or Valores.Emitido<>'SI') and 
	(Select top 1 TiposComprobante.Agrupacion1 From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) ='CHEQUES'
ORDER BY [Banco origen], CuentasBancarias.Cuenta, Valores.NumeroInterno, Valores.FechaValor