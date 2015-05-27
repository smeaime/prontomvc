






























CREATE Procedure [dbo].[DetRecibosCuentas_T]
@IdDetalleReciboCuentas int
AS 
SELECT *
FROM DetalleRecibosCuentas
where (IdDetalleReciboCuentas=@IdDetalleReciboCuentas)































