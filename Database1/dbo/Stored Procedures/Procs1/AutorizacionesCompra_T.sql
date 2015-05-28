
CREATE Procedure [dbo].[AutorizacionesCompra_T]

@IdAutorizacionCompra int

AS 

SELECT * 
FROM AutorizacionesCompra
WHERE (IdAutorizacionCompra=@IdAutorizacionCompra)
