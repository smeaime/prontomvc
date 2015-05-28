CREATE Procedure [dbo].[TiposComprobante_TX_ParaComboGastosBancarios]

@Estado varchar(1) = Null

AS 

SET @Estado=IsNull(@Estado,'G')

SELECT 
 IdTipoComprobante,
 DescripcionAb + '  ' + Descripcion as Titulo
FROM TiposComprobante 
WHERE (@Estado='G' and Agrupacion1='GASTOSBANCOS') or (@Estado='T' and Agrupacion1='GASTOSTARJETAS')
ORDER by Descripcion
