CREATE  Procedure [dbo].[Recepciones_TX_Ultimos3Meses]

@Desde datetime,
@IdObraAsignadaUsuario int = Null,
@IdUsuario int = Null

AS 

SET @IdUsuario=IsNull(@IdUsuario,-1)

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111111111133'
SET @vector_T='0552435399099300'

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)

SELECT 
 Recepciones.IdRecepcion,
 Recepciones.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Case 	When Recepciones.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+Convert(varchar,Recepciones.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
 End as [Comprobante],
 Proveedores.RazonSocial as [Proveedor],
 Recepciones.FechaRecepcion as [Fecha],
 Recepciones.Anulada as [Anulada],
 Case When Pedidos.SubNumero is not null Then str(Pedidos.NumeroPedido,8)+' / '+str(Pedidos.SubNumero,4) Else str(Pedidos.NumeroPedido,8) End as [Pedido],
 Requerimientos.NumeroRequerimiento as [RM],
 Acopios.NumeroAcopio as [Numero LA],
 Acopios.Nombre as [Nombre LA],
 (Select Top 1 Empleados.Nombre from Empleados Where Empleados.IdEmpleado=Recepciones.Realizo) as [Realizo],
 Recepciones.Anulada as [Anulada1],
 Recepciones.IdRecepcion as [IdAux1],
 Recepciones.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM Recepciones
LEFT OUTER JOIN Pedidos ON Recepciones.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN Requerimientos ON Recepciones.IdRequerimiento = Requerimientos.IdRequerimiento
LEFT OUTER JOIN Proveedores ON Recepciones.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN Acopios ON Recepciones.IdAcopio=Acopios.IdAcopio
WHERE FechaRecepcion>=@Desde and 
	(@IdObraAsignadaUsuario=-1 or Exists(Select Top 1 Det.IdRecepcion From DetalleRecepciones Det Where IsNull(Det.IdObra,0)=@IdObraAsignadaUsuario and Recepciones.IdRecepcion=Det.IdRecepcion)) and
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or 
	 Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and Patindex('%('+Convert(varchar,deo.IdObra)+')%', dbo.Recepciones_IdObras(Recepciones.IdRecepcion))<>0))
ORDER BY FechaRecepcion,Proveedores.RazonSocial