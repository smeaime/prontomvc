﻿





























CREATE Procedure [dbo].[EstadoPedidos_TXPorMayor]
@IdProveedor int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111111111133'
set @vector_T='000056540222300'
Select 
EstadoPedidos.IdEstado,
EstadoPedidos.IdImputacion,
EstadoPedidos.IdComprobante,
TiposComprobante.DescripcionAB as [Comp.],
CASE 	When 	EstadoPedidos.LetraComprobante is null
	 Then 	STR(EstadoPedidos.NumeroComprobante2,17)
	Else 	EstadoPedidos.LetraComprobante+' '+
		STR(EstadoPedidos.NumeroComprobante1,4)+' '+
		STR(EstadoPedidos.NumeroComprobante2,8) 
END as [Comprobante],
Case 	When EstadoPedidos.SubNumeroPedido is not null 
	Then str(EstadoPedidos.NumeroPedido,8)+' / '+str(EstadoPedidos.SubNumeroPedido,4)
	Else str(EstadoPedidos.NumeroPedido,8)
End as [Nro.Pedido SGM],
EstadoPedidos.NumeroSAP as [Nro.doc.SAP],
EstadoPedidos.Fecha,
Case 	When EstadoPedidos.SubNumeroPedido=0 And EstadoPedidos.NumeroPedido=0
	Then 'S/A'
	Else Null
End as [Det.],
EstadoPedidos.ImporteTotal as [Imp.orig.],
CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN EstadoPedidos.ImporteTotal
	ELSE Null
END as [Debe],
CASE 
	WHEN TiposComprobante.Coeficiente=-1 THEN EstadoPedidos.ImporteTotal
	ELSE Null
END as [Haber],
EstadoPedidos.SaldoTrs as [Sdo],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM EstadoPedidos 
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=EstadoPedidos.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=EstadoPedidos.IdTipoComprobante
WHERE EstadoPedidos.IdProveedor=@IdProveedor 
ORDER by EstadoPedidos.IdImputacion,EstadoPedidos.IdTipoComprobante,EstadoPedidos.Fecha






























