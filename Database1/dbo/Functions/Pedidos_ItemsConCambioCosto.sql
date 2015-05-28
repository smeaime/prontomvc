CREATE FUNCTION [dbo].[Pedidos_ItemsConCambioCosto](@IdPedido int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (1000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Convert(varchar,DetPed.NumeroItem)+' '
	FROM DetallePedidos DetPed
	WHERE DetPed.IdPedido=@IdPedido and Exists(Select Top 1 dpcp.IdDetallePedidoCambioPrecio From DetallePedidosCambiosPrecio dpcp Where dpcp.IdDetallePedido=DetPed.IdDetallePedido)
	GROUP BY DetPed.NumeroItem
	ORDER BY DetPed.NumeroItem

	RETURN Substring(@Retorno,1,100)
END

