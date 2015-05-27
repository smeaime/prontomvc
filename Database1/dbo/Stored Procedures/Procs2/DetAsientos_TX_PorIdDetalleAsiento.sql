






CREATE Procedure [dbo].[DetAsientos_TX_PorIdDetalleAsiento]
@IdDetalleAsiento int
AS 
SELECT *
FROM DetalleAsientos
WHERE (IdDetalleAsiento=@IdDetalleAsiento)







