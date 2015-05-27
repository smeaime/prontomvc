
CREATE Procedure [dbo].[Proveedores_TX_EventualesParaCombo]

AS 

SELECT 
 IdProveedor,
 RazonSocial as [Titulo]
FROM Proveedores
WHERE Eventual='SI' and (Confirmado is null or Confirmado<>'NO')
ORDER by RazonSocial

