
CREATE Procedure [dbo].[TiposComprobante_TX_ParaComboVentas]

AS 

SELECT IdTipoComprobante, DescripcionAb + '  ' + Descripcion as Titulo
FROM TiposComprobante 
WHERE Agrupacion1='VENTAS' or Agrupacion1='STOCK' or Agrupacion1='COMPRAS'
ORDER by Descripcion
