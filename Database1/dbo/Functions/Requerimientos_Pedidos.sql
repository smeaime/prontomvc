CREATE FUNCTION [dbo].[Requerimientos_Pedidos](@IdRequerimiento int)
RETURNS VARCHAR(100)

BEGIN
	DECLARE @Retorno varchar (2000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+Convert(varchar,Pedidos.NumeroPedido)+IsNull('/'+Convert(varchar,Pedidos.Subnumero),'')+' '
	FROM DetalleRequerimientos DetReq
	LEFT OUTER JOIN DetallePedidos ON DetReq.IdDetalleRequerimiento = DetallePedidos.IdDetalleRequerimiento
	LEFT OUTER JOIN Pedidos ON DetallePedidos.IdPedido = Pedidos.IdPedido
	WHERE DetReq.IdRequerimiento=@IdRequerimiento and IsNull(DetallePedidos.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN'
	GROUP BY Pedidos.NumeroPedido, Pedidos.Subnumero
	ORDER BY Pedidos.NumeroPedido, Pedidos.Subnumero

	RETURN Substring(@Retorno,1,100)
END
