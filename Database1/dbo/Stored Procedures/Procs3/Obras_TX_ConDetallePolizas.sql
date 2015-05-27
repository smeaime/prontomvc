





























CREATE Procedure [dbo].[Obras_TX_ConDetallePolizas]

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='00011111111111133'
Set @vector_T='00053244510344300'

SELECT 
 0 as [IdAux],
 Obras.NumeroObra as [K_Obra],
 1 as [K_Orden],
 Obras.NumeroObra as [Obra],
 CASE 	
	WHEN TipoObra=1 THEN 'Taller'
	WHEN TipoObra=2 THEN 'Montaje'
	WHEN TipoObra=3 THEN 'Servicio'
	ELSE Null
 END as [Tipo obra],
 Clientes.RazonSocial as [Cliente],
 Obras.FechaInicio as [Fecha inicio],
 Obras.FechaEntrega as [Fecha entrega],
 CASE 	WHEN CONVERT(varchar(8),Obras.FechaFinalizacion,3)<>'01/01/00' THEN Obras.FechaFinalizacion 
	ELSE Null 
 END as [Fecha finalizacion],
 Null as [Aseguradora],
 Null as [Tipo poliza],
 Null as [Nro. poliza],
 Null as [Fecha vig.],
 Null as [Fecha vto.cuota],
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Obras 
LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente

UNION ALL

SELECT 
 DetPol.IdDetalleObraPoliza as [IdAux],
 Obras.NumeroObra as [K_Obra],
 2 as [K_Orden],
 Null as [Obra],
 Null as [Tipo obra],
 Null as [Cliente],
 Null as [Fecha inicio],
 Null as [Fecha entrega],
 Null as [Fecha finalizacion],
 Proveedores.RazonSocial as [Aseguradora],
 TiposPoliza.Descripcion as [Tipo poliza],
 DetPol.NumeroPoliza as [Nro. poliza],
 DetPol.FechaVigencia as [Fecha vig.],
 DetPol.FechaVencimientoCuota as [Fecha vto.cuota],
 DetPol.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleObrasPolizas DetPol
LEFT OUTER JOIN Obras ON DetPol.IdObra = Obras.IdObra
LEFT OUTER JOIN Proveedores ON DetPol.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN TiposPoliza ON DetPol.IdTipoPoliza = TiposPoliza.IdTipoPoliza

UNION ALL

SELECT 
 0 as [IdAux],
 Obras.NumeroObra as [K_Obra],
 3 as [K_Orden],
 Null as [Obra],
 Null as [Tipo obra],
 Null as [Cliente],
 Null as [Fecha inicio],
 Null as [Fecha entrega],
 Null as [Fecha finalizacion],
 Null as [Aseguradora],
 Null as [Tipo poliza],
 Null as [Nro. poliza],
 Null as [Fecha vig.],
 Null as [Fecha vto.cuota],
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Obras 

ORDER by [K_Obra],[K_Orden]





























