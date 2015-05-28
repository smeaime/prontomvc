CREATE  Procedure [dbo].[Recepciones_TX_Todos]

@IdObraAsignadaUsuario int = Null,
@Desde datetime = Null,
@Hasta datetime = Null,
@IdObra int = Null,
@SoloPesadas varchar(2) = Null,
@IdUsuario int = Null

AS 

SET NOCOUNT ON

SET @IdObraAsignadaUsuario=IsNull(@IdObraAsignadaUsuario,-1)
SET @Desde=IsNull(@Desde,Convert(datetime,'01/01/1980',103))
SET @Hasta=IsNull(@Hasta,Convert(datetime,'31/12/2020',103))
SET @IdObra=IsNull(@IdObra,-1)
SET @SoloPesadas=IsNull(@SoloPesadas,'')
SET @IdUsuario=IsNull(@IdUsuario,-1)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='011111111111111111111133'
SET @vector_T='0552435GA909931414143300'

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
WHERE (@IdObraAsignadaUsuario=-1 or Exists(Select Top 1 Det.IdRecepcion From DetalleRecepciones Det Where IsNull(Det.IdObra,0)=@IdObraAsignadaUsuario and Recepciones.IdRecepcion=Det.IdRecepcion)) and 
	IsNull(Recepciones.Anulada,'NO')<>'SI' and Recepciones.FechaRecepcion Between @Desde and @Hasta and 
	(@IdObra=-1 or Exists(Select Top 1 Det.IdRecepcion From DetalleRecepciones Det Where IsNull(Det.IdObra,0)=@IdObra and Recepciones.IdRecepcion=Det.IdRecepcion)) and 
	(@SoloPesadas='' or (@SoloPesadas='SI' and IsNull(Recepciones.NumeroPesada,0)>0)) and 
	(@IdUsuario=-1 or IsNull((Select Top 1 e.PermitirAccesoATodasLasObras From Empleados e Where e.IdEmpleado=@IdUsuario),'SI')='SI' or 
	 Exists(Select Top 1 deo.IdObra From DetalleEmpleadosObras deo Where deo.IdEmpleado=@IdUsuario and Patindex('%('+Convert(varchar,deo.IdObra)+')%', dbo.Recepciones_IdObras(Recepciones.IdRecepcion))<>0))
ORDER BY FechaRecepcion,Proveedores.RazonSocial