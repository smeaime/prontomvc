















CREATE Procedure [dbo].[DefinicionArticulos_TX_TT]
@IdDef int
as
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='0111111111111111133'
set @vector_T='0119555155133333300'
Select 
IdDef,
Rubros.Descripcion as Rubro,
Subrubros.Descripcion as Subrubro,
Familias.Descripcion as Familia,
AddNombre as [Agregar a descripcion],
Orden as [Nro.orden],
Campo as [Campo rel.],
Etiqueta,
TablaCombo as [Tabla p/combo],
CampoCombo as [Campo p/combo],
CampoUnidad as [Campo unidad],
Unidades.Descripcion as [Unidad default],
Antes as [Poner antes:],
Despues as [Poner despues:],
UsaAbreviatura as [Usa abrev.],
AgregaUnidadADescripcion as [Agrega unidad a descripcion],
UsaAbreviaturaUnidad as [Usa abrev. unidad],
@Vector_T as Vector_T,
@Vector_X as Vector_X
FROM DefinicionArticulos
LEFT OUTER JOIN Rubros ON  DefinicionArticulos.IdRubro = Rubros.IdRubro 
LEFT OUTER JOIN Subrubros ON  DefinicionArticulos.IdSubrubro = Subrubros.IdSubrubro 
LEFT OUTER JOIN Familias ON  DefinicionArticulos.IdFamilia = Familias.IdFamilia
LEFT OUTER JOIN Unidades ON  DefinicionArticulos.UnidadDefault = Unidades.IdUnidad
WHERE (IdDef=@IdDef)















