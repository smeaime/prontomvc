






























CREATE Procedure [dbo].[DetRecibos_T]
@IdDetalleRecibo int
AS 
SELECT *
FROM DetalleRecibos
where (IdDetalleRecibo=@IdDetalleRecibo)































