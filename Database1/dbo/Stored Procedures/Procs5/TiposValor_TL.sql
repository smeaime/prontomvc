
CREATE Procedure [dbo].[TiposValor_TL]

AS 

SELECT IdTipoComprobante,Descripcion as Titulo
FROM TiposComprobante 
WHERE EsValor='SI'
ORDER BY Descripcion
