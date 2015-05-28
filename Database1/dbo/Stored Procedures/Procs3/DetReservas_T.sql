





























CREATE Procedure [dbo].[DetReservas_T]
@IdDetalleReserva int
AS 
SELECT *
FROM [DetalleReservas]
where (IdDetalleReserva=@IdDetalleReserva)






























