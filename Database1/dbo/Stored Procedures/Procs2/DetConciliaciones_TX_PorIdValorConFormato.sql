CREATE PROCEDURE [dbo].[DetConciliaciones_TX_PorIdValorConFormato]

@IdValor int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0011111116661111111111133'
Set @vector_T='0029314433322144229999900'

SELECT
 -1,
 0,
 (Select top 1 TiposComprobante.DescripcionAb From TiposComprobante Where Valores.IdTipoValor=TiposComprobante.IdTipoComprobante) as [Tipo valor],
 @IdValor,
 Valores.NumeroValor as [Numero valor],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Valores.FechaDeposito as [Fecha dep.],
 Valores.NumeroDeposito as [Nro. dep.],
 Case 	When 	Valores.Estado='D' or (Valores.Estado='G' and tc.Coeficiente=-1) or 
		((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
		  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)))
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	Not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null
	 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0) or 
				(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)<0)
			 Then 	Case When Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  								  from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0 
					Then Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)
					Else Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)*-1 
				End 
			 Else Null 
		End
	Else Null
 End as [Ingresos],
 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
		  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)))
		or (Valores.Estado='G' and tc.Coeficiente=1)
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	Not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.Estado is null
	 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0) or 
				(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)<0)
			 Then 	Case When Valores.Importe*Isnull((Select top 1 tc1.Coeficiente  								  from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0 
					Then Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)
					Else Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)*-1 
				End 
			 Else Null 
		End
	Else Null
 End as [Egresos],
 Valores.Iva as [Iva],
 Bancos.Nombre as [Banco origen],
 tc.DescripcionAb as [Tipo],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 Case 	When 	Valores.Estado='D' or (Valores.Estado='G' and tc.Coeficiente=-1) or 
		((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe>=0) or 
		  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe<0)))
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	Not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null
	 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0) or 
				(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)<0)
			 Then 	Case When Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  								  from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0 
					Then Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)
					Else Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)*-1 
				End 
			 Else Null 
		End
	Else Null
 End as [TotalIngresos],
 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 ((Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and Valores.Importe>=0) or 
		  (Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and Valores.Importe<0)))
		or 
		(Valores.Estado='G' and tc.Coeficiente=1)
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	Not (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and Valores.Estado is null
	 Then 	Case 	When 	(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=-1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0) or 
				(Isnull(tc.CoeficienteParaConciliaciones,tc.Coeficiente)=1 and 
				Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  							from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)<0)
			 Then 	Case When Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  								  from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)>=0 
					Then Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)
					Else Valores.Importe*Isnull((Select top 1 tc1.Coeficiente
  									from TiposComprobante tc1 Where Valores.IdTipoValor=tc1.IdTipoComprobante),1)*-1 
				End 
			 Else Null 
		End
	Else Null
 End as [TotalEgresos],
 '',
 -1 as [IdAux],
 ''
FROM Valores
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN CuentasBancarias ON Valores.IdCuentaBancaria=CuentasBancarias.IdCuentaBancaria
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante tc ON Valores.IdTipoComprobante=tc.IdTipoComprobante
WHERE Valores.IdValor = @IdValor