CREATE Procedure [dbo].[Articulos_TX_PorIdRubroParaCombo]

@IdRubro int

AS 

SELECT 
 Articulos.IdArticulo,
 Articulos.Descripcion as [Titulo]
FROM Articulos
WHERE Articulos.IdRubro=@IdRubro and IsNull(Articulos.Activo,'')<>'NO'
ORDER BY  Articulos.Descripcion