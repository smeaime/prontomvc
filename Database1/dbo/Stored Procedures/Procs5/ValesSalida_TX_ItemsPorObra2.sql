


CREATE  Procedure [dbo].[ValesSalida_TX_ItemsPorObra2]

@IdObra int

AS
SELECT
 DetalleValesSalida.IdDetalleLMateriales,
 DetSal.IdSalidaMateriales,
 DetSal.IdArticulo,
 DetSal.Cantidad,
 DetSal.Cantidad1,
 DetSal.Cantidad2,
 Case
	When (DetSal.Cantidad1 is not null and DetSal.Cantidad1<>0) and (DetSal.Cantidad2 is not null and DetSal.Cantidad2<>0) Then DetSal.Cantidad*DetSal.Cantidad1*DetSal.Cantidad2
	When DetSal.Cantidad1 is not null and DetSal.Cantidad1<>0 Then DetSal.Cantidad*DetSal.Cantidad1
	Else DetSal.Cantidad
 End as Entregado
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	SalidasMateriales.IdObra=@IdObra


