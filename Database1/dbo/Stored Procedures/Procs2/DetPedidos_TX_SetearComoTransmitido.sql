CREATE Procedure [dbo].[DetPedidos_TX_SetearComoTransmitido]

@IdObra int = Null

AS

SET @IdObra=IsNull(@IdObra,-1)

UPDATE DetallePedidos
SET EnviarEmail=0
WHERE EnviarEmail<>0 and 
	(Select Top 1 Pedidos.Aprobo From Pedidos Where DetallePedidos.IdPedido=Pedidos.IdPedido) is not null and 
	(@IdObra<=0 or IsNull((Select Top 1 R.IdObra From DetalleRequerimientos DR 
				Left Outer Join Requerimientos R On R.IdRequerimiento=DR.IdRequerimiento
				Where DetallePedidos.IdDetalleRequerimiento = DR.IdDetalleRequerimiento),-1)=@IdObra)