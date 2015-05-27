
CREATE  Procedure [dbo].[SalidasMateriales_TX_PorIdOrdenTrabajo_TipoSalida]

@IdOrdenTrabajo int, 
@TipoSalida int

AS 

SELECT 
 DetSal.IdDetalleSalidaMateriales,
 Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20) as [NumeroSalida],
 SalidasMateriales.FechaSalidaMateriales as [FechaSalida],
 DetSal.Cantidad as [Cant.],
 IsNull(Unidades.Abreviatura,Unidades.Descripcion) as [Unidad],
 Articulos.Codigo as [Codigo],
 Articulos.Descripcion as [Articulo],
 Requerimientos.NumeroRequerimiento as [NumeroRequerimiento],
 DetReq.NumeroItem as [Item],
 DetSal.CostoUnitario as [CostoUnitario],
 DetSal.Cantidad*DetSal.CostoUnitario as [CostoTotal],
 Obras.NumeroObra as [Obra]
FROM DetalleSalidasMateriales DetSal
LEFT OUTER JOIN SalidasMateriales ON SalidasMateriales.IdSalidaMateriales = DetSal.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN Cuentas ON Articulos.IdCuentaCompras = Cuentas.IdCuenta
LEFT OUTER JOIN DetalleValesSalida ON DetSal.IdDetalleValeSalida = DetalleValesSalida.IdDetalleValeSalida
LEFT OUTER JOIN ValesSalida ON DetalleValesSalida.IdValeSalida = ValesSalida.IdValeSalida
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento = DetalleValesSalida.IdDetalleRequerimiento
LEFT OUTER JOIN Requerimientos ON Requerimientos.IdRequerimiento = DetReq.IdRequerimiento
LEFT OUTER JOIN Obras ON Obras.IdObra = DetSal.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	DetSal.IdOrdenTrabajo=@IdOrdenTrabajo and 
	(SalidasMateriales.TipoSalida=@TipoSalida or 
	 (@TipoSalida=0 and SalidasMateriales.TipoSalida<>3 and SalidasMateriales.TipoSalida<>4))
ORDER BY SalidasMateriales.FechaSalidaMateriales, SalidasMateriales.NumeroSalidaMateriales
