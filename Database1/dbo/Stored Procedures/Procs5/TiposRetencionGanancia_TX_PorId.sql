
CREATE Procedure [dbo].[TiposRetencionGanancia_TX_PorId]

@IdTipoRetencionGanancia int

AS 

SELECT *
FROM TiposRetencionGanancia 
WHERE IdTipoRetencionGanancia=@IdTipoRetencionGanancia
