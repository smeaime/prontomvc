




CREATE PROCEDURE [dbo].[Obras_TX_ConPolizasVencidas]

@FechaHasta datetime,
@Señal int

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0111111111111611111133'
Set @vector_T='0337344431356344411100'

SELECT
 DetPol.IdDetalleObraPoliza,
 Obras.NumeroObra as [Obra],
 CASE 	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [Tipo obra],
 Obras.Descripcion as [Descripcion obra],
 Clientes.RazonSocial as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion],
 Proveedores.RazonSocial as [Aseguradora],
 TiposPoliza.Descripcion as [Tipo poliza],
 DetPol.NumeroPoliza as [Nro. poliza],
 DetPol.FechaVigencia as [Fecha vig.],
 DetPol.FechaVencimientoCuota as [Fecha vto.cuota],
 DetPol.Importe as [Importe],
 DetPol.FechaEstimadaRecupero as [Fec.Est.Rec.],
 DetPol.FechaRecupero as [Fecha Rec.],
 DetPol.FechaFinalizacionCobertura as [Fec.Fin.Cob.],
 DetPol.CondicionRecupero as [Condicion recupero],
 DetPol.MotivoDeContratacionSeguro as [Motivo de contratacion],
 DetPol.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasPolizas DetPol
LEFT OUTER JOIN Obras ON DetPol.IdObra = Obras.IdObra
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
LEFT OUTER JOIN Proveedores ON DetPol.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposPoliza ON DetPol.IdTipoPoliza = TiposPoliza.IdTipoPoliza
WHERE Obras.Activa='SI' and 
	(@Señal=0 or 
	 (@Señal=-1 and 
	  (DetPol.FechaFinalizacionCobertura is null or DetPol.FechaFinalizacionCobertura<=@FechaHasta)))
ORDER by Obras.NumeroObra




