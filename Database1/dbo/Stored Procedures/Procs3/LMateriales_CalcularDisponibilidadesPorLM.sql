


CREATE Procedure [dbo].[LMateriales_CalcularDisponibilidadesPorLM]

@IdLMateriales int

AS

TRUNCATE TABLE _TempDisponibilidadMaterialesPorLM

INSERT INTO _TempDisponibilidadMaterialesPorLM
SELECT 
	DetLMat.IdDetalleLMateriales,
	10,
	DetLMat.NumeroItem,
	DetLMat.NumeroOrden,
	LMat.NumeroLMateriales,
	DetLMat.IdArticulo,
	DetLMat.Detalle,
	DetLMat.Cantidad,
	DetLMat.IdUnidad,
	DetLMat.Cantidad1,
	DetLMat.Cantidad2,
	DetalleAcopios.FechaNecesidad,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null
FROM DetalleLMateriales DetLMat
LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
LEFT OUTER JOIN DetalleAcopios ON DetLMat.IdDetalleAcopios = DetalleAcopios.IdDetalleAcopios
WHERE DetLMat.IdLMateriales =@IdLMateriales

UNION ALL 

SELECT 
	DetReq.IdDetalleLMateriales,
	20,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Requerimientos.NumeroRequerimiento,
	DetReq.Cantidad,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null
FROM DetalleRequerimientos DetReq
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetReq.IdDetalleLMateriales
LEFT OUTER JOIN Requerimientos ON DetReq.IdRequerimiento = Requerimientos.IdRequerimiento
WHERE DetalleLMateriales.IdLMateriales=@IdLMateriales

UNION ALL 

SELECT 
	DetPed.IdDetalleLMateriales,
	30,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Pedidos.NumeroPedido,
	Pedidos.SubNumero,
	DetPed.Cantidad,
	DetPed.IdUnidad,
	DetPed.FechaEntrega,
	Null,
	Null,
	Null,
	Null,
	Null
FROM DetallePedidos DetPed
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetPed.IdDetalleLMateriales
LEFT OUTER JOIN Pedidos ON DetPed.IdPedido = Pedidos.IdPedido
WHERE DetalleLMateriales.IdLMateriales=@IdLMateriales

UNION ALL 

SELECT 
	DetallePedidos.IdDetalleLMateriales,
	40,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetRec.Cantidad,
	Recepciones.FechaRecepcion,
	Null,
	Null,
	Null
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetallePedidos.IdDetalleLMateriales
LEFT OUTER JOIN recepciones ON DetRec.IdRecepcion=recepciones.IdRecepcion
WHERE DetalleLMateriales.IdLMateriales=@IdLMateriales

UNION ALL 

SELECT 
	DetallePedidos.IdDetalleLMateriales,
	50,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetRec.Cantidad-(DetRec.CantidadCC+DetRec.CantidadRechazadaCC),
	Null,
	Null
FROM DetalleRecepciones DetRec
LEFT OUTER JOIN DetallePedidos ON DetRec.IdDetallePedido = DetallePedidos.IdDetallePedido
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetallePedidos.IdDetalleLMateriales
WHERE DetalleLMateriales.IdLMateriales=@IdLMateriales and (DetRec.Controlado is null or DetRec.Controlado='PA')

UNION ALL 

SELECT 
	DetVal.IdDetalleLMateriales,
	60,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetVal.Cantidad,
	Null
FROM DetalleValesSalida DetVal
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetVal.IdDetalleLMateriales
WHERE DetalleLMateriales.IdLMateriales=@IdLMateriales

UNION ALL 

SELECT 
	DetalleValesSalida.IdDetalleLMateriales,
	70,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	DetSal.Cantidad
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida=DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN DetalleLMateriales ON DetalleLMateriales.IdDetalleLMateriales = DetalleValesSalida.IdDetalleLMateriales
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	DetalleLMateriales.IdLMateriales=@IdLMateriales


