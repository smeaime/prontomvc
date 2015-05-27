
CREATE Procedure [dbo].[DetSubcontratosDatosPedidos_E]

@IdDetalleSubcontratoDatosPedido int  

AS 

SET NOCOUNT ON

DECLARE @IdPedido int
SET @IdPedido=IsNull((Select Top 1 IdPedido From DetalleSubcontratosDatosPedidos Where IdDetalleSubcontratoDatosPedido=@IdDetalleSubcontratoDatosPedido),0)
UPDATE Pedidos
SET NumeroSubcontrato=Null
WHERE IdPedido=@IdPedido

DELETE DetalleSubcontratosDatosPedidos
WHERE IdDetalleSubcontratoDatosPedido=@IdDetalleSubcontratoDatosPedido

SET NOCOUNT OFF
