
































CREATE Procedure [dbo].[TiposComprobante_TL]
AS 
Select 
 IdTipoComprobante,
 DescripcionAb + '  ' + Descripcion as Titulo
FROM TiposComprobante 
ORDER by Descripcion

































