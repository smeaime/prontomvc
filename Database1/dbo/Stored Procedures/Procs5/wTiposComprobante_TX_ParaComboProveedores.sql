
CREATE Procedure [dbo].[wTiposComprobante_TX_ParaComboProveedores]
AS 
Select 
 IdTipoComprobante,
 DescripcionAb + '  ' + Descripcion as Titulo
FROM TiposComprobante 
WHERE Agrupacion1='PROVEEDORES'
ORDER by Descripcion

