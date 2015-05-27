
CREATE Procedure [dbo].[TiposRetencionGanancia_TX_MaximoId]

AS 

SELECT Max(IdTipoRetencionGanancia) as [MaximoId]
FROM TiposRetencionGanancia
