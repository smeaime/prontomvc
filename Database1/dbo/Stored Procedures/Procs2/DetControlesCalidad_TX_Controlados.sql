

CREATE PROCEDURE [dbo].[DetControlesCalidad_TX_Controlados]

AS

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='01111111111111133'
Set @vector_T='0E92H244112434100'

SELECT
 DetCal.IdDetalleControlCalidad,
 Articulos.Descripcion as [Articulo],
 DetCal.IdDetalleControlCalidad as [IdAux1],
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
 End as [Nro.recep.alm.],
 Case When DetCal.IdDetalleRecepcion is not null
	Then Recepciones.FechaRecepcion 
	Else OtrosIngresosAlmacen.FechaOtroIngresoAlmacen
 End as [Fecha Comprob.],
 DetCal.fecha as [Fecha control],
 DetCal.Cantidad as [Cantidad],
 DetCal.CantidadRechazada as [Cant.rech.],
 MotivosRechazo.Descripcion as [Motivo],
 DetCal.Trasabilidad as [Trasabilidad],
 DetCal.NumeroRemitoRechazo as [Nro.Rem.Rechazo],
 DetCal.FechaRemitoRechazo as [Fecha remito],
 DetCal.Observaciones as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleControlesCalidad DetCal
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetCal.IdDetalleRecepcion=DetRec.IdDetalleRecepcion
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
LEFT OUTER JOIN DetalleOtrosIngresosAlmacen DetOtr ON DetCal.IdDetalleOtroIngresoAlmacen=DetOtr.IdDetalleOtroIngresoAlmacen
LEFT OUTER JOIN OtrosIngresosAlmacen ON DetOtr.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
LEFT OUTER JOIN Articulos ON IsNull(DetRec.IdArticulo,DetOtr.IdArticulo) = Articulos.IdArticulo
LEFT OUTER JOIN MotivosRechazo ON DetCal.IdMotivoRechazo=MotivosRechazo.IdMotivoRechazo
WHERE IsNull(DetRec.Controlado,IsNull(DetOtr.Controlado,''))='DI'
ORDER by [Fecha control], [Numero]

