
CREATE Procedure [dbo].[BD_TX_BasesInstaladas]
AS 
SELECT dbId as [IdAux], Name as [Titulo] 
FROM master.dbo.sysdatabases
ORDER BY name
