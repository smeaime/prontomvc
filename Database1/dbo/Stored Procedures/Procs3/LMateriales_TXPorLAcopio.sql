





























CREATE  Procedure [dbo].[LMateriales_TXPorLAcopio]
@Nombre varchar(30)
AS 
SELECT 
	DetLMat.IdLMateriales,
	LMateriales.NumeroLMateriales as [L.Materiales],
	LMateriales.Nombre,
	Acopios.NumeroAcopio as [L.Acopio]
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales ON DetLMat.IdLMateriales=LMateriales.IdLMateriales
LEFT OUTER JOIN DetalleAcopios ON DetLMat.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
WHERE (Acopios.Nombre=@Nombre)
GROUP BY DetLMat.IdLMateriales,LMateriales.NumeroLMateriales,LMateriales.Nombre,Acopios.NumeroAcopio






























