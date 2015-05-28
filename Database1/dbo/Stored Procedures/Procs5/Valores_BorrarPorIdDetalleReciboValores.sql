















CREATE Procedure [dbo].[Valores_BorrarPorIdDetalleReciboValores]
@IdDetalleReciboValores int
AS 
DELETE FROM Valores
WHERE (IdDetalleReciboValores=@IdDetalleReciboValores)















