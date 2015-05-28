


CREATE PROCEDURE [dbo].[Pedidos_TX_RecepcionesPorIdDetallePedido]

@IdDetallePedido int

AS

SELECT
 DetPed.NumeroItem,
 DetRec.CantidadCC as [CantidadRecibida],
 Recepciones.NumeroRecepcionAlmacen,
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
 Recepciones.FechaRecepcion
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
INNER JOIN DetalleRecepciones DetRec ON DetPed.IdDetallePedido = DetRec.IdDetallePedido
LEFT OUTER JOIN Recepciones ON DetRec.IdRecepcion = Recepciones.IdRecepcion
WHERE DetPed.IdDetallePedido=@IdDetallePedido and IsNull(Recepciones.Anulada,'NO')<>'SI'


