CREATE  Procedure [dbo].[Recepciones_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111111133'
SET @vector_T='0552435GA909931414143300'

SELECT 
 Recepciones.IdRecepcion,
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+	Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
			Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Comprobante],
 Proveedores.RazonSocial as [Proveedor],
 Recepciones.FechaRecepcion as [Fecha],
 Recepciones.Anulada as [Anulada],
 Case 	When Pedidos.SubNumero is not null 
	Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4)
	Else str(Pedidos.NumeroPedido,8)
 End as [Pedido],
 dbo.Recepciones_Requerimientos(Recepciones.IdRecepcion) as [RM's],
 dbo.Recepciones_Solicitantes(Recepciones.IdRecepcion) as [Solicitantes RM's],
 Acopios.Nombre as [Nombre LA],
 E1.Nombre as [Realizo],
 Recepciones.Anulada as [Anulada1],
 Recepciones.IdRecepcion as [IdAux1],
 Recepciones.Observaciones as [Observaciones],
 E2.Nombre as [Confecciono],
 Recepciones.FechaIngreso as [Fecha ing.],
 E3.Nombre as [Modifico],
 Recepciones.FechaUltimaModificacion as [Fecha Ult.Modif.],
 E4.Nombre as [Anulo],
 Recepciones.FechaAnulacion as [Fecha anulacion],
 Recepciones.MotivoAnulacion as [Motivo anulacion],
 Recepciones.NumeroPesada as [Nro.Pesada],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
LEFT OUTER JOIN Empleados E1 ON E1.IdEmpleado=Recepciones.Realizo
LEFT OUTER JOIN Empleados E2 ON E2.IdEmpleado=Recepciones.IdUsuarioIngreso
LEFT OUTER JOIN Empleados E3 ON E3.IdEmpleado=Recepciones.IdUsuarioModifico
LEFT OUTER JOIN Empleados E4 ON E4.IdEmpleado=Recepciones.IdUsuarioAnulo
ORDER BY FechaRecepcion,Proveedores.RazonSocial