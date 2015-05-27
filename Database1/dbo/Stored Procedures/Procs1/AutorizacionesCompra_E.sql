
CREATE Procedure [dbo].[AutorizacionesCompra_E]

@IdAutorizacionCompra int  

AS 

DELETE AutorizacionesCompra
WHERE (IdAutorizacionCompra=@IdAutorizacionCompra)
