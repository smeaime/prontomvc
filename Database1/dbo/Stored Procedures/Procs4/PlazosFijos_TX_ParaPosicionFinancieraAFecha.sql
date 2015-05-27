
CREATE PROCEDURE [dbo].[PlazosFijos_TX_ParaPosicionFinancieraAFecha]

@Fecha datetime,
@IdMoneda int

AS

SELECT 
 PlazosFijos.IdPlazoFijo,
 Bancos.Nombre as [Banco],
 PlazosFijos.NumeroCertificado1,
 PlazosFijos.DireccionEmisionYPago,
 PlazosFijos.Titulares,
 PlazosFijos.CodigoDeposito,
 PlazosFijos.CodigoClase,
 PlazosFijos.PlazoEnDias,
 PlazosFijos.TasaNominalAnual,
 PlazosFijos.Importe,
 PlazosFijos.TasaEfectivaMensual,
 PlazosFijos.FechaVencimiento,
 PlazosFijos.ImporteIntereses,
 PlazosFijos.RetencionGanancia,
 PlazosFijos.Orden,
 PlazosFijos.Detalle,
 PlazosFijos.IdPlazoFijoOrigen,
 PlazosFijos.FechaInicioPlazoFijo,
 Monedas.Nombre as [Moneda],
 PlazosFijos.CotizacionMonedaAlInicio,
 PlazosFijos.CotizacionMonedaAlFinal,
 PlazosFijos.Finalizado
FROM PlazosFijos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=PlazosFijos.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=PlazosFijos.IdMoneda
WHERE PlazosFijos.IdMoneda=@IdMoneda and 
	(PlazosFijos.Finalizado is null or PlazosFijos.Finalizado='NO') and 
	(PlazosFijos.Anulado is null or PlazosFijos.Anulado<>'SI')
ORDER by Bancos.Nombre, PlazosFijos.FechaInicioPlazoFijo, PlazosFijos.NumeroCertificado1
