
CREATE Procedure [dbo].[Obras_TX_DestinosParaPresupuesto]

@Todas int = Null,
@IdObra int = Null

AS 

SET @Todas=IsNull(@Todas,-1)
SET @IdObra=IsNull(@IdObra,-1)

SELECT 
 DetalleObrasDestinos.IdDetalleObraDestino, 
 DetalleObrasDestinos.IdObra,
 Obras.NumeroObra, 
 Obras.Descripcion as [Obra], 
 Obras.IdUnidadOperativa,
 UnidadesOperativas.Descripcion as [UnidadOperativa],
 DetalleObrasDestinos.Destino as [Etapa],
 Convert(varchar,DetalleObrasDestinos.Detalle) as [DetalleEtapa]
FROM DetalleObrasDestinos
LEFT OUTER JOIN Obras ON Obras.IdObra=DetalleObrasDestinos.IdObra
LEFT OUTER JOIN UnidadesOperativas ON UnidadesOperativas.IdUnidadOperativa=Obras.IdUnidadOperativa
WHERE (@Todas=-1 or (@Todas=1 and Obras.Activa='SI')) and 
	(@IdObra=-1 or DetalleObrasDestinos.IdObra=@IdObra) and 
	IsNull(DetalleObrasDestinos.ADistribuir,'NO')='NO'
ORDER BY Obras.NumeroObra, DetalleObrasDestinos.IdObra, DetalleObrasDestinos.Destino
