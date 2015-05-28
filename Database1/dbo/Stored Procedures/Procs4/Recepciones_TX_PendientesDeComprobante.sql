CREATE PROCEDURE [dbo].[Recepciones_TX_PendientesDeComprobante]

@IdProveedor int

AS

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111133'
SET @vector_T='055243539902900'

SELECT 
 Recepciones.IdRecepcion,
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
			Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
			Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Comprobante],
 Proveedores.RazonSocial as [Proveedor],
 Recepciones.FechaRecepcion as [Fecha],
 Recepciones.Anulada,
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 Requerimientos.NumeroRequerimiento as [RM],
 Acopios.NumeroAcopio as [Numero LA],
 Acopios.Nombre as [Nombre LA],
 Empleados.Nombre as [Realizo],
 Recepciones.Anulada as [Anulada],
 Recepciones.IdRecepcion as [IdAux1],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Requerimientos ON Recepciones.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Empleados ON Recepciones.Realizo=Empleados.IdEmpleado
WHERE (@IdProveedor=-1 or Recepciones.IdProveedor=@IdProveedor) and 
	IsNull(Recepciones.ProcesadoPorCPManualmente,'NO')<>'SI' and 
	IsNull(Recepciones.Anulada,'NO')<>'SI' and 
	Exists(Select Top 1 DetRec.IdRecepcion 
		From DetalleRecepciones DetRec
		Where DetRec.IdRecepcion=Recepciones.IdRecepcion and 
			Not Exists(Select Top 1 DetCP.IdDetalleComprobanteProveedor
				   From DetalleComprobantesProveedores DetCP
				   Where DetCP.IdDetalleRecepcion=DetRec.IdDetalleRecepcion)) and 
	--Recepciones.IdPedido is not null and     Se elimino para consulta 1571
	Recepciones.IdProveedor is not null
ORDER BY Proveedores.RazonSocial,FechaRecepcion