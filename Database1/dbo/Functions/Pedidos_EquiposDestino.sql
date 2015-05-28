CREATE FUNCTION [dbo].[Pedidos_EquiposDestino](@IdPedido int)
RETURNS VARCHAR(2000)

BEGIN
	DECLARE @Retorno varchar (4000)
	SET @Retorno = ''
	SELECT @Retorno = COALESCE(@Retorno,'')+
			Articulos.NumeroInventario COLLATE SQL_Latin1_General_CP1_CI_AS+' '+Articulos.Descripcion+' '
	FROM DetallePedidos DetPed
	LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
	LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
	LEFT OUTER JOIN Articulos ON Requerimientos.IdEquipoDestino = Articulos.IdArticulo
	WHERE DetPed.IdPedido=@IdPedido and Articulos.IdArticulo is not null
	GROUP BY Articulos.NumeroInventario, Articulos.Descripcion
	ORDER BY Articulos.NumeroInventario, Articulos.Descripcion

	RETURN Substring(@Retorno,1,2000)
END


