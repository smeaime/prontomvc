CREATE Procedure [dbo].[PlazosFijos_TX_Vencidos]

@VencenHoy varchar(2) = Null

AS 

SET @VencenHoy=IsNull(@VencenHoy,'')

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111166616111116661133'
SET @vector_T='0555555555545559404332200'

SELECT 
 IdPlazoFijo,
 Bancos.Nombre as [Banco],
 NumeroCertificado1 as [Nro. Certif.],
 DireccionEmisionYPago as [Direccion emision/pago],
 Titulares,
 CodigoDeposito as [Dep.],
 CodigoClase as [Clase],
 PlazoEnDias as [Plazo (dias)],
 TasaNominalAnual as [Tasa nominal anual],
 Importe,
 TasaEfectivaMensual as [Tasa efectiva mensual],
 FechaVencimiento as [Fecha vto.],
 ImporteIntereses as [Intereses],
 Orden,
 Detalle,
 IdPlazoFijoOrigen,
 FechaInicioPlazoFijo as [Fecha inicio],
 Monedas.Abreviatura as [Mon.],
 RetencionGanancia as [Ret.Ganancias],
 CotizacionMonedaAlInicio as [Cotiz.Inicial],
 CotizacionMonedaAlFinal as [Cotiz.Final],
 Finalizado,
 Anulado,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PlazosFijos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=PlazosFijos.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=PlazosFijos.IdMoneda
WHERE IsNull(PlazosFijos.Anulado,'')<>'SI' and FechaVencimiento<=GetDate() and 
	(@VencenHoy='' or (@VencenHoy='SI' and FechaVencimiento=Convert(datetime,convert(varchar,Day(GetDate())) + '/' + convert(varchar,Month(GetDate())) + '/' + convert(varchar,Year(GetDate())),103)))
ORDER by Bancos.Nombre,FechaVencimiento