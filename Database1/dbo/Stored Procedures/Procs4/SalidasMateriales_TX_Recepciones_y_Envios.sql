CREATE  Procedure [dbo].[SalidasMateriales_TX_Recepciones_y_Envios]

@Desde datetime = Null,
@Hasta datetime = Null,
@IdObra int = Null

AS 

SET @Desde=IsNull(@Desde,Convert(datetime,'01/01/1980'))
SET @Hasta=IsNull(@Hasta,Convert(datetime,'31/12/2020'))
SET @IdObra=IsNull(@IdObra,-1)

SELECT 
 SalidasMateriales.IdSalidaMateriales,
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 'Envio' as [Tipo],
 CASE	WHEN SalidasMateriales.TipoSalida=0 THEN 'Salida a fabrica'
	WHEN SalidasMateriales.TipoSalida=1 THEN 'Salida a obra'
	WHEN SalidasMateriales.TipoSalida=2 THEN 'A Proveedor'
	ELSE SalidasMateriales.ClaveTipoSalida
 END as [Para],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Numero],
 Null as [Proveedor],
 Transportistas.RazonSocial as [Transportista],
 Obras.NumeroObra as [Obra],
 Null as [Pedido],
 Null as [RM]
FROM SalidasMateriales
LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN Empleados ON SalidasMateriales.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1 = Transportistas.IdTransportista
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or SalidasMateriales.IdObra=@IdObra)

UNION ALL 

SELECT 
 Recepciones.IdRecepcion,
 FechaRecepcion as [Fecha],
 'Recepcion' as [Tipo],
 Null as [Para],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(Recepciones.NumeroRecepcion1,0))))+Convert(varchar,IsNull(Recepciones.NumeroRecepcion1,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2) as [Numero],
 Proveedores.RazonSocial as [Proveedor],
 Transportistas.RazonSocial as [Transportista],
 Null as [Obra],
 Pedidos.NumeroPedido as [Pedido],
 Requerimientos.NumeroRequerimiento as [RM]
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Requerimientos ON Recepciones.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Transportistas ON Recepciones.IdTransportista = Transportistas.IdTransportista
WHERE IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Recepciones.FechaRecepcion Between @Desde and @Hasta and 
	(@IdObra=-1 or Exists(Select Top 1 DetRec.IdRecepcion From DetalleRecepciones DetRec Where DetRec.IdRecepcion=Recepciones.IdRecepcion and DetRec.IdObra=@IdObra))
ORDER BY [Fecha]