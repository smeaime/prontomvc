






























CREATE Procedure [dbo].[DetRecibos_TX_PorIdDetalleRecibo]
@IdDetalleRecibo int
AS 
SELECT *
FROM DetalleRecibos
where (IdDetalleRecibo=@IdDetalleRecibo)































