
CREATE Procedure [dbo].[TiposRetencionGanancia_T]

@IdTipoRetencionGanancia int

AS 

SELECT *
FROM TiposRetencionGanancia
WHERE (IdTipoRetencionGanancia=@IdTipoRetencionGanancia)
