
CREATE Procedure [dbo].[LMateriales_CalcularFaltantes]

@IdObra int

AS

Declare @IdObraStockDisponible int
Set @IdObraStockDisponible=(Select Top 1 Parametros.IdObraStockDisponible 
				From Parametros
				Where Parametros.IdParametro=1)

TRUNCATE TABLE _TempSaldoItemsLM

INSERT INTO _TempSaldoItemsLM
 SELECT 
	DetLMat.IdDetalleLMateriales,
	LMat.IdLMateriales,
	LMat.Nombre,
	LMat.NumeroLMateriales,
	Equipos.Tag,
	DetLMat.NumeroOrden,
	LMat.Fecha,
	DetLMat.IdArticulo,
	DetLMat.Cantidad,
	DetLMat.Cantidad1,
	DetLMat.Cantidad2,
	Case 	When 	(Select Sum(DetAco.Cantidad) From DetalleAcopios DetAco 
			 Where DetAco.idDetalleAcopios=DetLMat.idDetalleAcopios and 
				(DetAco.Cumplido is null or DetAco.Cumplido<>'AN')) is null 
		Then 	0
		Else 	(Select Sum(DetAco.Cantidad) From DetalleAcopios DetAco 
			 Where DetAco.idDetalleAcopios=DetLMat.idDetalleAcopios and 
				(DetAco.Cumplido is null or DetAco.Cumplido<>'AN'))
	End,
	Case 	When 	(Select Sum(DetReq.Cantidad) From DetalleRequerimientos DetReq 
			 Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
			 Where DetReq.IdDetalleLMateriales=DetLMat.IdDetalleLMateriales and 
				(DetReq.Cumplido is null or DetReq.Cumplido<>'AN') and 
				(Requerimientos.Cumplido is null or Requerimientos.Cumplido<>'AN')) is null 
		Then 	0
		Else 	(Select Sum(DetReq.Cantidad) From DetalleRequerimientos DetReq 
			 Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=DetReq.IdRequerimiento
			 Where DetReq.IdDetalleLMateriales=DetLMat.IdDetalleLMateriales and 
				(DetReq.Cumplido is null or DetReq.Cumplido<>'AN') and 
				(Requerimientos.Cumplido is null or Requerimientos.Cumplido<>'AN'))
	End,
0,
/*
	Case 	When 	(Select Sum(DetRes.CantidadUnidades) From DetalleReservas DetRes 
			 Where DetRes.IdDetalleLMateriales=DetLMat.IdDetalleLMateriales) is null 
		Then 	0
		Else 	(Select Sum(DetRes.CantidadUnidades) From DetalleReservas DetRes 
			 Where DetRes.IdDetalleLMateriales=DetLMat.IdDetalleLMateriales)
	End + 
	Case 	When 	(Select Sum(Stock.CantidadUnidades) 
			 From Stock
			 Where Stock.IdArticulo=DetLMat.IdArticulo and Stock.IdObra=LMat.IdObra) is null 
		Then 	0
		Else 	(Select Sum(Stock.CantidadUnidades) 
			 From Stock
			 Where Stock.IdArticulo=DetLMat.IdArticulo and Stock.IdObra=LMat.IdObra)
	End,
*/
	(Select Sum(Stock.CantidadUnidades) 
	 From Stock
	 Where Stock.IdArticulo=DetLMat.IdArticulo and Stock.IdObra=@IdObraStockDisponible),
	(Select Sum(Stock.CantidadUnidades) 
	 From Stock
	 Where 	Stock.IdArticulo=DetLMat.IdArticulo and 
		Stock.IdObra<>@IdObraStockDisponible and 
		Stock.IdObra<>LMat.IdObra),
	DetLMat.Observaciones
 FROM DetalleLMateriales DetLMat
 LEFT OUTER JOIN LMateriales LMat ON DetLMat.IdLMateriales = LMat.IdLMateriales
 LEFT OUTER JOIN Equipos ON LMat.IdEquipo = Equipos.IdEquipo
 WHERE (not DetLMat.IdArticulo is null and LMat.IdObra=@IdObra)
