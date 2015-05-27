CREATE Procedure [dbo].[Stock_TX_Control_Reposicion_Minimo]

@TipoControl varchar(1) = Null,
@IdObra int = Null

AS

SET NOCOUNT ON

SET @TipoControl=IsNull(@TipoControl,'A')
SET @IdObra=IsNull(@IdObra,-1)

CREATE TABLE #Auxiliar1	
			(
			 IdArticulo INTEGER,
			 StockReposicion NUMERIC(18,2),
			 StockMinimo NUMERIC(18,2),
			 StockActual NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT Articulos.IdArticulo, IsNull(Articulos.StockReposicion,0), IsNull(Articulos.StockMinimo,0), 
		IsNull((Select Sum(IsNull(Stock.CantidadUnidades,0)) From Stock Where Stock.IdArticulo=Articulos.IdArticulo and (@IdObra=-1 or Stock.IdObra=@IdObra)),0)
	
 FROM Articulos 

CREATE TABLE #Auxiliar2	
			(
			 IdArticulo INTEGER,
			 StockActual NUMERIC(18,2),
			 StockMinimo NUMERIC(18,2),
			 FaltanteMinimo NUMERIC(18,2),
			 StockReposicion NUMERIC(18,2),
			 FaltanteReposicion NUMERIC(18,2),
			 CantidadEnRM NUMERIC(18,2),
			 CantidadEnNP NUMERIC(18,2),
			 CantidadEnRE NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdArticulo, #Auxiliar1.StockActual, #Auxiliar1.StockMinimo, Null, #Auxiliar1.StockReposicion, Null, Null, Null, Null
 FROM #Auxiliar1
 WHERE  ((@TipoControl='A' or @TipoControl='R') and #Auxiliar1.StockReposicion>0 and #Auxiliar1.StockActual<=#Auxiliar1.StockReposicion) or 
		((@TipoControl='A' or @TipoControl='M') and #Auxiliar1.StockMinimo>0 and #Auxiliar1.StockActual<=#Auxiliar1.StockMinimo)

UPDATE #Auxiliar2
SET FaltanteMinimo=StockMinimo-StockActual
WHERE StockMinimo-StockActual>0

UPDATE #Auxiliar2
SET FaltanteReposicion=StockReposicion-StockActual
WHERE StockReposicion-StockActual>0

UPDATE #Auxiliar2
SET CantidadEnRM=(Select Sum(IsNull(dr.Cantidad,0))
					From DetalleRequerimientos dr
					Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=dr.IdRequerimiento
					Where dr.IdArticulo=#Auxiliar2.IdArticulo and IsNull(dr.Cumplido,'NO')<>'AN' and IsNull(dr.Cumplido,'NO')<>'SI' and 
							IsNull(dr.IdDioPorCumplido,0)=0 and IsNull(Requerimientos.Cumplido,'NO')<>'AN' and IsNull(Requerimientos.Confirmado,'SI')='SI' and 
							(@IdObra=-1 or Requerimientos.IdObra=@IdObra))

UPDATE #Auxiliar2
SET CantidadEnNP=(Select Sum(IsNull(dp.Cantidad,0))
					From DetallePedidos dp 
					Left Outer Join Pedidos On Pedidos.IdPedido=dp.IdPedido
					Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento=dp.IdDetalleRequerimiento
					Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=dr.IdRequerimiento
					Where IsNull(dr.IdArticulo,0)=#Auxiliar2.IdArticulo and Requerimientos.IdRequerimiento is not null and 
							IsNull(dr.Cumplido,'NO')<>'AN' and IsNull(dr.IdDioPorCumplido,0)=0 and 
							IsNull(Requerimientos.Cumplido,'NO')<>'AN' and IsNull(Requerimientos.Confirmado,'SI')='SI' and 
							IsNull(dp.IdDioPorCumplido,0)=0 and IsNull(dp.Cumplido,'NO')<>'AN' and IsNull(Pedidos.Cumplido,'NO')<>'AN' and 
							(@IdObra=-1 or Requerimientos.IdObra=@IdObra))

UPDATE #Auxiliar2
SET CantidadEnRE=(Select Sum(IsNull(dr2.Cantidad,0))
					From DetalleRecepciones dr2 
					Left Outer Join Recepciones On Recepciones.IdRecepcion=dr2.IdRecepcion
					Left Outer Join DetalleRequerimientos dr On dr.IdDetalleRequerimiento=dr2.IdDetalleRequerimiento
					Left Outer Join Requerimientos On Requerimientos.IdRequerimiento=dr.IdRequerimiento
					Where IsNull(dr.IdArticulo,0)=#Auxiliar2.IdArticulo and Requerimientos.IdRequerimiento is not null and 
							IsNull(dr.Cumplido,'NO')<>'AN' and IsNull(dr.IdDioPorCumplido,0)=0 and IsNull(Recepciones.Anulada,'NO')<>'SI' and 
							IsNull(Requerimientos.Cumplido,'NO')<>'AN' and IsNull(Requerimientos.Confirmado,'SI')='SI' and (@IdObra=-1 or Requerimientos.IdObra=@IdObra))

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111133'
SET @vector_T='019D333335500'

SELECT 
 #Auxiliar2.IdArticulo as [IdArticulo], 
 Articulos.Codigo as [Codigo], 
 #Auxiliar2.IdArticulo as [IdArticuloFaltante], 
 Articulos.Descripcion as [Articulo],
 #Auxiliar2.StockActual as [Stock actual],
 #Auxiliar2.StockMinimo as [Stock min.],
 #Auxiliar2.FaltanteMinimo as [Faltante min.],
 #Auxiliar2.StockReposicion as [Stock rep.],
 #Auxiliar2.FaltanteReposicion as [Faltante rep.],
 #Auxiliar2.CantidadEnRM as [Rm's pendientes],
 Case When IsNull(#Auxiliar2.CantidadEnNP,0)-IsNull(#Auxiliar2.CantidadEnRE,0)>0 Then IsNull(#Auxiliar2.CantidadEnNP,0)-IsNull(#Auxiliar2.CantidadEnRE,0) Else Null End as [Pedidos pendientes],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo=Articulos.IdArticulo
ORDER BY Articulos.Codigo, Articulos.Descripcion

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
