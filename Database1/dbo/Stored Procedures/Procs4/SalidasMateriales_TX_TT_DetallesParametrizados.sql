


CREATE  Procedure [dbo].[SalidasMateriales_TX_TT_DetallesParametrizados]

@IdSalidaMateriales int,
@NivelParametrizacion int

AS 

Declare @vector_X varchar(50),@vector_T varchar(50)
IF @NivelParametrizacion=1
   BEGIN
	Set @vector_X='01111111111111133'
	Set @vector_T='07554599222552500'
   END
ELSE
   BEGIN
	Set @vector_X='01111111111111133'
	Set @vector_T='07554512222552500'
   END

SELECT 
 SalidasMateriales.IdSalidaMateriales,
 CASE	WHEN SalidasMateriales.TipoSalida=0 THEN 'Salida a fabrica'
	WHEN SalidasMateriales.TipoSalida=1 THEN 'Salida a obra'
	WHEN SalidasMateriales.TipoSalida=2 THEN 'A Proveedor'
	ELSE Null
 END as [Tipo de salida],
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [Nro. de salida],
 SalidasMateriales.ValePreimpreso as [Vale preimpreso],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 Obras.NumeroObra as [Numero obra],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 CentrosCosto.Descripcion as [Centro de costo],
 Empleados.Nombre as [Aprobo],
 SalidasMateriales.Cliente as [Cliente],
 Proveedores.RazonSocial as [Proveedor],
 SalidasMateriales.Direccion as [Direccion],
 SalidasMateriales.Localidad as [Localidad],
 SalidasMateriales.CodigoPostal as [Cod.pos.],
 Transportistas.RazonSocial as [Transportista],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM SalidasMateriales
LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra = Obras.IdObra
LEFT OUTER JOIN CentrosCosto ON SalidasMateriales.IdCentroCosto = CentrosCosto.IdCentroCosto
LEFT OUTER JOIN Empleados ON SalidasMateriales.Aprobo = Empleados.IdEmpleado
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1 = Transportistas.IdTransportista
LEFT OUTER JOIN Proveedores ON SalidasMateriales.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN ArchivosATransmitirDestinos ON SalidasMateriales.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
WHERE (IdSalidaMateriales=@IdSalidaMateriales)


