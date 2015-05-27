




























CREATE Procedure [dbo].[Ganacias_AsignarMinimos]

@IdTipoRetencionGanancia int,
@MinimoNoImponible numeric(18,2),
@MinimoARetener numeric(18,2)

AS 

UPDATE Ganancias 
SET MinimoNoImponible=@MinimoNoImponible,
	MinimoARetener=@MinimoARetener
WHERE IdTipoRetencionGanancia=@IdTipoRetencionGanancia




























