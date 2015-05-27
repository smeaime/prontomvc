



CREATE procedure [dbo].[REP_COTIZACION_SEL]
AS
SELECT 
 REP_COTIZACION_INS,
 IdCotizacion,
 Fecha,
 IdMoneda,
 Cotizacion,
 CotizacionLibre
FROM Cotizaciones
WHERE (REP_COTIZACION_INS = 'Y' or REP_COTIZACION_UPD = 'Y')



