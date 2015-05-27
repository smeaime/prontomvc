CREATE  Procedure [dbo].[Valores_TX_NoEmitidosPorCuenta]

@IdCuentaBancaria int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 A_IdValor INTEGER,
			 A_Proveedor VARCHAR(50),
			 A_ChequesALaOrdenDe1 VARCHAR(100),
			 A_ChequesALaOrdenDe2 VARCHAR(100)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Valores.IdValor,
  Proveedores.RazonSocial,
  Proveedores.ChequesALaOrdenDe,
  depv.ChequesALaOrdenDe
FROM Valores 
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN DetalleOrdenesPagoValores depv ON Valores.IdDetalleOrdenPagoValores=depv.IdDetalleOrdenPagoValores
WHERE Valores.IdTipoComprobante=17 and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.IdCuentaBancaria=@IdCuentaBancaria and 
	(Valores.Emitido is null or Valores.Emitido<>'SI') and 
	(Select top 1 TiposComprobante.Agrupacion1
		From TiposComprobante 
		Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) ='CHEQUES'

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111116111111111111111111133'
Set @vector_T='0499145022420113424542414300'

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
 Case 	When #Auxiliar1.A_ChequesALaOrdenDe2 is not null
	 Then #Auxiliar1.A_ChequesALaOrdenDe2
	When #Auxiliar1.A_ChequesALaOrdenDe1 is not null
	 Then #Auxiliar1.A_ChequesALaOrdenDe1
	 Else #Auxiliar1.A_Proveedor
 End as [Beneficiario],
 Case 	When depv.NoALaOrden is null 
	 Then 'NO'
	 Else depv.NoALaOrden
 End as [No a la orden],
 (Select top 1 Bancos.Nombre
  From Bancos Where Valores.IdBanco=Bancos.IdBanco) as [Banco origen],
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.Estado as [Estado],
 (Select top 1 TiposComprobante.DescripcionAb
  From TiposComprobante Where Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante) as [Comp.],
 Valores.NumeroComprobante as [Nro.Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 (Select top 1 Bancos.Nombre
  from Bancos Where Valores.IdBancoDeposito=Bancos.IdBanco) as [Banco deposito],
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
LEFT OUTER JOIN #Auxiliar1 ON Valores.IdValor=#Auxiliar1.A_IdValor
WHERE Valores.IdTipoComprobante=17 and IsNull(Valores.Anulado,'NO')<>'SI' and 
	Valores.IdCuentaBancaria=@IdCuentaBancaria and 
	(Valores.Emitido is null or Valores.Emitido<>'SI') and 
	(Select top 1 TiposComprobante.Agrupacion1
		From TiposComprobante 
		Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) ='CHEQUES'
ORDER BY [Banco origen], CuentasBancarias.Cuenta, Valores.NumeroInterno, Valores.FechaValor

DROP TABLE #Auxiliar1