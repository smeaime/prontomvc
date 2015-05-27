




CREATE Procedure [dbo].[Devoluciones_TX_PorId]
@IdDevolucion int
AS 
SELECT *
FROM Devoluciones
WHERE (IdDevolucion=@IdDevolucion)





