CREATE Procedure [dbo].[SalidasMateriales_TX_PorTipoSalida]

AS 

SELECT TipoSalida, ClaveTipoSalida as [Tipo de salida]
FROM SalidasMateriales
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI'
GROUP BY TipoSalida, ClaveTipoSalida
ORDER BY TipoSalida, ClaveTipoSalida
