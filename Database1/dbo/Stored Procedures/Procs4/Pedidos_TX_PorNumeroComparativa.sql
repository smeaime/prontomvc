CREATE Procedure [dbo].[Pedidos_TX_PorNumeroComparativa]

@NumeroComparativa int

AS 

SELECT * 
FROM Pedidos
WHERE IsNull(Pedidos.Cumplido,'')<>'AN' and IsNull(NumeroComparativa,0)=@NumeroComparativa