CREATE Procedure [dbo].[Articulos_TX_Busca]

@Buscar varchar(50)

AS 

SELECT 
 IdArticulo,
 Descripcion as [Titulo],
 Codigo as [Codigo],
 Descripcion as [Descripcion]
FROM Articulos
WHERE IsNull(Articulos.Activo,'')<>'NO' and descripcion LIKE '%' + @buscar + '%'
ORDER BY Descripcion