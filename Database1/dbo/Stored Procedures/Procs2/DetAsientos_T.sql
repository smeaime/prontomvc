






























CREATE Procedure [dbo].[DetAsientos_T]
@IdDetalleAsiento int
AS 
SELECT *
FROM DetalleAsientos
where (IdDetalleAsiento=@IdDetalleAsiento)































