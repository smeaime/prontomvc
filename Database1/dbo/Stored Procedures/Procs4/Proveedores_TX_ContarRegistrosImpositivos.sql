
CREATE Procedure [dbo].[Proveedores_TX_ContarRegistrosImpositivos]

AS 

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	SELECT Count(*)  as [Registros] FROM _TempInformacionImpositiva
ELSE 
	SELECT 0 as [Registros]
