




























CREATE Procedure [dbo].[ListasPreciosDetalle_T]
@IdListaPreciosDetalle int
AS 
SELECT *
FROM ListasPreciosDetalle
WHERE (IdListaPreciosDetalle=@IdListaPreciosDetalle)





























