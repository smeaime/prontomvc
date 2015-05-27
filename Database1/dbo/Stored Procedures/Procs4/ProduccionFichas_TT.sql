
CREATE  Procedure ProduccionFichas_TT

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
---------------123456789012345678901234567890	
Set @vector_X='00011111111133'
set @vector_T='000E8E41449100'
Select 
	IdProduccionFicha,
	ProduccionFichas.IdArticuloAsociado,
	ProduccionFichas.IdColor,
	ProduccionFichas.Descripcion as [n°],
	Articulos.Codigo as [Código],
	
	Articulos.Descripcion as [Artículo],
	Colores.Descripcion AS [Color],
	ISNULL(EstaActiva,'SI') as Activa,
	Cantidad,
	Unidades.Descripcion as [Unidad],
	
	Minimo as [Mínimo],
	ProduccionFichas.Observaciones,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM ProduccionFichas
LEFT OUTER JOIN Unidades ON ProduccionFichas.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Colores ON ProduccionFichas.IdColor = Colores.IdColor
LEFT OUTER  JOIN Articulos ON ProduccionFichas.IdArticuloAsociado = Articulos.IdArticulo
--INNER JOIN Subrubros ON AcoSeries.IdSubrubro = Subrubros.IdSubrubro
ORDER BY Articulos.Descripcion,Colores.Descripcion

