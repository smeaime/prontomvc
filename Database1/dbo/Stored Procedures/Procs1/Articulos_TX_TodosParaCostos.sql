



























CREATE Procedure [dbo].[Articulos_TX_TodosParaCostos]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111133'
Set @vector_T='0309019400'

SELECT 
 Articulos.IdArticulo,
 Articulos.Codigo as [Codigo material],
 Articulos.Descripcion,
 Articulos.IdArticulo as [Identificador],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Familias.Descripcion as [Familia],
 Case When Articulos.CostoPPP=0 Then Null Else Articulos.CostoPPP End as [Costo PPP],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Articulos
LEFT OUTER JOIN Rubros ON  Articulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro left outer  JOIN Familias ON Articulos.IdFamilia = Familias.IdFamilia
ORDER by Rubros.Descripcion,Subrubros.Descripcion,Familias.Descripcion



























