CREATE Procedure [dbo].[ListasPrecios_TX_Validar]

@IdListaPrecios int,
@IdArticulo int,
@IdCliente int,
@IdListaPreciosDetalle int

AS 

SELECT * 
FROM ListasPreciosDetalle
WHERE (@IdListaPreciosDetalle<=0 or IdListaPreciosDetalle<>@IdListaPreciosDetalle) and 
	IdListaPrecios=@IdListaPrecios and IdArticulo=@IdArticulo and IsNull(IdCliente,0)=@IdCliente