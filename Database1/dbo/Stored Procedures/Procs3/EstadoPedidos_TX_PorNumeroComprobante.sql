





























CREATE Procedure [dbo].[EstadoPedidos_TX_PorNumeroComprobante]
@CodigoProveedor varchar(10),
@NumeroComprobante varchar(13)
AS 
SELECT TOP 1 *
FROM EstadoPedidos
WHERE CodigoProveedor=@CodigoProveedor and 
	 NumeroComprobante=@NumeroComprobante






























