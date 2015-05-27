
CREATE Procedure [dbo].[Cotizaciones_A]

@IdCotizacion int  output,
@Fecha Datetime,
@IdMoneda int,
@Cotizacion numeric(18,4),
@CotizacionLibre numeric(18,4),
@REP_COTIZACION_INS varchar(1),
@REP_COTIZACION_UPD varchar(1)

AS

INSERT INTO [Cotizaciones]
(
 Fecha,
 IdMoneda,
 Cotizacion,
 CotizacionLibre,
 REP_COTIZACION_INS,
 REP_COTIZACION_UPD
)
VALUES
(
 @Fecha,
 @IdMoneda,
 @Cotizacion,
 @CotizacionLibre,
 @REP_COTIZACION_INS,
 @REP_COTIZACION_UPD
)

SELECT @IdCotizacion=@@identity
RETURN(@IdCotizacion)
