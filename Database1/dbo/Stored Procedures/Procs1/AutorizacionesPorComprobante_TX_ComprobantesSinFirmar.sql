CREATE Procedure [dbo].[AutorizacionesPorComprobante_TX_ComprobantesSinFirmar]

@Cuales varchar(1),
@Desde datetime,
@Hasta datetime,
@TipoComprobante varchar(20) = Null,
@EstadoEnvioPedido varchar(1) = Null,
@IdTipoCompra int = Null

AS

SET @TipoComprobante=IsNull(@TipoComprobante,'*')
SET @EstadoEnvioPedido=IsNull(@EstadoEnvioPedido,'*')
SET @IdTipoCompra=IsNull(@IdTipoCompra,-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111111111111133'
IF @TipoComprobante='Pedido'
	SET @vector_T='029915411614141499999999999994100'
ELSE
	SET @vector_T='029915411614141414141414143114100'

SELECT 
 Tmp.IdComprobante,
 Tmp.TipoComprobante as [Tipo],
 Case 	When Tmp.TipoComprobante='Acopio' Then 1001
	When Tmp.TipoComprobante='L.Materiales' Then 1002
	When Tmp.TipoComprobante='R.M.' Then 1003
	When Tmp.TipoComprobante='Pedido' Then 1004
	When Tmp.TipoComprobante='Comparativa' Then 1005
	When Tmp.TipoComprobante='Ajuste Stock' Then 1006
	Else 0
 End as [IdAux1],
 Tmp.IdComprobante as [IdAux2],
 TiposCompra.Modalidad as [TC],
 Tmp.NumeroComprobante as [Numero],
 Tmp.FechaComprobante as [Fecha],
 Tmp.CantidadFirmas as [Firmas],
 (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=IdLibero) as [Liberado por],
 Tmp.FechaLiberacion as [Fecha liberacion],
 Case 	When Firma1=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma1)
 End as [Firma 1],
 Tmp.FechaFirma1 as [Fecha firma 1],
 Case 	When Firma2=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma2)
 End as [Firma 2],
 Tmp.FechaFirma2 as [Fecha firma 2],
 Case 	When Firma3=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma3)
 End as [Firma 3],
 Tmp.FechaFirma3 as [Fecha firma 3],
 Case 	When Firma4=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma4)
 End as [Firma 4],
 Tmp.FechaFirma4 as [Fecha firma 4],
 Case 	When Firma5=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma5)
 End as [Firma 5],
 Tmp.FechaFirma5 as [Fecha firma 5],
 Case 	When Firma6=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma6)
 End as [Firma 6],
 Tmp.FechaFirma6 as [Fecha firma 6],
 Case 	When Firma7=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma7)
 End as [Firma 7],
 Tmp.FechaFirma7 as [Fecha firma 7],
 Case 	When Firma8=-1 then 'No definida'
	Else (Select Empleados.Nombre From Empleados Where Empleados.IdEmpleado=Firma8)
 End as [Firma 8],
 Tmp.FechaFirma8 as [Fecha firma 8],
 Obras.NumeroObra as [Obra],
 Equipos.Tag as [Equipo],
 CentrosCosto.Descripcion as [Centro costo],
 Pedidos.FechaEnvioProveedor as [Fecha envio proveedor],
 E1.Nombre as [Envio a proveedor],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM _TempEstadoDeFirmas Tmp
LEFT OUTER JOIN Obras On Obras.IdObra=Tmp.IdObra
LEFT OUTER JOIN Equipos On Equipos.IdEquipo=Tmp.IdEquipo
LEFT OUTER JOIN CentrosCosto On CentrosCosto.IdCentroCosto=Tmp.IdCentroCosto
LEFT OUTER JOIN Pedidos On Pedidos.IdPedido=Tmp.IdComprobante and Tmp.TipoComprobante='Pedido'
LEFT OUTER JOIN TiposCompra ON TiposCompra.IdTipoCompra=Pedidos.IdTipoCompraRM
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Pedidos.IdUsuarioEnvioProveedor
WHERE Tmp.FechaComprobante Between @Desde And @Hasta and 
	(@TipoComprobante='*' or Tmp.TipoComprobante=@TipoComprobante) and 
	(@EstadoEnvioPedido='*' or (@EstadoEnvioPedido='P' and Pedidos.FechaEnvioProveedor is null) or (@EstadoEnvioPedido='E' and Pedidos.FechaEnvioProveedor is not null)) and 
	(@Cuales='T'  or (@Cuales='P' and IsNull(Tmp.CircuitoFirmasCompleto,'')<>'SI') or (@Cuales='F' and IsNull(Tmp.CircuitoFirmasCompleto,'')='SI')) and 
	(@IdTipoCompra=-1 or IsNull(Pedidos.IdTipoCompraRM,0)=@IdTipoCompra)
ORDER BY Tmp.TipoComprobante, Tmp.NumeroComprobante