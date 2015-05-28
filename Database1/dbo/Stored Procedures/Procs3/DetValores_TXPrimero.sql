





























CREATE PROCEDURE [dbo].[DetValores_TXPrimero]
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0001101511133'
set @vector_T='0004100022900'
SELECT TOP 1
 DetVal.IdDetalleValor,
 DetVal.IdValor,
 DetVal.IdObra,
 Case 	When DetVal.IdObra Is Null
	 Then CentrosCosto.Codigo
	Else Obras.NumeroObra 
 End as [Obra / CC],
 Pedidos.NumeroPedido as [Pedido],
 DetVal.IdCuenta,
 Substring(Convert(varchar,Cuentas.Codigo)+' - '+Cuentas.Descripcion,1,50) as [Cuenta],
 DetVal.Detalle as [Detalle],
 DetVal.Importe,
 DetVal.ImporteNeto as [Neto],
 DetVal.IdDetalleValor,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleValores DetVal
LEFT OUTER JOIN Obras ON Obras.IdObra = DetVal.IdObra
LEFT OUTER JOIN CentrosCosto ON CentrosCosto.IdCentroCosto = DetVal.IdCentroCosto
LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta = DetVal.IdCuenta
LEFT OUTER JOIN Pedidos ON Pedidos.IdPedido = DetVal.IdPedido






























