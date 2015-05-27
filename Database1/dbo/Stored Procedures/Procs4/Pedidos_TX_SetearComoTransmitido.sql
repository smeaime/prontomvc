CREATE Procedure [dbo].[Pedidos_TX_SetearComoTransmitido]

AS 

UPDATE Pedidos
SET EnviarEmail=0
WHERE EnviarEmail<>0 and Pedidos.Aprobo is not null