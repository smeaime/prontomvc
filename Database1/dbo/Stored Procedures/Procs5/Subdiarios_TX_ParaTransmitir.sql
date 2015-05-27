


CREATE Procedure [dbo].[Subdiarios_TX_ParaTransmitir]
AS 
SELECT *
FROM Subdiarios 
WHERE IsNull(EnviarEmail,1)=1


