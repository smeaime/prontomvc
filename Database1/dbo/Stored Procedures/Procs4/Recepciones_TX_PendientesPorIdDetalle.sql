
CREATE PROCEDURE [dbo].[Recepciones_TX_PendientesPorIdDetalle]
@IdDetRec int,
@IdDetPed int,
@IdDetReq int,
@IdDetAco int
AS
SELECT
CASE	
	WHEN 	@IdDetPed>0
	 THEN 	(Select DetPed.Cantidad
		 From DetallePedidos DetPed
		 Where DetPed.IdDetallePedido=@IdDetPed)
	WHEN 	@IdDetReq>0
	 THEN 	(Select DetReq.Cantidad
		 From DetalleRequerimientos DetReq
		 Where DetReq.IdDetalleRequerimiento=@IdDetReq)
	WHEN 	@IdDetAco>0
	 THEN 	(Select DetAco.Cantidad
		 From DetalleAcopios DetAco
		 Where DetAco.IdDetalleAcopios=@IdDetAco)
	 ELSE 	0
End as [Cant.Orig.],
CASE	
	WHEN 	@IdDetPed>0
	 THEN 	(Select Sum(DetRec.Cantidad)
		 From DetalleRecepciones DetRec
		 Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
		 Where DetRec.IdDetalleRecepcion<>@IdDetRec And DetRec.IdDetallePedido=@IdDetPed and 
			IsNull(Recepciones.Anulada,'NO')<>'SI') 
	WHEN 	@IdDetReq>0
	 THEN 	(Select Sum(DetRec.Cantidad)
		 From DetalleRecepciones DetRec
		 Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
		 Where DetRec.IdDetalleRecepcion<>@IdDetRec And DetRec.IdDetalleRequerimiento=@IdDetReq and 
			IsNull(Recepciones.Anulada,'NO')<>'SI') 
	WHEN 	@IdDetAco>0
	 THEN 	(Select Sum(DetRec.Cantidad)
		 From DetalleRecepciones DetRec
		 Left Outer Join Recepciones On DetRec.IdRecepcion=Recepciones.IdRecepcion
		 Where DetRec.IdDetalleRecepcion<>@IdDetRec And DetRec.IdDetalleAcopios=@IdDetAco and 
			IsNull(Recepciones.Anulada,'NO')<>'SI')  
	 ELSE 	0
End as [Recibido]
