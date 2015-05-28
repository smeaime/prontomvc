
CREATE Procedure [dbo].[Articulos_TX_Resumidos]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111133'
Set @vector_T='05E911100'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Codigo material],
 Articulos.Descripcion,
 Articulos.IdArticulo as [Identificador],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Articulos.NumeroInventario as [Nro.inv.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro 
WHERE IsNull(Articulos.Activo,'')<>'NO'
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Articulos.Codigo
