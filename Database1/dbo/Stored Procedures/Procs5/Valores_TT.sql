CREATE  Procedure [dbo].[Valores_TT]

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111111133'
SET @vector_T='0093454303115422442555555424500'

SELECT 
 Valores.IdValor,
 Case When  Valores.IdTipoValor is null and  Valores.Estado='G'
	Then 'GS'
	Else (Select top 1 TiposComprobante.DescripcionAb
		From TiposComprobante 
		Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) 
 End as [Tipo],
 Valores.IdValor as [IdAux],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.NumeroValor as [Numero],
 Valores.CuitLibrador as [Cuit librador],
 Valores.FechaValor as [Fecha Vto.],
 Valores.Importe as [Importe],
 Monedas.Abreviatura as [Mon.],
 (Select top 1 Bancos.Nombre
	From Bancos Where Valores.IdBanco=Bancos.IdBanco) as [Banco origen],
 Valores.Estado as [Estado],
 (Select top 1 TiposComprobante.DescripcionAb
	From TiposComprobante Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
 Valores.NumeroComprobante as [Nro.Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 (Select top 1 Bancos.Nombre
	From Bancos Where Valores.IdBancoDeposito=Bancos.IdBanco) as [Banco deposito],
 Valores.NumeroDeposito as [Nro.Deposito],
 Valores.FechaDeposito as [Fecha Deposito],
 Proveedores.RazonSocial as [Proveedor pagado],
 Valores.NumeroOrdenPago as [Nro.pago],
 Valores.FechaOrdenPago as [Fec.pago],
 Cuentas.Descripcion as [Cuenta salida],
 Valores.NumeroSalida as [Nro.salida],
 Valores.FechaSalida as [Fec.salida],
 Valores.Anulado as [Anulado],
 Valores.Rechazado as [Rechazado],
 E1.Nombre as [Anulo / Rechazo],
 Valores.FechaAnulacion as [Fecha anulacion / rechazo],
 Valores.MotivoAnulacion as [Motivo anulacion / rechazo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Cuentas ON Valores.IdCuenta=Cuentas.IdCuenta
LEFT OUTER JOIN Monedas ON Valores.IdMoneda=Monedas.IdMoneda
LEFT OUTER JOIN Empleados E1 ON Valores.IdUsuarioAnulo=E1.IdEmpleado
WHERE (Select top 1 TiposComprobante.Agrupacion1
		from TiposComprobante 
		Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) ='CHEQUES'
ORDER BY Valores.FechaValor,Valores.NumeroInterno