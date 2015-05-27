



CREATE Procedure [dbo].[Articulos_TX_AgrupadoPorRubro]
AS
SELECT 
 Articulos.
 IdRubro,
 Rubros.Descripcion
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
WHERE IsNull(Articulos.Activo,'')<>'NO'
GROUP BY Articulos.IdRubro,Rubros.Descripcion
ORDER BY Rubros.Descripcion



