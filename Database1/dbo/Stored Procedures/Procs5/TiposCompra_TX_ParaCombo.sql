CREATE Procedure [dbo].[TiposCompra_TX_ParaCombo]

AS 

SELECT 
 IdTipoCompra,
 Descripcion as [Titulo]
FROM TiposCompra 
ORDER by Descripcion