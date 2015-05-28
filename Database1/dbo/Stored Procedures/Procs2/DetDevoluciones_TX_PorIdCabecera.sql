






























CREATE PROCEDURE [dbo].[DetDevoluciones_TX_PorIdCabecera]
@IdDevolucion int
AS
SELECT *
FROM DetalleDevoluciones
WHERE (DetalleDevoluciones.IdDevolucion = @IdDevolucion)































