
CREATE Procedure [dbo].[Facturas_TX_PorId]

@IdFactura int

AS 

SELECT 
 Facturas.*,
 0 as [IdObra],
 '' as [NumeroObra]
FROM Facturas
WHERE (IdFactura=@IdFactura)
