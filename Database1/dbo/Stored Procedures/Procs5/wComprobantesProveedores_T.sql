
CREATE Procedure [dbo].[wComprobantesProveedores_T]
@IdComprobanteProveedor int=null
AS 

SET @IdComprobanteProveedor=IsNull(@IdComprobanteProveedor,-1)

SELECT Cab.*,
/*
Substring(Cab.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,Cab.NumeroComprobante1)))+
	Convert(varchar,Cab.NumeroComprobante1)+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,Cab.NumeroComprobante2)))+
	Convert(varchar,Cab.NumeroComprobante2),1,20) as [Numero],
*/
 Cuentas.Descripcion as [Cuenta],
Proveedores.RazonSocial as [Proveedor],
ProveedoresEventual.RazonSocial as [ProveedorEventual]


FROM ComprobantesProveedores Cab
--LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
--LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Cuentas ON Cab.IdCuenta = Cuentas.IdCuenta
--LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
--LEFT OUTER JOIN Obras ON Cab.IdObra = Obras.IdObra
--LEFT OUTER JOIN Clientes ON Obras.IdCliente = Clientes.IdCliente
--LEFT OUTER JOIN Equipos ON DetReq.IdEquipo = Equipos.IdEquipo
--LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
--LEFT OUTER JOIN ControlesCalidad ON DetReq.IdControlCalidad = ControlesCalidad.IdControlCalidad
--LEFT OUTER JOIN Empleados E1 ON Requerimientos.Aprobo = E1.IdEmpleado
--LEFT OUTER JOIN Empleados E2 ON Requerimientos.IdSolicito = E2.IdEmpleado
--LEFT OUTER JOIN Empleados E3 ON Requerimientos.IdComprador = E3.IdEmpleado
LEFT OUTER JOIN Proveedores ON Cab.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Proveedores ProveedoresEventual ON Cab.IdProveedorEventual = ProveedoresEventual.IdProveedor
WHERE (@IdComprobanteProveedor=-1 or (IdComprobanteProveedor=@IdComprobanteProveedor))
order by IdComprobanteProveedor DESC

