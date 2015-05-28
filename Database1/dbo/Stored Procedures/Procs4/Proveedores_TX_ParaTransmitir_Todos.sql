
CREATE Procedure [dbo].[Proveedores_TX_ParaTransmitir_Todos]

AS 

SELECT *
FROM Proveedores
WHERE IsNull(Eventual,'')<>'SI'
