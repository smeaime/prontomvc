
CREATE Procedure [dbo].[DescripcionIva_TL]
AS 
SELECT IdCodigoIva, Descripcion as [Titulo]
FROM DescripcionIva 
ORDER BY Descripcion
