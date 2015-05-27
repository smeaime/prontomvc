

CREATE PROCEDURE [dbo].[DetControlesCalidad_TX_ConDatos]

@IdDetalleControlCalidad int

AS

SELECT
 DetCal.IdDetalleControlCalidad,
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Case When DetCal.IdDetalleRecepcion is not null
	Then 'Recepcion' 
	Else 'Otros Ing.' 
 End as [Tipo],
 Case When DetCal.IdDetalleRecepcion is not null
	Then 	Case When Recepciones.SubNumero is not null 
			Then Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
				Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
				Convert(varchar,Recepciones.NumeroRecepcion2)+'/'+
				Convert(varchar,Recepciones.SubNumero) ,1,20) 
			Else Substring(Substring('0000',1,4-Len(Convert(varchar,Recepciones.NumeroRecepcion1)))+
				Convert(varchar,Recepciones.NumeroRecepcion1)+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,Recepciones.NumeroRecepcion2)))+
				Convert(varchar,Recepciones.NumeroRecepcion2),1,20) 
		End 
	Else
		Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+
			Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)
 End as [Numero],
 Case When DetCal.IdDetalleRecepcion is not null
	Then Recepciones.NumeroRecepcionAlmacen 
	Else Null
 End as [NumeroRecepcionAlmacen],
 Case When DetCal.IdDetalleRecepcion is not null
	Then Recepciones.FechaRecepcion 
	Else OtrosIngresosAlmacen.FechaOtroIngresoAlmacen
 End as [FechaComprobante],
 DetCal.fecha as [FechaControl],
 DetCal.Cantidad,
 DetCal.CantidadRechazada,
 Unidades.Abreviatura as [Unidad],
 MotivosRechazo.Descripcion as [Motivo],
 DetCal.Trasabilidad as [Trasabilidad],
 DetCal.NumeroRemitoRechazo,
 DetCal.FechaRemitoRechazo,
 Proveedores.RazonSocial as [Proveedor],
 DetCal.Observaciones
FROM DetalleControlesCalidad DetCal
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCal.IdDetalleRecepcion=DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetalleOtrosIngresosAlmacen DetOtr ON DetCal.IdDetalleOtroIngresoAlmacen=DetOtr.IdDetalleOtroIngresoAlmacen
LEFT OUTER JOIN OtrosIngresosAlmacen ON DetOtr.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
LEFT OUTER JOIN Articulos ON IsNull(DetRec.IdArticulo,DetOtr.IdArticulo) = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON IsNull(DetRec.IdUnidad,DetOtr.IdUnidad) = Unidades.IdUnidad
LEFT OUTER JOIN MotivosRechazo ON DetCal.IdMotivoRechazo=MotivosRechazo.IdMotivoRechazo
LEFT OUTER JOIN Proveedores ON DetCal.IdProveedorRechazo=Proveedores.IdProveedor
WHERE DetCal.IdDetalleControlCalidad=@IdDetalleControlCalidad
ORDER by [FechaControl], [Numero]

