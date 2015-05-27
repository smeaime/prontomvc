



CREATE PROCEDURE [dbo].[Presupuestos_TX_DetallesPorIdPresupuestoAgrupados]

@IdPresupuesto int

AS

SELECT
 Min(DetPre.NumeroItem) as [Item],
 DetPre.IdArticulo,
 Sum(DetPre.Cantidad) as [Cantidad],
 DetPre.IdUnidad,
 DetPre.Cantidad1 as [Med1],
 DetPre.Cantidad2 as [Med2],
 DetPre.Precio as [Prec.Unit.],
 Sum(DetPre.Cantidad*DetPre.Precio) as [Subtotal],
 DetPre.PorcentajeBonificacion as [% Bon],
 Sum(DetPre.ImporteBonificacion) as [Bonif.],
 Sum((DetPre.Cantidad*DetPre.Precio)-IsNull(DetPre.ImporteBonificacion,0)) as [Subtotal grav.],
 DetPre.PorcentajeIVA as [% IVA],
 Sum(DetPre.ImporteIVA) as [IVA],
 Sum(DetPre.ImporteTotalItem) as [Importe],
 Max(DetPre.Adjunto) as [Adjunto],
 DetPre.OrigenDescripcion,
 Convert(varchar(5000),DetPre.Observaciones) as [Observaciones]
FROM DetallePresupuestos DetPre
WHERE (DetPre.IdPresupuesto = @IdPresupuesto)
GROUP BY DetPre.IdArticulo, DetPre.IdUnidad, DetPre.Cantidad1, 
	DetPre.Cantidad2, DetPre.Precio, DetPre.PorcentajeBonificacion, 
	DetPre.PorcentajeIVA, DetPre.OrigenDescripcion, 
	Convert(varchar(5000),DetPre.Observaciones)
ORDER BY [Item]



