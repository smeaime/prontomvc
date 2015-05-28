





CREATE PROCEDURE [dbo].[Articulos_TX_RevaluosAFechaResumido]

@FechaControl datetime

AS

SELECT
 DetAFijos.IdRevaluo,
 Revaluos.Descripcion as [Revaluo],
 Revaluos.FechaRevaluo
FROM DetalleArticulosActivosFijos DetAFijos
LEFT OUTER JOIN Revaluos ON Revaluos.IdRevaluo=DetAFijos.IdRevaluo
WHERE DetAFijos.TipoConcepto is not null and DetAFijos.TipoConcepto='R' and 
	Revaluos.FechaRevaluo<=@FechaControl
GROUP BY DetAFijos.IdRevaluo,Revaluos.Descripcion,Revaluos.FechaRevaluo
ORDER BY Revaluos.FechaRevaluo





