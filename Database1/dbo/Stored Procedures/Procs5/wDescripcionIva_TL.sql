
CREATE Procedure [dbo].[wDescripcionIva_TL]
AS 
SELECT IdCodigoIva, Descripcion as [Titulo]
FROM DescripcionIva 
ORDER BY Descripcion

