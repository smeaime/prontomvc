CREATE Procedure [dbo].[ListasPreciosDetalle_E]

@IdListaPreciosDetalle int  

AS 

DELETE ListasPreciosDetalle
WHERE (IdListaPreciosDetalle=@IdListaPreciosDetalle)