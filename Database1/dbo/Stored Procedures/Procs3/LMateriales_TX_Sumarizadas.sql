





























CREATE  Procedure [dbo].[LMateriales_TX_Sumarizadas]
@IdObra int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
declare @Clave as int
set @vector_X='0111111133'
set @vector_T='0620222200'
set @clave=0
SELECT 
	@Clave,
	LMat.NumeroLMateriales as [Nro.L.Materiales],
	LMat.Nombre as [L.Materiales],
	Equipos.Tag as [Equipo],
	Articulos.Descripcion as [Articulo],
	SUM(DetLMat.Cantidad) as [Cant.],
	DetLMat.Cantidad1 as [Med.1],
	DetLMat.Cantidad2 as [Med.2],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
LEFT OUTER JOIN Equipos ON LMat.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Articulos ON DetLMat.IdArticulo = Articulos.IdArticulo
WHERE (not DetLMat.IdArticulo is null and LMat.IdObra=@IdObra)
GROUP BY LMat.NumeroLMateriales,LMat.Nombre,Equipos.Tag,
	Articulos.Descripcion,DetLMat.Cantidad1,DetLMat.Cantidad2






























