
CREATE PROCEDURE [dbo].[LMateriales_TX_Faltantes]

@IdLMateriales int

AS

declare @vector_X varchar(30),@vector_T varchar(30)
set @vector_X='01111111111011111433'
set @vector_T='01190111292099224900'

SELECT
	Tmp.IdDetalleLMateriales,
	Tmp.Nombre as [LM],
	Tmp.NumeroLMateriales as [Nro. LM],
	Tmp.Tag,
	Tmp.NumeroItem as [Item],
	Tmp.Cantidad,
	Tmp.Cantidad1 as [Med.1],
	Tmp.Cantidad2 as [Med.2],
	Case When Tmp.RM=0 Then Null Else Tmp.RM End as [En RM's],
	Case When Tmp.RS=0 Then Null Else Tmp.RS End as [Stock obra],
	Tmp.Cantidad-Tmp.LA-Tmp.RM-Tmp.RS as [Faltante],
	Tmp.IdArticulo,
	Case When Tmp.StockDisponible=0 Then Null Else Tmp.StockDisponible End as [Stock Disp.],
	Case When Tmp.StockEnOtrasObras=0 Then Null Else Tmp.StockEnOtrasObras End as [Stock otras obras],
	Articulos.Codigo as [Codigo],
	Articulos.Descripcion as [Material],
	Tmp.Fecha as [Fecha LM],
	Tmp.Observaciones,
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM _TempSaldoItemsLM Tmp
LEFT OUTER JOIN Articulos ON Tmp.IdArticulo=Articulos.IdArticulo
WHERE  Tmp.Cantidad-Tmp.LA-Tmp.RM-Tmp.RS>0 and 
	(@IdLMateriales=-1 or @IdLMateriales=Tmp.IdLMateriales)
ORDER by Tmp.NumeroLMateriales,Tmp.NumeroItem
