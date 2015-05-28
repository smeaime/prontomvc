





























CREATE Procedure [dbo].[EstadoPedidos_TXParaImputar]
@IdProveedor int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='000111111133'
set @vector_T='000154555000'
Select 
EstadoPedidos.IdEstado,
EstadoPedidos.IdImputacion,
EstadoPedidos.IdComprobante,
TiposComprobante.DescripcionAB as [Comp.],
CASE 	When 	EstadoPedidos.LetraComprobante is null
	 Then 	CONVERT(varchar(8),EstadoPedidos.NumeroComprobante2)
	Else 	EstadoPedidos.LetraComprobante+' '+
		CONVERT(varchar(4),EstadoPedidos.NumeroComprobante1)+' '+
		CONVERT(varchar(8),EstadoPedidos.NumeroComprobante2) 
END as [Comprobante],
EstadoPedidos.Fecha,
CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN EstadoPedidos.ImporteTotal
	ELSE EstadoPedidos.ImporteTotal*-1
END as [Imp.orig.],
CASE 
	WHEN TiposComprobante.Coeficiente=1 THEN EstadoPedidos.Saldo
	ELSE EstadoPedidos.Saldo*-1
END as [Saldo Comp.],
EstadoPedidos.SaldoTrs,
EstadoPedidos.Marca as [*],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM EstadoPedidos 
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=EstadoPedidos.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=EstadoPedidos.IdTipoComprobante
WHERE (EstadoPedidos.IdProveedor=@IdProveedor)
ORDER by EstadoPedidos.IdImputacion,EstadoPedidos.IdTipoComprobante,EstadoPedidos.Fecha






























