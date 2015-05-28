





















CREATE  Procedure [dbo].[ValesSalida_TX_ItemsPorObra]

@IdObra int

AS 

declare @vector_X varchar(30),@vector_T varchar(30),@NroReserva as int,@IdDetalleReserva as int,@Entr1 as numeric(12,2)
set @vector_X='0111111111111111133'
set @vector_T='0911029200113011300'

SELECT 
 DetLMat.IdDetalleLMateriales,
 @IdDetalleReserva as [IdDetalleReserva],
 LMat.NumeroLMateriales as [LM],
 Equipos.Tag as [Equipo],
 @NroReserva as [Reser.],
 STR(DetLMat.NumeroItem,4)+' / '+STR(DetLMat.NumeroOrden,4) as [Item],
 DetLMat.IdArticulo,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 DetLMat.Cantidad as [Cant.],
 DetLMat.Cantidad1 as [Med.1],
 DetLMat.Cantidad2 as [Med.2],
 CASE 
	WHEN DetLMat.Cantidad1 IS NOT NULL AND DetLMat.Cantidad2 IS NOT NULL AND DetLMat.Cantidad1<>0 AND DetLMat.Cantidad2<>0 THEN  DetLMat.Cantidad*DetLMat.Cantidad1*DetLMat.Cantidad2
	WHEN DetLMat.Cantidad1 IS NOT NULL AND DetLMat.Cantidad1<>0 THEN  DetLMat.Cantidad*DetLMat.Cantidad1
	ELSE DetLMat.Cantidad
 END as [Total],
 @Entr1 as [Cant.Ent.],
 @Entr1 as [Med.1 Ent.],
 @Entr1 as [Med.2 Ent.],
 @Entr1 as [Tot. Ent.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
LEFT OUTER JOIN Equipos ON LMat.IdEquipo = Equipos.IdEquipo
LEFT OUTER JOIN Articulos ON DetLMat.IdArticulo = Articulos.IdArticulo
WHERE (not DetLMat.IdArticulo is null and LMat.IdObra=@IdObra)
ORDER BY Articulos.Descripcion,DetLMat.IdArticulo,DetLMat.IdDetalleLMateriales





















