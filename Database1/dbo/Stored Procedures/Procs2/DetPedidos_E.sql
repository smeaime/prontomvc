



CREATE Procedure [dbo].[DetPedidos_E]

@IdDetallePedido int  

AS 

DECLARE @IdDetalleRequerimiento int, @Cantidad numeric(18,2), @IdRequerimiento int 

SET @IdDetalleRequerimiento=IsNull((Select Top 1 DetPed.IdDetalleRequerimiento
					From DetallePedidos DetPed
					Where DetPed.IdDetallePedido = @IdDetallePedido),0)

DELETE DetallePedidos
WHERE (IdDetallePedido=@IdDetallePedido)

IF @IdDetalleRequerimiento<>0
   BEGIN
	SET @Cantidad=IsNull((Select Sum(IsNull(DetPed.Cantidad,0))
				From DetallePedidos DetPed
				Left Outer Join Pedidos On DetPed.IdPedido=Pedidos.IdPedido
				Where IsNull(DetPed.IdDetalleRequerimiento,0)=@IdDetalleRequerimiento and 
					IsNull(DetPed.Cumplido,'NO')<>'AN' and 
					IsNull(Pedidos.Cumplido,'NO')<>'AN'),0)

	SET @IdRequerimiento=IsNull((Select Top 1 DetReq.IdRequerimiento
					From DetalleRequerimientos DetReq
					Where DetReq.IdDetalleRequerimiento=@IdDetalleRequerimiento),0)
	
	UPDATE DetalleRequerimientos
	SET Cumplido=Null
	WHERE DetalleRequerimientos.IdDetalleRequerimiento=@IdDetalleRequerimiento and 
		IsNull(DetalleRequerimientos.Cumplido,'NO')<>'AN'

	UPDATE DetalleRequerimientos
	SET Cumplido='SI'
	WHERE DetalleRequerimientos.IdDetalleRequerimiento=@IdDetalleRequerimiento and 
		IsNull(DetalleRequerimientos.Cumplido,'NO')<>'AN' and Cantidad<=@Cantidad

	UPDATE Requerimientos
	SET Cumplido=Null
	WHERE Requerimientos.IdRequerimiento=@IdRequerimiento and 
		IsNull(Requerimientos.Cumplido,'NO')<>'AN'
	
	UPDATE Requerimientos
	SET Cumplido='SI'
	WHERE Requerimientos.IdRequerimiento=@IdRequerimiento and 
		IsNull(Requerimientos.Cumplido,'NO')<>'AN' and 
		not exists(Select Top 1 DetReq.IdRequerimiento
				From DetalleRequerimientos DetReq
				Where DetReq.IdRequerimiento=@IdRequerimiento and 
					(IsNull(DetReq.Cumplido,'NO')='NO' or IsNull(DetReq.Cumplido,'NO')='PA'))
   END


