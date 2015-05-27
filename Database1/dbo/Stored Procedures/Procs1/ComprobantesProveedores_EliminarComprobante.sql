CREATE Procedure [dbo].[ComprobantesProveedores_EliminarComprobante]

@IdComprobanteProveedor int

AS 

DECLARE @IdTipoComprobante int
SET @IdTipoComprobante=IsNull((Select Top 1 IdTipoComprobante From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),0)

DELETE FROM Subdiarios
WHERE IdTipoComprobante=@IdTipoComprobante And IdComprobante=@IdComprobanteProveedor

DELETE FROM CuentasCorrientesAcreedores
WHERE IdTipoComp=@IdTipoComprobante And IdComprobante=@IdComprobanteProveedor

DELETE FROM Valores
WHERE IdDetalleComprobanteProveedor=IsNull((Select Top 1 IdDetalleComprobanteProveedor From DetalleComprobantesProveedores Where IdComprobanteProveedor=@IdComprobanteProveedor),-9)

-- Liberar pedidos 
CREATE TABLE #Auxiliar1	
			(
			 IdDetalleComprobanteProveedor INTEGER,
			 IdDetallePedido INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleComprobanteProveedor) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT dcp.IdDetalleComprobanteProveedor, dcp.IdDetallePedido
 FROM DetalleComprobantesProveedores dcp
 WHERE dcp.IdComprobanteProveedor=@IdComprobanteProveedor and dcp.IdDetalleRecepcion is null and dcp.IdDetallePedido is not null

DECLARE @IdDetalleComprobanteProveedor int, @IdDetallePedido int, @IdPedido int

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleComprobanteProveedor, IdDetallePedido FROM #Auxiliar1 ORDER BY IdDetalleComprobanteProveedor
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleComprobanteProveedor, @IdDetallePedido
WHILE @@FETCH_STATUS = 0
  BEGIN
	UPDATE DetallePedidos
	SET IdDioPorCumplido=Null, FechaDadoPorCumplido=Null
	WHERE IdDetallePedido=@IdDetallePedido and IsNull(Cumplido,'NO')<>'AN' and IdDioPorCumplido=0

	SET @IdPedido=IsNull((Select Top 1 IdPedido From DetallePedidos Where IdDetallePedido=@IdDetallePedido),0)
	
	EXEC Pedidos_ActualizarEstadoPorIdPedido @IdPedido

	FETCH NEXT FROM Cur INTO @IdDetalleComprobanteProveedor, @IdDetallePedido
  END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1

DELETE FROM DetalleComprobantesProveedores
WHERE DetalleComprobantesProveedores.IdComprobanteProveedor=@IdComprobanteProveedor

DELETE FROM ComprobantesProveedores
WHERE ComprobantesProveedores.IdComprobanteProveedor=@IdComprobanteProveedor