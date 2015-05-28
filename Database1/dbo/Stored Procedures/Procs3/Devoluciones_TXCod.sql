






























CREATE Procedure [dbo].[Devoluciones_TXCod]
@NroFac int
As
SELECT IdDevolucion, FechaDevolucion
FROM Devoluciones
WHERE (NumeroDevolucion = @NroFac)































