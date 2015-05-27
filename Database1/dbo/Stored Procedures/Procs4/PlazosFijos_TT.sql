











CREATE Procedure [dbo].[PlazosFijos_TT]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111166616111116661133'
Set @vector_T='0555555555545559404332200'

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
ORDER by Bancos.Nombre,FechaVencimiento











