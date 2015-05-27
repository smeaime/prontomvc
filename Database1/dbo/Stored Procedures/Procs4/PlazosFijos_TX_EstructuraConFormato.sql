













CREATE Procedure [dbo].[PlazosFijos_TX_EstructuraConFormato]

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111666161111166133'
Set @vector_T='05555555555455594033200'

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
 CotizacionMonedaAlInicio as [Cotiz.Inicial],
 CotizacionMonedaAlFinal as [Cotiz.Final],
 Finalizado,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM PlazosFijos
LEFT OUTER JOIN Bancos ON Bancos.IdBanco=PlazosFijos.IdBanco
LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=PlazosFijos.IdMoneda
WHERE (IdPlazoFijo=-1)













