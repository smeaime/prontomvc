CREATE  Procedure [dbo].[SalidasMateriales_TX_Todos]

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
ORDER BY [Fecha]