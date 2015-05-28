
CREATE  Procedure [dbo].[SalidasMateriales_TX_PendientesSAT]

@TipoConsulta varchar(1)

AS 

Declare @vector_X varchar(30),@vector_T varchar(30)

IF @TipoConsulta='R'
   BEGIN
	Set @vector_X='011111111111133'
	Set @vector_T='0E9244D14220400'
	
	SELECT
	 Det.IdDetalleSalidaMateriales,
	 Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+
		Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
		Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Nro. de salida],
	 Det.IdDetalleSalidaMateriales as [IdAux],
	 Obras.NumeroObra as [Obra],
	 SalidasMateriales.FechaSalidaMateriales as [Fecha],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion as [Articulo],
	 Det.Cantidad as [Cant.],
	 (Select Sum(IsNull(DetRec.Cantidad,0)) 
		From DetalleRecepcionesSAT DetRec 
		Left Outer Join RecepcionesSAT On RecepcionesSAT.IdRecepcion=DetRec.IdRecepcion
		Where DetRec.IdDetalleSalidaMaterialesPRONTO=Det.IdDetalleSalidaMateriales and 
			IsNull(RecepcionesSAT.Anulada,'NO')<>'SI') as [Recepcionado SAT],
	 (Select Sum(IsNull(DetAju.CantidadUnidades,0)) 
		From DetalleAjustesStock DetAju 
		Left Outer Join AjustesStock On AjustesStock.IdAjusteStock=DetAju.IdAjusteStock
		Where DetAju.IdDetalleSalidaMateriales=Det.IdDetalleSalidaMateriales and 
			IsNull(AjustesStock.IdRecepcionSAT,0)=0) as [Ajustes],
	 Det.Cantidad - 
		(IsNull((Select Sum(IsNull(DetRec.Cantidad,0)) 
			From DetalleRecepcionesSAT DetRec 
			Left Outer Join RecepcionesSAT On RecepcionesSAT.IdRecepcion=DetRec.IdRecepcion
			Where DetRec.IdDetalleSalidaMaterialesPRONTO=Det.IdDetalleSalidaMateriales and 
				IsNull(RecepcionesSAT.Anulada,'NO')<>'SI'),0) + 
		 IsNull((Select Sum(IsNull(DetAju.CantidadUnidades,0)) 
			From DetalleAjustesStock DetAju 
			Left Outer Join AjustesStock On AjustesStock.IdAjusteStock=DetAju.IdAjusteStock
			Where DetAju.IdDetalleSalidaMateriales=Det.IdDetalleSalidaMateriales and 
				IsNull(AjustesStock.IdRecepcionSAT,0)=0),0)*-1) as [Saldo],
	 Unidades.Abreviatura as [Un],
	 Det.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM DetalleSalidasMateriales Det
	LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Obras ON Det.IdObra = Obras.IdObra
	WHERE Exists(Select Top 1 Det1.IdDetalleSalidaMateriales 
			From DetalleOtrosIngresosAlmacen Det1 
			Where IsNull(Det1.IdDetalleSalidaMateriales,0)=Det.IdDetalleSalidaMateriales) and 
		(Det.Cantidad - 
			(IsNull((Select Sum(IsNull(DetRec.Cantidad,0)) 
				From DetalleRecepcionesSAT DetRec 
				Left Outer Join RecepcionesSAT On RecepcionesSAT.IdRecepcion=DetRec.IdRecepcion
				Where DetRec.IdDetalleSalidaMaterialesPRONTO=Det.IdDetalleSalidaMateriales and 
					IsNull(RecepcionesSAT.Anulada,'NO')<>'SI'),0) + 
			 IsNull((Select Sum(IsNull(DetAju.CantidadUnidades,0)) 
				From DetalleAjustesStock DetAju 
				Left Outer Join AjustesStock On AjustesStock.IdAjusteStock=DetAju.IdAjusteStock
				Where DetAju.IdDetalleSalidaMateriales=Det.IdDetalleSalidaMateriales and 
					IsNull(AjustesStock.IdRecepcionSAT,0)=0),0)*-1))<>0
	ORDER BY Obras.NumeroObra, SalidasMateriales.FechaSalidaMateriales, 
		SalidasMateriales.NumeroSalidaMateriales2, SalidasMateriales.NumeroSalidaMateriales, Articulos.Codigo
   END
ELSE
   BEGIN
	SET NOCOUNT ON

	CREATE TABLE #Auxiliar1 
				(
				 IdDetalle INTEGER,
				 Tipo VARCHAR(3),
				 Suborden INTEGER,
				 IdDetalleSalidaMateriales INTEGER,
				 Numero VARCHAR(13),
				 Fecha DATETIME,
				 IdObra INTEGER,
				 IdArticulo INTEGER,
				 IdUnidad INTEGER,
				 IdUbicacion INTEGER,
				 Cantidad NUMERIC(18,2),
				 CantidadEnTransito NUMERIC(18,2),
				 Observaciones NTEXT
				)
	INSERT INTO #Auxiliar1 
	 SELECT 
	  Det.IdDetalleSalidaMateriales,
	  'SAL',
	  1,
	  Det.IdDetalleSalidaMateriales,
 	  Substring('0000',1,4-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)))+
		Convert(varchar,SalidasMateriales.NumeroSalidaMateriales2)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
		Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),
	  SalidasMateriales.FechaSalidaMateriales,
	  Det.IdObra,
	  Det.IdArticulo,
	  Det.IdUnidad,
	  Det.IdUbicacion,
	  Det.Cantidad,
	  Null,
	  Det.Observaciones
	 FROM DetalleSalidasMateriales Det
	 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
	 WHERE Exists(Select Top 1 Det1.IdDetalleSalidaMateriales 
			From DetalleOtrosIngresosAlmacen Det1 
			Where IsNull(Det1.IdDetalleSalidaMateriales,0)=Det.IdDetalleSalidaMateriales)

	UNION ALL

	 SELECT 
	  Det.IdDetalleOtroIngresoAlmacen,
	  'OTR',
	  2,
	  Det.IdDetalleSalidaMateriales,
	  Substring('00000000',1,8-Len(Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen)))+
		Convert(varchar,OtrosIngresosAlmacen.NumeroOtroIngresoAlmacen),
	  OtrosIngresosAlmacen.FechaOtroIngresoAlmacen,
	  Det.IdObra,
	  Det.IdArticulo,
	  Det.IdUnidad,
	  Det.IdUbicacion,
	  Null,
	  Det.Cantidad,
	  Det.Observaciones
	FROM DetalleOtrosIngresosAlmacen Det
	LEFT OUTER JOIN OtrosIngresosAlmacen ON Det.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
	WHERE Det.IdDetalleSalidaMateriales is not null

	UNION ALL

	 SELECT 
	  Det.IdDetalleAjusteStock,
	  'AJU',
	  3,
	  Det.IdDetalleSalidaMateriales,
	  Substring('00000000',1,8-Len(Convert(varchar,AjustesStock.NumeroAjusteStock)))+
		Convert(varchar,AjustesStock.NumeroAjusteStock),
	  AjustesStock.FechaAjuste,
	  Det.IdObra,
	  Det.IdArticulo,
	  Det.IdUnidad,
	  Det.IdUbicacion,
	  Null,
	  Det.CantidadUnidades,
	  Det.Observaciones
	FROM DetalleAjustesStock Det
	LEFT OUTER JOIN AjustesStock ON Det.IdAjusteStock = AjustesStock.IdAjusteStock
	WHERE Det.IdDetalleSalidaMateriales is not null

	SET NOCOUNT OFF

	Set @vector_X='00000111111111133'
	Set @vector_T='0000074204D110400'
	
	SELECT
	 #Auxiliar1.IdDetalle,
	 #Auxiliar1.IdDetalleSalidaMateriales as [K_Clave],
	 Articulos.Codigo as [K_Codigo],
	 1 as [K_Orden],
	 #Auxiliar1.Suborden as [K_Suborden],
	 #Auxiliar1.Tipo+' '+#Auxiliar1.Numero as [Numero],
	 #Auxiliar1.Fecha as [Fecha],
	 Obras.NumeroObra as [Obra],
	 Depositos.Descripcion+
		Case When Len(Rtrim(IsNull(Ubicaciones.Estanteria,'')))>0 Then ' - Est.:'+Ubicaciones.Estanteria Else '' End+
		Case When Len(Rtrim(IsNull(Ubicaciones.Modulo,'')))>0 Then ' - Mod.:'+Ubicaciones.Modulo Else '' End+
		Case When Len(Rtrim(IsNull(Ubicaciones.Gabeta,'')))>0 Then ' - Gab.:'+Ubicaciones.Gabeta Else '' End as [Ubicacion],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion as [Articulo],
	 #Auxiliar1.Cantidad as [Cant.],
	 #Auxiliar1.CantidadEnTransito as [En trans.],
	 Unidades.Abreviatura as [Un],
	 #Auxiliar1.Observaciones as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades ON #Auxiliar1.IdUnidad = Unidades.IdUnidad
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN Ubicaciones ON #Auxiliar1.IdUbicacion = Ubicaciones.IdUbicacion
	LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito

	UNION ALL

	SELECT
	 0,
	 #Auxiliar1.IdDetalleSalidaMateriales as [K_Clave],
	 Articulos.Codigo as [K_Codigo],
	 2 as [K_Orden],
	 0 as [K_Suborden],
	 Null as [Numero],
	 Null as [Fecha],
	 Null as [Obra],
	 Null as [Ubicacion],
	 Null as [Codigo],
	 'SALDO' as [Articulo],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cant.],
	 Sum(IsNull(#Auxiliar1.CantidadEnTransito,0)) as [En trans.],
	 Null as [Un],
	 Null as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	GROUP BY #Auxiliar1.IdDetalleSalidaMateriales, Articulos.Codigo

	UNION ALL

	SELECT
	 0,
	 #Auxiliar1.IdDetalleSalidaMateriales as [K_Clave],
	 Articulos.Codigo as [K_Codigo],
	 3 as [K_Orden],
	 0 as [K_Suborden],
	 Null as [Numero],
	 Null as [Fecha],
	 Null as [Obra],
	 Null as [Ubicacion],
	 Null as [Codigo],
	 Null as [Articulo],
	 Null as [Cant.],
	 Null as [En trans.],
	 Null as [Un],
	 Null as [Observaciones],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar1
	LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
	GROUP BY #Auxiliar1.IdDetalleSalidaMateriales, Articulos.Codigo

	ORDER BY [K_Clave], [K_Codigo], [K_Orden], [K_Suborden], [Numero]

	DROP TABLE #Auxiliar1
   END
