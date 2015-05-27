
CREATE PROCEDURE [dbo].[Conciliaciones_TX_DetallePorIdValor_ConFormato]

@IdValor int,
@IdCuentaBancaria int

AS

DECLARE @TotalIngresos numeric(18,2),@TotalEgresos numeric(18,2)
SET @TotalIngresos=0
SET @TotalEgresos=0

SELECT
 tc2.DescripcionAb as [Tipo valor],
 Valores.NumeroValor as [Numero valor],
 Valores.NumeroInterno as [Nro.Int.],
 Valores.FechaValor as [Fecha valor],
 Valores.FechaDeposito as [Fecha dep.],
 Valores.NumeroDeposito as [Nro. dep.],
 Case 	When 	(Valores.Estado='D' and Valores.IdCuentaBancariaDeposito=@IdCuentaBancaria)
		OR
		((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.IdCuentaBancaria=@IdCuentaBancaria and 
		 ((Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=1 and Valores.Importe>=0) or 
		  (Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=-1 and Valores.Importe<0)))
		OR
		(Valores.Estado='G' and Valores.IdCuentaBancaria=@IdCuentaBancaria and 
		 tc1.Coeficiente=-1)
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.Estado is null and
		 Valores.IdCuentaBancaria=@IdCuentaBancaria)
	 Then 	Case 	When 	(Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=1 and 
				Valores.Importe*Isnull(tc2.Coeficiente,1)>=0) or 
				(Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=-1 and 
				Valores.Importe*Isnull(tc2.Coeficiente,1)<0)
			 Then 	Case When Valores.Importe*Isnull(tc2.Coeficiente,1)>=0 
					Then Valores.Importe*Isnull(tc2.Coeficiente,1)
					Else Valores.Importe*Isnull(tc2.Coeficiente,1)*-1 
				End 
			 Else Null 
		End
	 Else Null
 End as [Ingresos],
 Case 	When 	((Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.IdCuentaBancaria=@IdCuentaBancaria and 
		 ((Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=-1 and Valores.Importe>=0) or 
		  (Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=1 and Valores.Importe<0)))
		OR
		(Valores.Estado='G' and Valores.IdCuentaBancaria=@IdCuentaBancaria and 
		 tc1.Coeficiente=1)
	 Then 	Case When Valores.Importe>=0 
			Then Valores.Importe 
			Else Valores.Importe*-1 
		End 
	When 	(NOT (Valores.IdTipoComprobante=17 or Valores.IdDetalleComprobanteProveedor is not null) and 
		 Valores.Estado is null and
		 Valores.IdCuentaBancaria=@IdCuentaBancaria)
	 Then 	Case 	When 	(Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=-1 and 
				Valores.Importe*Isnull(tc2.Coeficiente,1)>=0) or 
				(Isnull(tc1.CoeficienteParaConciliaciones,tc1.Coeficiente)=1 and 
				Valores.Importe*Isnull(tc2.Coeficiente,1)<0)
			 Then 	Case When Valores.Importe*Isnull(tc2.Coeficiente,1)>=0 
					Then Valores.Importe*Isnull(tc2.Coeficiente,1)
					Else Valores.Importe*Isnull(tc2.Coeficiente,1)*-1 
				End 
			 Else Null 
		End
	Else Null
 End as [Egresos],
 Valores.Iva as [Iva],
 Bancos.Nombre as [Banco origen],
 tc1.DescripcionAb as [Tipo],
 Valores.NumeroComprobante as [Comp.],
 Valores.FechaComprobante as [Fec.Comp.],
 Clientes.RazonSocial as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 @TotalIngresos as [TotalIngresos],
 @TotalEgresos as [TotalEgresos]
FROM Valores 
LEFT OUTER JOIN Clientes ON Valores.IdCliente=Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON Valores.IdProveedor=Proveedores.IdProveedor
LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
LEFT OUTER JOIN TiposComprobante tc1 ON Valores.IdTipoComprobante=tc1.IdTipoComprobante
LEFT OUTER JOIN TiposComprobante tc2 ON Valores.IdTipoValor=tc2.IdTipoComprobante
WHERE (Valores.IdValor = @IdValor)
