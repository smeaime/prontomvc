






create procedure [dbo].[REP_COTIZACION_MARK] 
@IdCotizacion  int as 
begin 
  update Cotizaciones set REP_COTIZACION_UPD = 'R', REP_COTIZACION_INS = 'R' 
end






