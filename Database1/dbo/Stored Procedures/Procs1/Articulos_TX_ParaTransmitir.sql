CREATE Procedure [dbo].[Articulos_TX_ParaTransmitir]

AS 

SELECT *
FROM Articulos
WHERE EnviarEmail=1