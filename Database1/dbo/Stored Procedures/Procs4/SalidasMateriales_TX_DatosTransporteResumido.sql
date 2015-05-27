
CREATE  Procedure [dbo].[SalidasMateriales_TX_DatosTransporteResumido]

@Desde datetime,
@Hasta datetime,
@IdObra int = Null,
@IdTransportista int = Null,
@IdChofer int = Null,
@NumeroDestino int = Null,
@IdFlete int = Null,
@Valorizado varchar(2) = Null

AS 

SET @IdObra=IsNull(@IdObra,-1)
SET @IdTransportista=IsNull(@IdTransportista,-1)
SET @IdChofer=IsNull(@IdChofer,-1)
SET @NumeroDestino=IsNull(@NumeroDestino,-1)
SET @IdFlete=IsNull(@IdFlete,-1)
SET @Valorizado=IsNull(@Valorizado,'NO')

DECLARE @vector_X varchar(30), @vector_T varchar(30), @Vector_E varchar(500)

SET @vector_X='00011111133'
IF @Valorizado='SI'
	SET @vector_T='0003D133900'
ELSE
	SET @vector_T='0003D139900'
SET @Vector_E='  |  |  | CEN,NUM:#COMMA##0.00 | CUR '

SELECT 
 Articulos.Codigo as [IdAux1],
 Articulos.Descripcion as [IdAux2],
 0 as [IdAux3],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Unidades.Abreviatura as [Unidad],
 Sum(IsNull(DetSal.Cantidad,0)) as [Cant.],
 Sum(IsNull(DetSal.Cantidad,0)*IsNull(DetSal.CostoUnitario,0)) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1=Transportistas.IdTransportista
LEFT OUTER JOIN Fletes ON SalidasMateriales.IdFlete = Fletes.IdFlete
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or DetSal.IdObra=@IdObra) and 
	(@IdTransportista=-1 or SalidasMateriales.IdTransportista1=@IdTransportista) and 
	(@IdChofer=-1 or SalidasMateriales.IdChofer=@IdChofer) and 
	(@NumeroDestino=-1 or SalidasMateriales.NumeroSalidaMateriales2=@NumeroDestino) and 
	(@IdFlete=-1 or SalidasMateriales.IdFlete=@IdFlete)  
GROUP BY Articulos.Codigo, Articulos.Descripcion, Unidades.Abreviatura

UNION ALL

SELECT 
 'zzzzz' as [IdAux1],
 Null as [IdAux1],
 3 as [IdAux3],
 Null as [Codigo],
 Null as [Articulo],
 Null as [Unidad],
 Null as [Cant.],
 Null as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 'zzzzz' as [IdAux1],
 Null as [IdAux1],
 4 as [IdAux3],
 Null as [Codigo],
 Null as [Articulo],
 Null as [Unidad],
 Sum(IsNull(DetSal.Cantidad,0)) as [Cant.],
 Sum(IsNull(DetSal.Cantidad,0)*IsNull(DetSal.CostoUnitario,0)) as [Total],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or DetSal.IdObra=@IdObra) and 
	(@IdTransportista=-1 or SalidasMateriales.IdTransportista1=@IdTransportista) and 
	(@IdChofer=-1 or SalidasMateriales.IdChofer=@IdChofer) and 
	(@NumeroDestino=-1 or SalidasMateriales.NumeroSalidaMateriales2=@NumeroDestino) and 
	(@IdFlete=-1 or SalidasMateriales.IdFlete=@IdFlete)  

ORDER BY [IdAux1], [IdAux2], [IdAux3], [Unidad]
