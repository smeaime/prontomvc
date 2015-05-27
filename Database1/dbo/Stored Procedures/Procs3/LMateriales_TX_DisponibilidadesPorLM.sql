
CREATE  Procedure [dbo].[LMateriales_TX_DisponibilidadesPorLM]

@IdLMateriales int

AS 

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111111111111133'
set @vector_T='00012111152242243554500'

SELECT 
	Tmp.IdDetalleLMateriales,
	Tmp.NumeroItem as [Conj.],
	Tmp.NumeroOrden as [Pos.],
	Tmp.NumeroLMateriales as [Numero],
	CASE 	WHEN Tmp.IdArticulo is null THEN Tmp.Detalle COLLATE SQL_Latin1_General_CP1_CI_AS
		ELSE SPACE(10)+Articulos.Descripcion 
	END as [Subconjunto / Articulo],
	Tmp.Cantidad as [Cant.],
	(SELECT Unidades.Descripcion
	 FROM Unidades
	 WHERE Unidades.IdUnidad=Tmp.IdUnidadLM) as  [Unidad (LM)],
	Tmp.Cantidad1 as [Med.1],
	Tmp.Cantidad2 as [Med.2],
	Tmp.FechaNecesidad as [Fec.necesidad],
	Tmp.NumeroRequerimiento as [Nro.RM],
	Tmp.CantidadRequerida as [Cant.req.],
	Case 	When Tmp.SubNumeroPedido is not null 
		Then str(Tmp.NumeroPedido,8)+' / '+str(Tmp.SubNumeroPedido,4)
		Else str(Tmp.NumeroPedido,8)
	End as [Nro.pedido],
	Tmp.CantidadPedida as [Cant.pedida],
	(SELECT Unidades.Descripcion
	 FROM Unidades
	 WHERE Unidades.IdUnidad=Tmp.IdUnidadNP) as  [Unidad (NP)],
	Tmp.FechaEntrega as [Fec.entrega],
	Tmp.CantidadRecibida as [Cant.recibida],
	Tmp.FechaRecepcion as [Fec.recepcion],
	Tmp.CantidadAControlar as [Stock en calidad],
	Tmp.CantidadValesEmitidos as [Vales pedidos],
	Tmp.CantidadValesEntregados as [Vales entregados],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM _TempDisponibilidadMaterialesPorLM Tmp
LEFT OUTER JOIN Articulos ON Tmp.IdArticulo = Articulos.IdArticulo
ORDER BY Tmp.IdDetalleLMateriales,Tmp.Codigo,Tmp.NumeroItem,Tmp.NumeroOrden
