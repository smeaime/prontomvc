CREATE  Procedure [dbo].[SalidasMateriales_TX_ParaRecepciones]

@Desde datetime,
@Hasta datetime

AS 

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111133'
SET @vector_T='0795315451222552504331414200'

SELECT 
 SalidasMateriales.IdSalidaMateriales,
 Case When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
	When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
	When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
	Else SalidasMateriales.ClaveTipoSalida
 End as [Tipo de salida],
 SalidasMateriales.IdSalidaMateriales as [IdAux],
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 SalidasMateriales.Observaciones as [Observaciones],
 SalidasMateriales.Anulada as [Anulada],
 SalidasMateriales.ValePreimpreso as [Vale preimpreso],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 Obras.NumeroObra as [Numero obra],
 E1.Nombre as [Emitio],
 E2.Nombre as [Aprobo],
 SalidasMateriales.Cliente as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 SalidasMateriales.Direccion as [Direccion],
 SalidasMateriales.Localidad as [Localidad],
 SalidasMateriales.CodigoPostal as [Cod.pos.],
 Transportistas.RazonSocial as [Transportista],
 E3.Nombre as [Anulo],
 SalidasMateriales.FechaAnulacion as [Fecha anul.],
 SalidasMateriales.MotivoAnulacion as [Motivo anulacion],
 SalidasMateriales.NumeroOrdenProduccion as [Nro.Orden Prod.],
 E4.Nombre as [Confecciono],
 SalidasMateriales.FechaIngreso as [Fecha ing.],
 E5.Nombre as [Modifico],
 SalidasMateriales.FechaModifico as [Fecha modif.],
 Depositos.Descripcion as [Origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SalidasMateriales
LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON SalidasMateriales.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Empleados ON SalidasMateriales.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1 = Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON SalidasMateriales.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN ArchivosATransmitirDestinos ON SalidasMateriales.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
LEFT OUTER JOIN Depositos ON SalidasMateriales.IdDepositoOrigen = Depositos.IdDeposito
LEFT OUTER JOIN Empleados E1 ON SalidasMateriales.Emitio = E1.IdEmpleado
LEFT OUTER JOIN Empleados E2 ON SalidasMateriales.Aprobo = E2.IdEmpleado
LEFT OUTER JOIN Empleados E3 ON SalidasMateriales.IdUsuarioAnulo = E3.IdEmpleado
LEFT OUTER JOIN Empleados E4 ON SalidasMateriales.IdUsuarioIngreso = E4.IdEmpleado
LEFT OUTER JOIN Empleados E5 ON SalidasMateriales.IdUsuarioModifico = E5.IdEmpleado
WHERE SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta and 
	IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and SalidasMateriales.TipoSalida=1 and 
	Not Exists(Select Top 1 DetRec.IdDetalleRecepcion 
			From DetalleRecepciones DetRec 
			Left Outer Join DetalleSalidasMateriales DetSal On DetRec.IdDetalleSalidaMateriales=DetSal.IdDetalleSalidaMateriales
			Left Outer Join Recepciones On Recepciones.IdRecepcion=DetRec.IdRecepcion
			Where IsNull(Recepciones.Anulada,'NO')<>'SI' and DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales)
ORDER BY SalidasMateriales.FechaSalidaMateriales, SalidasMateriales.NumeroSalidaMateriales2, SalidasMateriales.NumeroSalidaMateriales