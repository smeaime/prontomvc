CREATE Procedure [dbo].[Bancos_TX_Movimientos]

@BancoAConciliar Int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='011111111111166611111133'
set @vector_T='009904134244333320342200'

SELECT 
 Valores.IdValor,
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.IdValor as [IdVal],
 @BancoAConciliar as [IdBco],
 (Select top 1 TiposComprobante.DescripcionAb
  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.NumeroValor as [Numero valor],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null 
	Then 'NO' 
	Else Valores.MovimientoConfirmadoBanco 
 End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Valores.FechaDeposito as [Fecha dep.],
 Valores.NumeroDeposito as [Nro. dep.],
 Valores.Importe as [Ingresos],
 Null as [Egresos],
 Null as [Iva],
 Bancos.Nombre as [Banco origen],
 TiposComprobante.DescripcionAb as [Tipo],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 Null as [Proveedor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancariaDeposito=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
WHERE Valores.Estado='D' And Valores.IdBancoDeposito=@BancoAConciliar and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

SELECT 
 Valores.IdValor,
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.IdValor as [IdVal],
 @BancoAConciliar as [IdBco],
 (Select top 1 TiposComprobante.DescripcionAb
  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.NumeroValor as [Numero valor],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null 
	Then 'NO' 
	Else Valores.MovimientoConfirmadoBanco 
 End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Null as [Ingresos],
 Valores.Importe as [Egresos],
 Null as [Iva],
 Null as [Banco origen],
 TiposComprobante.DescripcionAb as [Tipo],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Null as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
WHERE (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	Valores.IdBanco=@BancoAConciliar and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

SELECT 
 Valores.IdValor,
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.IdValor as [IdVal],
 @BancoAConciliar as [IdBco],
 'GS' as [Tipo],
 Null as [Numero valor],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null 
	Then 'NO' 
	Else Valores.MovimientoConfirmadoBanco 
 End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 Null as [Nro.Int.],
 Null as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Case When TiposComprobante.Coeficiente=-1 Then Valores.Importe Else Null End as [Ingresos],
 Case When TiposComprobante.Coeficiente=1 Then Valores.Importe Else Null End as [Egresos],
 Valores.Iva as [Iva],
 Null as [Banco origen],
 TiposComprobante.DescripcionAb as [Tipo], Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Null as [Cliente],
 Null as [Proveedor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante ON Valores.IdTipoComprobante=TiposComprobante.IdTipoComprobante
WHERE Valores.Estado='G' And Valores.IdBanco=@BancoAConciliar and IsNull(Valores.Anulado,'NO')<>'SI'

UNION ALL 

SELECT
 Valores.IdValor,
 CuentasBancarias.Cuenta as [Cuenta],
 Valores.IdValor as [IdVal], @BancoAConciliar as [IdBco],
 (Select top 1 TiposComprobante.DescripcionAb
  from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo],
 Valores.NumeroValor as [Numero valor],
 Case When Valores.Conciliado is null 
	Then 'NO' 
	Else Valores.Conciliado 
 End as [Conc.],
 Case When Valores.MovimientoConfirmadoBanco is null 
	Then 'NO' 
	Else Valores.MovimientoConfirmadoBanco 
 End as [Confirmado],
 Valores.FechaConfirmacionBanco as [Fecha conf.],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Null as [Fecha dep.],
 Null as [Nro. dep.],
 Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					 from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  							from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
 End as [Ingresos],
 Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0) or 
		(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
		 Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  					from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)<0)
	 Then 	Case 	When Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)>=0 
			 Then Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)
			 Else Valores.Importe*Isnull((Select top 1 TiposComprobante.Coeficiente
  						from TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante),1)*-1 
		End 
	 Else Null 
 End as [Egresos],
 Null as [Iva],
 Null as [Banco origen],
 tc.DescripcionAb as [Tipo],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
WHERE NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
	Valores.Estado is null and Valores.IdCuentaBancaria is not null and 
	Valores.IdBanco=@BancoAConciliar and IsNull(Valores.Anulado,'NO')<>'SI'
ORDER BY Valores.FechaValor,Valores.NumeroInterno