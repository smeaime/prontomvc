



CREATE Procedure [dbo].[DefinicionArticulos_TX_CamposPorIdRubro]

@IdRubro int

AS 

SELECT  
 Campo,
 MAX(IsNull(Orden,'')) as [Orden],
 MAX(IsNull(Etiqueta,'')) as [Etiqueta],
 MAX(IsNull(TablaCombo,'')) as [TablaCombo],
 MAX(IsNull(CampoCombo,'')) as [CampoCombo]
FROM DefinicionArticulos
WHERE IdRubro=@IdRubro and IsNull(Etiqueta,'')<>''
GROUP BY Campo
ORDER BY [Orden]



