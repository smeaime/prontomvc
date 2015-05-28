





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObrasPorMes_TX_PorObra]
@IdObra int
as
SELECT *
FROM DetallePresupuestosHHObrasPorMes
WHERE IdObra=@IdObra






























