CREATE PROCEDURE [dbo].[SalidasMateriales_TX_DetalladoPorFechas]

@Desde datetime,
@Hasta datetime,
@IdObra int,
@CodigoSalida int,
@IdGrupoObra int,
@Formato int = Null,
@TiposSalida varchar(1000) = Null

AS

SET @Formato=IsNull(@Formato,0)
SET @TiposSalida=IsNull(@TiposSalida,'')

IF @Formato=0
  BEGIN
	SELECT
	 SalidasMateriales.IdSalidaMateriales,
	 SalidasMateriales.ValePreimpreso as [Preimpreso],
	 Case When SalidasMateriales.NumeroSalidaMateriales2 is not null
		Then Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)
		Else '0000'
	 End + ' - ' +
	 Case When SalidasMateriales.NumeroSalidaMateriales is not null
		Then Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
		Else Null
	 End as [Numero],
	 Obras.NumeroObra as [Obra],
	 Articulos.Codigo as [Codigo],
	 Unidades.Abreviatura as [Unidad],
	 Articulos.Descripcion as [Descripcion],
	 DetSal.Cantidad as [Cantidad],
	 DetSal.Cantidad1 as [Med1],
	 DetSal.Cantidad2 as [Med2],
	 Articulos.CostoPPP,
	 Articulos.CostoPPPDolar,
	 Articulos.CostoReposicion,
	 Articulos.CostoReposicionDolar,
	 SalidasMateriales.Observaciones,
	 SalidasMateriales.NumeroOrdenProduccion,
	 DetalleObrasDestinos.Destino as [Destino],
	 DetSal.CostoUnitario as [CostoUnitario],
	 DetSal.Cantidad*DetSal.CostoUnitario as [CostoTotal]
	FROM DetalleSalidasMateriales DetSal
	LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra=Obras.IdObra
	LEFT OUTER JOIN DetalleObrasDestinos ON DetSal.IdDetalleObraDestino = DetalleObrasDestinos.IdDetalleObraDestino
	WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
		SalidasMateriales.FechaSalidaMateriales>=@Desde and SalidasMateriales.FechaSalidaMateriales<=@Hasta and 
		(@IdObra=-1 or SalidasMateriales.IdObra=@IdObra) and (@IdGrupoObra=-1 or Obras.IdGrupoObra=@IdGrupoObra) and 
		(@CodigoSalida=-1 or SalidasMateriales.TipoSalida=@CodigoSalida) and 
		(Len(@TiposSalida)=0 or Patindex('%('+IsNull(SalidasMateriales.ClaveTipoSalida,'*')+')%', @TiposSalida)<>0)
	ORDER BY Articulos.Descripcion
  END

IF @Formato=1
  BEGIN
	DECLARE @vector_X varchar(50),@vector_T varchar(50)
	SET @vector_X='0111111111133'
	SET @vector_T='029EEE1134600'
	
	SELECT
	 SalidasMateriales.IdSalidaMateriales,
	 Case When SalidasMateriales.TipoSalida=0 Then 'Salida a fabrica'
		When SalidasMateriales.TipoSalida=1 Then 'Salida a obra'
		When SalidasMateriales.TipoSalida=2 Then 'A Proveedor'
		Else SalidasMateriales.ClaveTipoSalida
	 End as [Tipo de salida],
	 DetSal.IdDetalleSalidaMateriales as [IdAux],
	 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Nro. de salida],
	 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoPreimpreso1,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroRemitoPreimpreso1,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroRemitoPreimpreso2)))+Convert(varchar,SalidasMateriales.NumeroRemitoPreimpreso2) as [Nro. de remito],
	 Articulos.Descripcion as [Articulo],
	 DetSal.Cantidad as [Cant.],
	 Unidades.Abreviatura as [Unidad],
	 Obras.NumeroObra as [Obra],
	 SalidasMateriales.FechaSalidaMateriales as [Fecha],
	 Articulos.Codigo as [Codigo],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetalleSalidasMateriales DetSal
	LEFT OUTER JOIN SalidasMateriales ON DetSal.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	LEFT OUTER JOIN Articulos ON DetSal.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON DetSal.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Obras ON SalidasMateriales.IdObra=Obras.IdObra
	LEFT OUTER JOIN DetalleObrasDestinos ON DetSal.IdDetalleObraDestino = DetalleObrasDestinos.IdDetalleObraDestino
	WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and SalidasMateriales.TipoSalida=4 and 
		SalidasMateriales.FechaSalidaMateriales>=@Desde and SalidasMateriales.FechaSalidaMateriales<=@Hasta and 
		(@IdObra=-1 or SalidasMateriales.IdObra=@IdObra) and (@IdGrupoObra=-1 or Obras.IdGrupoObra=@IdGrupoObra) and 
		DetSal.IdUsuarioDioPorRecepcionado is null and 
		Not Exists(Select Top 1 dr.IdRecepcion From DetalleRecepciones dr 
				Left Outer Join Recepciones On Recepciones.IdRecepcion=dr.IdRecepcion
				Where IsNull(Recepciones.Anulada,'NO')<>'SI' and dr.IdDetalleSalidaMateriales=DetSal.IdDetalleSalidaMateriales)
	ORDER BY Articulos.Descripcion
  END