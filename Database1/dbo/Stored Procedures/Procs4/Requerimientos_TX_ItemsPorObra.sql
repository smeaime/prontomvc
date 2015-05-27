






























CREATE  Procedure [dbo].[Requerimientos_TX_ItemsPorObra]
@IdObra int
AS 
declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01110111111133'
set @vector_T='01020102222900'
SELECT 
	DetLMat.IdDetalleLMateriales,
	LMat.NumeroLMateriales as [Nro.LM],
	DetLMat.NumeroItem as [Item],
	LMat.Fecha as [Fecha],
	DetLMat.IdArticulo,
	Articulos.Descripcion as [Articulo],
	DetLMat.Cantidad as [Cant.],
	DetLMat.Cantidad1 as [Med.1],
	DetLMat.Cantidad2 as [Med.2],
	DetLMat.Cantidad as [Cant.falt.],
	CASE 
		WHEN DetLMat.Cantidad1 IS NOT NULL AND DetLMat.Cantidad2 IS NOT NULL AND DetLMat.Cantidad1<>0 AND DetLMat.Cantidad2<>0 THEN  DetLMat.Cantidad*DetLMat.Cantidad1*DetLMat.Cantidad2
		WHEN DetLMat.Cantidad1 IS NOT NULL AND DetLMat.Cantidad1<>0 THEN  DetLMat.Cantidad*DetLMat.Cantidad1
		ELSE DetLMat.Cantidad
	END as [Total falt.],
	DetLMat.IdDetalleLMateriales as [Id1],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
LEFT OUTER JOIN Articulos ON DetLMat.IdArticulo = Articulos.IdArticulo
WHERE (not DetLMat.IdArticulo is null and LMat.IdObra=@IdObra)
ORDER BY Articulos.Descripcion































