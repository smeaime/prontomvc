











CREATE Procedure [dbo].[PlazosFijos_TX_EntreFechasParaGeneracionContable]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SELECT *
FROM PlazosFijos
WHERE ((PlazosFijos.FechaInicioPlazoFijo between @FechaDesde and @FechaHasta) or 
	  (PlazosFijos.FechaVencimiento is not null and 
	   PlazosFijos.FechaVencimiento between @FechaDesde and @FechaHasta)) and 
	 (PlazosFijos.Anulado is null or PlazosFijos.Anulado<>'SI')











