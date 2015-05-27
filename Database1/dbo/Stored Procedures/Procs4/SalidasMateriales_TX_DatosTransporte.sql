
CREATE  Procedure [dbo].[SalidasMateriales_TX_DatosTransporte]

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

SET @vector_X='001111111111111111133'
IF @Valorizado='SI'
	SET @vector_T='00E45D123325322232900'
ELSE
	SET @vector_T='00E45D129925322232900'
SET @Vector_E='  |  |  |  |  | CEN,NUM:#COMMA##0.00 | CUR | CUR |  |  |  |  |  |  |  |  '

SELECT 
 DetSal.IdDetalleSalidaMateriales as [IdDetalleSalidaMateriales],
 1 as [IdAux1],
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('000000000',1,9-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Nro. de salida],
 SalidasMateriales.FechaSalidaMateriales as [Fecha],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Unidades.Abreviatura as [Unidad],
 DetSal.Cantidad as [Cant.],
 DetSal.CostoUnitario as [Costo],
 DetSal.Cantidad*DetSal.CostoUnitario as [Total],
 Transportistas.RazonSocial as [Transportista],
 SalidasMateriales.NumeroRemitoTransporte as [RemitoTransportista],
 SalidasMateriales.Patente1 as [NumeroPatente],
 SalidasMateriales.Chofer as [Chofer],
 SalidasMateriales.NumeroDocumento as [Documento],
 SalidasMateriales.DestinoDeObra as [Destino de obra],
 Obras.NumeroObra as [Obra],
 Fletes.Descripcion as [Camion],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1=Transportistas.IdTransportista
LEFT OUTER JOIN Fletes ON SalidasMateriales.IdFlete = Fletes.IdFlete
LEFT OUTER JOIN Obras ON Obras.IdObra = DetSal.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or DetSal.IdObra=@IdObra) and 
	(@IdTransportista=-1 or SalidasMateriales.IdTransportista1=@IdTransportista) and 
	(@IdChofer=-1 or SalidasMateriales.IdChofer=@IdChofer) and 
	(@NumeroDestino=-1 or SalidasMateriales.NumeroSalidaMateriales2=@NumeroDestino) and 
	(@IdFlete=-1 or SalidasMateriales.IdFlete=@IdFlete)  

UNION ALL

SELECT 
 0 as [IdDetalleSalidaMateriales],
 2 as [IdAux1],
 Null as [Nro. de salida],
 Null as [Fecha],
 Null as [Codigo],
 Null as [Articulo],
 Null as [Unidad],
 Null as [Cant.],
 Null as [Costo],
 Null as [Total],
 Null as [Transportista],
 Null as [RemitoTransportista],
 Null as [NumeroPatente],
 Null as [Chofer],
 Null as [Documento],
 Null as [Destino de obra],
 Null as [Obra],
 Null as [Camion],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT 
 0 as [IdDetalleSalidaMateriales],
 3 as [IdAux1],
 Null as [Nro. de salida],
 Null as [Fecha],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Unidades.Abreviatura as [Unidad],
 Sum(IsNull(DetSal.Cantidad,0)) as [Cant.],
 Null as [Costo],
 Sum(IsNull(DetSal.Cantidad,0)*IsNull(DetSal.CostoUnitario,0)) as [Total],
 Null as [Transportista],
 Null as [RemitoTransportista],
 Null as [NumeroPatente],
 Null as [Chofer],
 Null as [Documento],
 Null as [Destino de obra],
 Null as [Obra],
 Null as [Camion],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1=Transportistas.IdTransportista
LEFT OUTER JOIN Fletes ON SalidasMateriales.IdFlete = Fletes.IdFlete
LEFT OUTER JOIN Obras ON Obras.IdObra = DetSal.IdObra
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
 0 as [IdDetalleSalidaMateriales],
 4 as [IdAux1],
 Null as [Nro. de salida],
 Null as [Fecha],
 Null as [Codigo],
 Null as [Articulo],
 Null as [Unidad],
 Sum(IsNull(DetSal.Cantidad,0)) as [Cant.],
 Null as [Costo],
 Sum(IsNull(DetSal.Cantidad,0)*IsNull(DetSal.CostoUnitario,0)) as [Total],
 Null as [Transportista],
 Null as [RemitoTransportista],
 Null as [NumeroPatente],
 Null as [Chofer],
 Null as [Documento],
 Null as [Destino de obra],
 Null as [Obra],
 Null as [Camion],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Transportistas ON SalidasMateriales.IdTransportista1=Transportistas.IdTransportista
LEFT OUTER JOIN Fletes ON SalidasMateriales.IdFlete = Fletes.IdFlete
LEFT OUTER JOIN Obras ON Obras.IdObra = DetSal.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	(SalidasMateriales.FechaSalidaMateriales between @Desde and @hasta) and 
	(@IdObra=-1 or DetSal.IdObra=@IdObra) and 
	(@IdTransportista=-1 or SalidasMateriales.IdTransportista1=@IdTransportista) and 
	(@IdChofer=-1 or SalidasMateriales.IdChofer=@IdChofer) and 
	(@NumeroDestino=-1 or SalidasMateriales.NumeroSalidaMateriales2=@NumeroDestino) and 
	(@IdFlete=-1 or SalidasMateriales.IdFlete=@IdFlete)  

ORDER BY [IdAux1], [Fecha], [Nro. de salida], [Codigo], [Articulo], [Unidad]
