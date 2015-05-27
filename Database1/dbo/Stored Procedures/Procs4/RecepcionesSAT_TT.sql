
CREATE  Procedure [dbo].[RecepcionesSAT_TT]

AS 

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0111111133'
SET @vector_T='0552430200'

SELECT 
 Rec.IdRecepcion,
 Rec.NumeroRecepcionAlmacen as [Nro.recep.alm.],
 Case 	When Rec.SubNumero is not null 
	 Then Substring(Substring('0000',1,4-Len(Convert(varchar,Rec.NumeroRecepcion1)))+
			Convert(varchar,Rec.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Rec.NumeroRecepcion2)))+
			Convert(varchar,Rec.NumeroRecepcion2)+'/'+
			Convert(varchar,Rec.SubNumero) ,1,20) 
	 Else Substring(Substring('0000',1,4-Len(Convert(varchar,Rec.NumeroRecepcion1)))+
			Convert(varchar,Rec.NumeroRecepcion1)+'-'+
			Substring('00000000',1,8-Len(Convert(varchar,Rec.NumeroRecepcion2)))+
			Convert(varchar,Rec.NumeroRecepcion2),1,20) 
 End as [Comprobante],
 Proveedores.RazonSocial as [Proveedor],
 Rec.FechaRecepcion as [Fecha],
 Rec.Anulada,
 (Select Top 1 Empleados.Nombre
  from Empleados
  Where Empleados.IdEmpleado=Rec.Realizo) as [Realizo],
 ArchivosATransmitirDestinos.Descripcion as [Origen],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM RecepcionesSAT Rec 
LEFT OUTER JOIN Proveedores ON Rec.IdProveedor = Proveedores.IdProveedor
LEFT OUTER JOIN ArchivosATransmitirDestinos ON Rec.IdOrigenTransmision = ArchivosATransmitirDestinos.IdArchivoATransmitirDestino
ORDER BY Rec.FechaRecepcion,Proveedores.RazonSocial
