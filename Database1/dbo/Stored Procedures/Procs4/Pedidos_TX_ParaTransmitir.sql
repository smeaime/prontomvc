CREATE PROCEDURE [dbo].[Pedidos_TX_ParaTransmitir]

@IdObra int,
@Tipo varchar(20) = Null

AS

SET @Tipo=IsNull(@Tipo,'')

SELECT Pedidos.* 
FROM Pedidos 
WHERE IsNull(Pedidos.Transmitir_a_SAT,'SI')='SI' and Pedidos.Aprobo is not null and 
	(IsNull(Pedidos.Cumplido,'')<>'SI' or @Tipo='BALANZA') and 
	EXISTS(Select Top 1 DetPed.IdPedido
		  From DetallePedidos DetPed
		  Left Outer Join DetalleAcopios On DetPed.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
		  Left Outer Join Acopios On DetalleAcopios.IdAcopio = Acopios.IdAcopio
		  Left Outer Join DetalleRequerimientos On DetPed.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
		  Left Outer Join Requerimientos On DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
		  Where DetPed.IdPedido=Pedidos.IdPedido and DetPed.EnviarEmail=1 and (@IdObra=0 or IsNull(Acopios.IdObra,-1)=@IdObra or IsNull(Requerimientos.IdObra,-1)=@IdObra))