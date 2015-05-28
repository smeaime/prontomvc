CREATE PROCEDURE [dbo].[DetPedidos_TX_ParaTransmitir]

@IdObra int,
@Tipo varchar(20) = Null

AS

SET NOCOUNT ON

SET @Tipo=IsNull(@Tipo,'')

UPDATE DetallePedidos
SET IdDetalleRequerimientoOriginal=(Select Top 1 DetReq.IdDetalleRequerimientoOriginal From DetalleRequerimientos DetReq Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento)
WHERE DetallePedidos.EnviarEmail=1 and 
	(Select Top 1 DetReq.IdDetalleRequerimientoOriginal
	 From DetalleRequerimientos DetReq
	 Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento) is not null and 
	IsNull((Select Top 1 Requerimientos.IdObra
		From DetalleRequerimientos DetReq
		Left Outer Join Requerimientos On DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
		Where DetallePedidos.IdDetalleRequerimiento=DetReq.IdDetalleRequerimiento),0)=@IdObra

SET NOCOUNT OFF

SELECT DetPed.* 
FROM DetallePedidos DetPed
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
LEFT OUTER JOIN DetalleAcopios ON DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
LEFT OUTER JOIN Acopios ON DetalleAcopios.IdAcopio = Acopios.IdAcopio
LEFT OUTER JOIN DetalleRequerimientos ON DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE DetPed.EnviarEmail=1 and Pedidos.Aprobo is not null and 
	(IsNull(Pedidos.Cumplido,'')<>'SI' or @Tipo='BALANZA') and 
	(@IdObra=0 or IsNull(Acopios.IdObra,-1)=@IdObra or IsNull(Requerimientos.IdObra,-1)=@IdObra) and 
	IsNull(Pedidos.Transmitir_a_SAT,'SI')='SI'
ORDER by DetPed.NumeroItem