
CREATE  Procedure [dbo].[LMateriales_TX_Disponibilidades]

@IdLMateriales int

AS 

SELECT 
	DetLMat.IdDetalleLMateriales,
	DetLMat.NumeroItem as [Conj.],
	DetLMat.NumeroOrden as [Pos.],
	LMat.NumeroLMateriales as [Numero],
	CASE 	WHEN DetLMat.IdArticulo is null THEN DetLMat.Detalle  COLLATE SQL_Latin1_General_CP1_CI_AS
		ELSE SPACE(10)+Articulos.Descripcion 
	END as [Subconjunto / Articulo],
	DetLMat.Cantidad as [Cant.],
	( SELECT Unidades.Descripcion
	 FROM Unidades
	 WHERE Unidades.IdUnidad=DetLMat.IdUnidad) as  [Unidad en],
	DetLMat.Cantidad1 as [Med.1],
	DetLMat.Cantidad2 as [Med.2],
	DetalleAcopios.FechaNecesidad as [Fec.necesidad]
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
LEFT OUTER JOIN Articulos ON DetLMat.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN DetalleAcopios ON DetLMat.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
WHERE DetLMat.IdLMateriales =@IdLMateriales
ORDER BY DetLMat.IdDetalleLMateriales

