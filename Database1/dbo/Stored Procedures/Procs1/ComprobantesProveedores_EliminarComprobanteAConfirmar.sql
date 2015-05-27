
CREATE Procedure [dbo].[ComprobantesProveedores_EliminarComprobanteAConfirmar]

@IdComprobanteProveedor int

AS 

SET NOCOUNT ON

DECLARE @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP varchar(2), @IdPedido int, @IdDetallePedido int

SET @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP=IsNull((Select Top 1 Valor From Parametros2 Where Campo='DesactivarDarPorCumplidoPedidoSinRecepcionEnCP'),'NO')

IF @DesactivarDarPorCumplidoPedidoSinRecepcionEnCP='NO'
    BEGIN
	CREATE TABLE #Auxiliar (IdDetallePedido INTEGER)
	CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar (IdDetallePedido) ON [PRIMARY]
	INSERT INTO #Auxiliar 
	 SELECT DISTINCT Det.IdDetallePedido
	 FROM DetalleComprobantesProveedores Det 
	 WHERE Det.IdComprobanteProveedor=@IdComprobanteProveedor and Det.IdDetalleRecepcion is null and Det.IdDetallePedido is not null and 
		IsNull((Select Top 1 cp.Confirmado From ComprobantesProveedores cp Where cp.IdComprobanteProveedor=Det.IdComprobanteProveedor),'SI')='NO'

	/*  CURSOR  */
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetallePedido FROM #Auxiliar ORDER BY IdDetallePedido
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdDetallePedido
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		SET @IdPedido=IsNull((Select Top 1 IdPedido From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)

		UPDATE DetallePedidos
		SET Cumplido = Null
		WHERE IdDetallePedido=@IdDetallePedido and IdDioPorCumplido=0 and IsNull(Cumplido,'NO')='SI' 
		
		EXEC Pedidos_ActualizarEstadoPorIdPedido @IdPedido

		FETCH NEXT FROM Cur INTO @IdDetallePedido
	   END
	CLOSE Cur
	DEALLOCATE Cur

	DROP TABLE #Auxiliar
    END

DELETE DetalleComprobantesProveedores
WHERE DetalleComprobantesProveedores.IdComprobanteProveedor=@IdComprobanteProveedor and 
	IsNull((Select Top 1 cp.Confirmado From ComprobantesProveedores cp 
		Where cp.IdComprobanteProveedor=DetalleComprobantesProveedores.IdComprobanteProveedor),'SI')='NO'

DELETE ComprobantesProveedores
WHERE ComprobantesProveedores.IdComprobanteProveedor=@IdComprobanteProveedor and IsNull(ComprobantesProveedores.Confirmado,'SI')='NO'

SET NOCOUNT OFF
