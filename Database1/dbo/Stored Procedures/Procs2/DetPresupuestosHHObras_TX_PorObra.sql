





























CREATE PROCEDURE [dbo].[DetPresupuestosHHObras_TX_PorObra]
@IdObra int
as
SELECT *
FROM DetallePresupuestosHHObras
WHERE IdObra=@IdObra






























