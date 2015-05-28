
CREATE Procedure [dbo].[Pedidos_TX_DetallesPedidosRecepcionesLMaterialesPorObra]

@IdObra int

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecepcionada NUMERIC(18,2),
			 CantidadLMateriales NUMERIC(18,2)
			)
INSERT INTO #Auxiliar0 
 SELECT Det.IdArticulo, Det.IdUnidad, Sum(IsNull(Det.Cantidad,0)), 0, 0
 FROM DetallePedidos Det
 LEFT OUTER JOIN Pedidos ON Det.IdPedido = Pedidos.IdPedido
 LEFT OUTER JOIN DetalleRequerimientos ON Det.IdDetalleRequerimiento = DetalleRequerimientos.IdDetalleRequerimiento
 LEFT OUTER JOIN Requerimientos ON DetalleRequerimientos.IdRequerimiento = Requerimientos.IdRequerimiento
 WHERE IsNull(Pedidos.Cumplido,'NO')<>'AN' and IsNull(Det.Cumplido,'NO')<>'AN' and (@IdObra=-1 or Requerimientos.IdObra=@IdObra)
 GROUP BY Det.IdArticulo, Det.IdUnidad

INSERT INTO #Auxiliar0 
 SELECT Det.IdArticulo, Det.IdUnidad, 0, 0, 0
 FROM DetalleLMateriales Det
 LEFT OUTER JOIN LMateriales ON Det.IdLMateriales = LMateriales.IdLMateriales
 WHERE (@IdObra=-1 or LMateriales.IdObra=@IdObra)

CREATE TABLE #Auxiliar1 
			(
			 IdArticulo INTEGER,
			 IdUnidad INTEGER,
			 CantidadPedida NUMERIC(18,2),
			 CantidadRecepcionada NUMERIC(18,2),
			 CantidadLMateriales NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT IdArticulo, IdUnidad, Sum(CantidadPedida), 0, 0
 FROM #Auxiliar0
 GROUP BY IdArticulo, IdUnidad

UPDATE #Auxiliar1
SET CantidadRecepcionada=IsNull((Select Sum(IsNull(Det.Cantidad,0)) 
				 From DetalleRecepciones Det 
				 Left Outer Join Recepciones On Det.IdRecepcion=Recepciones.IdRecepcion
				 Where IsNull(Recepciones.Anulada,'NO')<>'SI' and 
					Det.IdArticulo=#Auxiliar1.IdArticulo and 
					(@IdObra=-1 or Det.IdObra=@IdObra)),0)
UPDATE #Auxiliar1
SET CantidadLMateriales=IsNull((Select Sum(IsNull(Det.Cantidad,0)) 
				From DetalleLMateriales Det 
				Left Outer Join LMateriales On Det.IdLMateriales=LMateriales.IdLMateriales
				Where Det.IdArticulo=#Auxiliar1.IdArticulo and (@IdObra=-1 or LMateriales.IdObra=@IdObra)),0)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='01111111111111133'
SET @vector_T='0112E133333333300'

SELECT 
 0 as [IdAux],
 Rubros.Descripcion as [Rubro],
 Subrubros.Descripcion as [Subrubro],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Unidades.Abreviatura as [Unidad],
 #Auxiliar1.CantidadPedida as [CantidadPedida],
 Articulos.CostoPPP as [CostoPPP],
 #Auxiliar1.CantidadPedida * Articulos.CostoPPP as [TotalCostoPPP_Pedidos],
 #Auxiliar1.CantidadRecepcionada as [CantidadRecepcionada],
 Articulos.CostoPPP as [CostoPPP],
 #Auxiliar1.CantidadRecepcionada * Articulos.CostoPPP as [TotalCostoPPP_Recepciones],
 #Auxiliar1.CantidadLMateriales as [CantidadLMateriales],
 Articulos.CostoReposicion as [CostoReposicion],
 #Auxiliar1.CantidadLMateriales * Articulos.CostoReposicion as [TotalCostoPPP_LMateriales],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1
LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
LEFT OUTER JOIN Subrubros ON Articulos.IdSubrubro = Subrubros.IdSubrubro
LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
ORDER BY Articulos.Descripcion

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
