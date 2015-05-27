





























CREATE Procedure [dbo].[EstadoPedidos_TX_BuscarComprobante]
@IdComprobante int,
@IdTipoComprobante int
AS 
SELECT *
FROM EstadoPedidos
where (IdComprobante=@IdComprobante and IdTipoComprobante=@IdTipoComprobante)






























