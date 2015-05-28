




CREATE PROCEDURE [dbo].[Pedidos_TX_SubcontratosParaCombo]
AS
SELECT 
 Pedidos.IdPedido,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+ltrim(str(Pedidos.SubNumero,4))
	Else str(Pedidos.NumeroPedido,8)
 End as [Titulo]
FROM Pedidos
WHERE IsNull(Pedidos.Subcontrato,'NO')='SI'
ORDER BY [Titulo]




