
CREATE  Procedure [dbo].[Cotizaciones_M]

@IdCotizacion int ,
@Fecha Datetime,
@IdMoneda int,
@Cotizacion numeric(18,4),
@CotizacionLibre numeric(18,4),
@REP_COTIZACION_INS varchar(1),
@REP_COTIZACION_UPD varchar(1)

AS

UPDATE Cotizaciones
SET
 Fecha=@Fecha,
 IdMoneda=@IdMoneda,
 Cotizacion=@Cotizacion,
 CotizacionLibre=@CotizacionLibre,
 REP_COTIZACION_INS=@REP_COTIZACION_INS,
 REP_COTIZACION_UPD=@REP_COTIZACION_UPD
WHERE (IdCotizacion=@IdCotizacion)

RETURN(@IdCotizacion)
