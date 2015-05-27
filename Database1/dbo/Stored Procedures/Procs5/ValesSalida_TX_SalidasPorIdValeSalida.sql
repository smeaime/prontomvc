


CREATE PROCEDURE [dbo].[ValesSalida_TX_SalidasPorIdValeSalida]

@IdValeSalida int

AS

SELECT DISTINCT 
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Numero],
 SalidasMateriales.FechaSalidaMateriales as [Fecha]
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleValesSalida DetVal ON DetSal.IdDetalleValeSalida=DetVal.IdDetalleValeSalida
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	DetSal.IdDetalleValeSalida is not null and 
	DetVal.IdValeSalida=@IdValeSalida


