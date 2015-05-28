CREATE Procedure [dbo].[Proveedores_TX_ParaTransmitir]

AS 

SELECT *
FROM Proveedores
WHERE EnviarEmail=1