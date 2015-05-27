CREATE Procedure [dbo].[Articulos_TX_SaldosDeStockAFecha]

@FechaHasta Datetime,
@IdArticulo int = Null,
@IdObra int = Null,
@IdUbicacion int = Null,
@NumeroCaja int = Null,
@Formato int = Null,
@Orden varchar(1) = Null,
@ConTotales varchar(2) = Null

AS

SET NOCOUNT ON

SET @IdArticulo=IsNull(@IdArticulo,0)
SET @IdObra=IsNull(@IdObra,0)
SET @IdUbicacion=IsNull(@IdUbicacion,0)
SET @NumeroCaja=IsNull(@NumeroCaja,0)
SET @Formato=IsNull(@Formato,0)
SET @Orden=IsNull(@Orden,'C')
SET @ConTotales=IsNull(@ConTotales,'NO')

EXEC Stock_CalcularEquivalencias

DECLARE @FechaArranqueMovimientosStock datetime

SET @FechaArranqueMovimientosStock=IsNull((Select Top 1 FechaArranqueMovimientosStock From Parametros Where IdParametro=1),Convert(datetime,'01/01/1900'))

CREATE TABLE #Auxiliar501 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 date)
CREATE NONCLUSTERED INDEX IX__Auxiliar501 ON #Auxiliar501 (IdArticuloConjunto,FechaModificacion2,FechaModificacion Desc) ON [PRIMARY]
INSERT INTO #Auxiliar501 
 SELECT IdArticuloConjunto, FechaModificacion, FechaModificacion
 FROM ConjuntosVersiones

CREATE TABLE #Auxiliar502 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 date)
CREATE NONCLUSTERED INDEX IX__Auxiliar502 ON #Auxiliar502 (IdArticuloConjunto,FechaModificacion2 Desc) ON [PRIMARY]
INSERT INTO #Auxiliar502 
 SELECT IdArticuloConjunto, Max(FechaModificacion), FechaModificacion2
 FROM #Auxiliar501
 GROUP BY IdArticuloConjunto, FechaModificacion2

CREATE TABLE #Auxiliar1	
			(
			 IdArticulo INTEGER,
			 IdUbicacion INTEGER,
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdObra INTEGER,
			 Cantidad NUMERIC(18, 2),
			 NumeroCaja INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT
  DetalleAjustesStock.IdArticulo,
  DetalleAjustesStock.IdUbicacion,
  DetalleAjustesStock.IdUnidad,
  DetalleAjustesStock.Partida,
  DetalleAjustesStock.IdObra,
  DetalleAjustesStock.CantidadUnidades,
  DetalleAjustesStock.NumeroCaja
 FROM DetalleAjustesStock
 LEFT OUTER JOIN AjustesStock ON DetalleAjustesStock.IdAjusteStock = AjustesStock.IdAjusteStock
 WHERE AjustesStock.FechaAjuste<=@FechaHasta and AjustesStock.FechaAjuste>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleAjustesStock.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleAjustesStock.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleAjustesStock.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleAjustesStock.NumeroCaja=@NumeroCaja)

UNION ALL

 SELECT
  DetalleSalidasMateriales.IdArticulo,
  DetalleSalidasMateriales.IdUbicacion,
  DetalleSalidasMateriales.IdUnidad,
  DetalleSalidasMateriales.Partida,
  DetalleSalidasMateriales.IdObra,
  DetalleSalidasMateriales.Cantidad * -1,
  DetalleSalidasMateriales.NumeroCaja
 FROM DetalleSalidasMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	IsNull(DetalleSalidasMateriales.DescargaPorKit,'NO')<>'SI' and SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleSalidasMateriales.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleSalidasMateriales.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleSalidasMateriales.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleSalidasMateriales.NumeroCaja=@NumeroCaja)

UNION ALL

 SELECT
  cv.IdArticulo,
  DetalleSalidasMateriales.IdUbicacion,
  cv.IdUnidad,
  DetalleSalidasMateriales.Partida,
  DetalleSalidasMateriales.IdObra,
  DetalleSalidasMateriales.Cantidad * cv.Cantidad * -1, 
  DetalleSalidasMateriales.NumeroCaja
 FROM DetalleSalidasMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=DetalleSalidasMateriales.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and SalidasMateriales.FechaSalidaMateriales<=@FechaHasta and 
	IsNull(DetalleSalidasMateriales.DescargaPorKit,'NO')='SI' and SalidasMateriales.FechaSalidaMateriales>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or cv.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleSalidasMateriales.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleSalidasMateriales.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleSalidasMateriales.NumeroCaja=@NumeroCaja)

UNION ALL

 SELECT
  DetalleRecepciones.IdArticulo,
  DetalleRecepciones.IdUbicacion,
  DetalleRecepciones.IdUnidad,
  DetalleRecepciones.Partida,
  DetalleRecepciones.IdObra,
  IsNull(DetalleRecepciones.CantidadCC,DetalleRecepciones.Cantidad),
  Null
 FROM DetalleRecepciones
 LEFT OUTER JOIN Recepciones ON DetalleRecepciones.IdRecepcion = Recepciones.IdRecepcion
 WHERE Recepciones.FechaRecepcion<=@FechaHasta and 
	(Recepciones.Anulada is null or Recepciones.Anulada<>'SI') and Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleRecepciones.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleRecepciones.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleRecepciones.IdUbicacion=@IdUbicacion) 

UNION ALL

 SELECT
  DetalleOtrosIngresosAlmacen.IdArticulo,
  DetalleOtrosIngresosAlmacen.IdUbicacion,
  DetalleOtrosIngresosAlmacen.IdUnidad,
  DetalleOtrosIngresosAlmacen.Partida,
  DetalleOtrosIngresosAlmacen.IdObra,
  IsNull(DetalleOtrosIngresosAlmacen.CantidadCC,DetalleOtrosIngresosAlmacen.Cantidad),
  Null
 FROM DetalleOtrosIngresosAlmacen
 LEFT OUTER JOIN OtrosIngresosAlmacen ON DetalleOtrosIngresosAlmacen.IdOtroIngresoAlmacen = OtrosIngresosAlmacen.IdOtroIngresoAlmacen
 WHERE IsNull(OtrosIngresosAlmacen.Anulado,'NO')<>'SI' and OtrosIngresosAlmacen.FechaOtroIngresoAlmacen<=@FechaHasta and 
	OtrosIngresosAlmacen.FechaOtroIngresoAlmacen>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleOtrosIngresosAlmacen.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleOtrosIngresosAlmacen.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleOtrosIngresosAlmacen.IdUbicacion=@IdUbicacion) 

UNION ALL

 SELECT
  DetalleRemitos.IdArticulo,
  DetalleRemitos.IdUbicacion,
  DetalleRemitos.IdUnidad,
  DetalleRemitos.Partida,
  DetalleRemitos.IdObra,
  DetalleRemitos.Cantidad * -1,
  DetalleRemitos.NumeroCaja
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 WHERE (Remitos.Anulado is null or Remitos.Anulado<>'SI') and IsNull(DetalleRemitos.DescargaPorKit,'NO')<>'SI' and 
	Remitos.FechaRemito<=@FechaHasta and Remitos.FechaRemito>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleRemitos.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleRemitos.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleRemitos.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleRemitos.NumeroCaja=@NumeroCaja)

UNION ALL

 SELECT
  cv.IdArticulo,
  DetalleRemitos.IdUbicacion,
  cv.IdUnidad,
  DetalleRemitos.Partida,
  DetalleRemitos.IdObra,
  DetalleRemitos.Cantidad * cv.Cantidad * -1,
  DetalleRemitos.NumeroCaja
 FROM DetalleRemitos
 LEFT OUTER JOIN Remitos ON DetalleRemitos.IdRemito = Remitos.IdRemito
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=DetalleRemitos.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=Remitos.FechaRemito 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE (Remitos.Anulado is null or Remitos.Anulado<>'SI') and IsNull(DetalleRemitos.DescargaPorKit,'NO')='SI' and 
	Remitos.FechaRemito<=@FechaHasta and Remitos.FechaRemito>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or cv.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleRemitos.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleRemitos.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleRemitos.NumeroCaja=@NumeroCaja)

UNION ALL

 SELECT
  DetalleDevoluciones.IdArticulo,
  DetalleDevoluciones.IdUbicacion,
  DetalleDevoluciones.IdUnidad,
  DetalleDevoluciones.Partida,
  DetalleDevoluciones.IdObra,
  DetalleDevoluciones.Cantidad,
  DetalleDevoluciones.NumeroCaja
 FROM DetalleDevoluciones
 LEFT OUTER JOIN Devoluciones ON DetalleDevoluciones.IdDevolucion = Devoluciones.IdDevolucion
 WHERE Devoluciones.FechaDevolucion<=@FechaHasta and IsNull(Devoluciones.Anulada,'')<>'SI' and Devoluciones.FechaDevolucion>=@FechaArranqueMovimientosStock and 
	(@IdArticulo<=0 or DetalleDevoluciones.IdArticulo=@IdArticulo) and 
	(@IdObra<=0 or DetalleDevoluciones.IdObra=@IdObra) and 
	(@IdUbicacion<=0 or DetalleDevoluciones.IdUbicacion=@IdUbicacion) and 
	(@NumeroCaja<=0 or DetalleDevoluciones.NumeroCaja=@NumeroCaja)

CREATE TABLE #Auxiliar2	
			(
			 IdArticulo INTEGER,
			 IdUbicacion INTEGER,
			 IdUnidad INTEGER,
			 Partida VARCHAR(20),
			 IdObra INTEGER,
			 Cantidad NUMERIC(18, 2),
			 NumeroCaja INTEGER,
			 Equivalencia NUMERIC(18,6),
			 CantidadEquivalencia NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT
  #Auxiliar1.IdArticulo,
  #Auxiliar1.IdUbicacion,
  #Auxiliar1.IdUnidad,
  #Auxiliar1.Partida,
  #Auxiliar1.IdObra,
  SUM(IsNull(#Auxiliar1.Cantidad,0)),
  #Auxiliar1.NumeroCaja,
  Null, 
  Null
 FROM #Auxiliar1
 LEFT OUTER JOIN Articulos ON #Auxiliar1.IdArticulo = Articulos.IdArticulo
 WHERE Articulos.IdArticulo is not null and IsNull(Articulos.RegistrarStock,'SI')='SI'
 GROUP BY #Auxiliar1.IdArticulo, #Auxiliar1.IdUbicacion, #Auxiliar1.IdUnidad, #Auxiliar1.Partida, #Auxiliar1.IdObra, #Auxiliar1.NumeroCaja

UPDATE #Auxiliar2
SET Equivalencia=IsNull((Select Top 1 Equivalencia From DetalleArticulosUnidades Where IdArticulo=#Auxiliar2.IdArticulo and IdUnidad=#Auxiliar2.IdUnidad),1)

UPDATE #Auxiliar2
SET Equivalencia=1
WHERE Equivalencia=0

UPDATE #Auxiliar2
SET CantidadEquivalencia=IsNull(Cantidad,0)/Equivalencia

CREATE TABLE #Auxiliar3	
			(
			 IdArticulo INTEGER,
			 CostoReposicion NUMERIC(18,3),
			 CostoReposicionDolar NUMERIC(18,3),
			 FechaCosto DATETIME
			)
INSERT INTO #Auxiliar3 
 SELECT #Auxiliar2.IdArticulo, 0, 0, Null
 FROM #Auxiliar2
 GROUP BY #Auxiliar2.IdArticulo

UPDATE #Auxiliar3
SET 
	CostoReposicion=(Select Top 1 Case When IsNull(pe.PedidoExterior,'NO')='NO' Then IsNull(Det.CostoUnitario,0) * IsNull(Det.CotizacionMoneda,0)
										When IsNull(pe.PedidoExterior,'NO')='SI' and IsNull(dp.CostoAsignado,0)<>0 Then IsNull(dp.CostoAsignado,0)
										Else 0
									End
					 From DetalleRecepciones Det
					 Left Outer Join Recepciones On Recepciones.IdRecepcion=Det.IdRecepcion
					 Left Outer Join DetallePedidos dp On Det.IdDetallePedido=dp.IdDetallePedido
					 Left Outer Join Pedidos pe On dp.IdPedido=pe.IdPedido
					 Where Det.IdArticulo=#Auxiliar3.IdArticulo and 
						Recepciones.FechaRecepcion<=@FechaHasta and 
						IsNull(Recepciones.Anulada,'NO')<>'SI' and 
						Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock
					 Order By Recepciones.FechaRecepcion Desc), 
	CostoReposicionDolar=(Select Top 1 Case When IsNull(pe.PedidoExterior,'NO')='NO' and IsNull(Det.CotizacionDolar,0)<>0 
												Then IsNull(Det.CostoUnitario,0) * IsNull(Det.CotizacionMoneda,0) / IsNull(Det.CotizacionDolar,0)
											When IsNull(pe.PedidoExterior,'NO')='SI' and IsNull(dp.CostoAsignadoDolar,0)<>0 
												Then IsNull(dp.CostoAsignadoDolar,0)
											Else 0
										End
							From DetalleRecepciones Det
							Left Outer Join Recepciones On Recepciones.IdRecepcion=Det.IdRecepcion
							Left Outer Join DetallePedidos dp On Det.IdDetallePedido=dp.IdDetallePedido
							Left Outer Join Pedidos pe On dp.IdPedido=pe.IdPedido
							Where Det.IdArticulo=#Auxiliar3.IdArticulo and 
								Recepciones.FechaRecepcion<=@FechaHasta and 
								IsNull(Recepciones.Anulada,'NO')<>'SI' and 
								Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock
							Order By Recepciones.FechaRecepcion Desc), 
	FechaCosto=(Select Top 1 Recepciones.FechaRecepcion
				From DetalleRecepciones Det
				Left Outer Join Recepciones On Recepciones.IdRecepcion=Det.IdRecepcion
				Where Det.IdArticulo=#Auxiliar3.IdArticulo and 
					Recepciones.FechaRecepcion<=@FechaHasta and 
					IsNull(Recepciones.Anulada,'NO')<>'SI' and 
					Recepciones.FechaRecepcion>=@FechaArranqueMovimientosStock
				Order By Recepciones.FechaRecepcion Desc)

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='000011111111111161611133'
SET @vector_T='00003D411000222333342200'

IF @Formato=0
  BEGIN
	IF @ConTotales='SI'
	  BEGIN
		SELECT
		 #Auxiliar2.IdArticulo as [IdArticulo],
		 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [K_Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [K_Articulo],
		 1 as [K_Orden],
		 Articulos.Codigo as [Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
		 Obras.NumeroObra as [Obra],
		 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
			IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
		 #Auxiliar2.Partida as [Partida],
		 #Auxiliar2.NumeroCaja as [Nro.Caja],
		 U1.Abreviatura as [En:],
		 #Auxiliar2.Cantidad as [Cant.],
		 U2.Abreviatura as [Equiv. a],
		 #Auxiliar2.Equivalencia as [Equiv.],
		 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
		 IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Costo Rep.$],
		 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Stock val.rep.$],
		 IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Costo Rep.u$s],
		 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Stock val.rep.u$s],
		 #Auxiliar3.FechaCosto as [Fecha costo],
		 UnidadesEmpaque.PesoBruto as [P.Bruto],
		 UnidadesEmpaque.Tara as [Tara],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
		LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
		LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra = Obras.IdObra
		LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
		LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
		LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
		LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
		LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.IdArticulo = #Auxiliar3.IdArticulo
		WHERE #Auxiliar2.Cantidad<>0 
		
		UNION ALL 
		
		SELECT
		 #Auxiliar2.IdArticulo as [IdArticulo],
		 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [K_Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [K_Articulo],
		 2 as [K_Orden],
		 Null as [Codigo],
		 'TOTAL ARTICULO' as [Articulo],
		 Null as [Obra],
		 Null as [Ubicacion],
		 Null as [Partida],
		 Null as [Nro.Caja],
		 Null as [En:],
		 Sum(#Auxiliar2.Cantidad) as [Cant.],
		 Null as [Equiv. a],
		 Null as [Equiv.],
		 Sum(#Auxiliar2.CantidadEquivalencia) as [Cant.Equiv.],
		 IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Costo Rep.$],
		 Sum(#Auxiliar2.CantidadEquivalencia)*IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Stock val.rep.$],
		 IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Costo Rep.u$s],
		 Sum(#Auxiliar2.CantidadEquivalencia)*IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Stock val.rep.u$s],
		 #Auxiliar3.FechaCosto as [Fecha costo],
		 Null as [P.Bruto],
		 Null as [Tara],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.IdArticulo = #Auxiliar3.IdArticulo
		LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
		LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
		WHERE #Auxiliar2.Cantidad<>0 
		GROUP BY #Auxiliar2.IdArticulo, Articulos.Codigo, Articulos.Descripcion, Articulos.CostoReposicion, Articulos.CostoReposicionDolar, 
				 #Auxiliar3.CostoReposicion, #Auxiliar3.CostoReposicionDolar, #Auxiliar3.FechaCosto, Colores.Descripcion
		
		UNION ALL 
		
		SELECT
		 #Auxiliar2.IdArticulo as [IdArticulo],
		 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [K_Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [K_Articulo],
		 3 as [K_Orden],
		 Null as [Codigo],
		 Null as [Articulo],
		 Null as [Nro.Caja],
		 Null as [Obra],
		 Null as [Ubicacion],
		 Null as [Partida],
		 Null as [En:],
		 Null as [Cant.],
		 Null as [Equiv. a],
		 Null as [Equiv.],
		 Null as [Cant.Equiv.],
		 Null as [Costo Rep.$],
		 Null as [Stock val.rep.$],
		 Null as [Costo Rep.u$s],
		 Null as [Stock val.rep.u$s],
		 Null as [Fecha costo],
		 Null as [P.Bruto],
		 Null as [Tara],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
		LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
		WHERE #Auxiliar2.Cantidad<>0 
		GROUP BY #Auxiliar2.IdArticulo,Articulos.Codigo,Articulos.Descripcion, Colores.Descripcion
		
		ORDER BY [K_Codigo], [K_Articulo], [K_Orden], [Obra], [Ubicacion], [Partida]
	  END
	ELSE
	  BEGIN
		SELECT
		 #Auxiliar2.IdArticulo as [IdArticulo],
		 Case When @Orden='C' Then Convert(varchar,Articulos.Codigo) Else Articulos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS End as [K_Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [K_Articulo],
		 1 as [K_Orden],
		 Articulos.Codigo as [Codigo],
		 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
		 Obras.NumeroObra as [Obra],
		 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
			IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
			IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
		 #Auxiliar2.Partida as [Partida],
		 #Auxiliar2.NumeroCaja as [Nro.Caja],
		 U1.Abreviatura as [En:],
		 #Auxiliar2.Cantidad as [Cant.],
		 U2.Abreviatura as [Equiv. a],
		 #Auxiliar2.Equivalencia as [Equiv.],
		 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
		 IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Costo Rep.$],
		 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Stock val.rep.$],
		 IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Costo Rep.u$s],
		 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Stock val.rep.u$s],
		 #Auxiliar3.FechaCosto as [Fecha costo],
		 UnidadesEmpaque.PesoBruto as [P.Bruto],
		 UnidadesEmpaque.Tara as [Tara],
		 @Vector_T as Vector_T,
		 @Vector_X as Vector_X
		FROM #Auxiliar2
		LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
		LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
		LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
		LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra = Obras.IdObra
		LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
		LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
		LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
		LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
		LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.IdArticulo = #Auxiliar3.IdArticulo
		WHERE #Auxiliar2.Cantidad<>0 
		ORDER BY [K_Codigo], [K_Articulo], [K_Orden], [Obra], [Ubicacion], [Partida]
	  END
  END

IF @Formato=1
  BEGIN
	SELECT
	 #Auxiliar2.IdArticulo as [IdArticulo],
	 Articulos.Codigo as [K_Codigo],
	 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [K_Articulo],
	 1 as [K_Orden],
	 Articulos.Codigo as [Codigo],
	 Articulos.Descripcion+IsNull(' '+Colores.Descripcion COLLATE Modern_Spanish_CI_AS,'') as [Articulo],
	 Obras.NumeroObra as [Obra],
	 IsNull(Depositos.Abreviatura,Depositos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS)+
		IsNull(', '+Ubicaciones.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
		IsNull(' - Est.:'+Ubicaciones.Estanteria COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
		IsNull(' - Mod.:'+Ubicaciones.Modulo COLLATE SQL_Latin1_General_CP1_CI_AS,'')+
		IsNull(' - Gab.:'+Ubicaciones.Gabeta COLLATE SQL_Latin1_General_CP1_CI_AS,'') as [Ubicacion],
	 #Auxiliar2.Partida as [Partida],
	 #Auxiliar2.NumeroCaja as [Nro.Caja],
	 U1.Abreviatura as [En:],
	 #Auxiliar2.Cantidad as [Cant.],
	 U2.Abreviatura as [Equiv. a],
	 #Auxiliar2.Equivalencia as [Equiv.],
	 #Auxiliar2.CantidadEquivalencia as [Cant.Equiv.],
	 IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Costo Rep.$],
	 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicion,Articulos.CostoReposicion) as [Stock val.rep.$],
	 IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Costo Rep.u$s],
	 #Auxiliar2.CantidadEquivalencia*IsNull(#Auxiliar3.CostoReposicionDolar,Articulos.CostoReposicionDolar) as [Stock val.rep.u$s],
	 #Auxiliar3.FechaCosto as [Fecha costo],
	 UnidadesEmpaque.PesoBruto as [P.Bruto],
	 UnidadesEmpaque.Tara as [Tara],
	 @Vector_T as Vector_T,
	 @Vector_X as Vector_X
	FROM #Auxiliar2
	LEFT OUTER JOIN Articulos ON #Auxiliar2.IdArticulo = Articulos.IdArticulo
	LEFT OUTER JOIN Unidades U1 ON #Auxiliar2.IdUnidad = U1.IdUnidad
	LEFT OUTER JOIN Unidades U2 ON Articulos.IdUnidad = U2.IdUnidad
	LEFT OUTER JOIN Obras ON #Auxiliar2.IdObra = Obras.IdObra
	LEFT OUTER JOIN Ubicaciones ON #Auxiliar2.IdUbicacion = Ubicaciones.IdUbicacion
	LEFT OUTER JOIN Depositos ON Ubicaciones.IdDeposito = Depositos.IdDeposito
	LEFT OUTER JOIN UnidadesEmpaque ON #Auxiliar2.NumeroCaja = UnidadesEmpaque.NumeroUnidad
	LEFT OUTER JOIN Colores ON UnidadesEmpaque.IdColor = Colores.IdColor
	LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar2.IdArticulo = #Auxiliar3.IdArticulo
	WHERE #Auxiliar2.Cantidad<>0 
	ORDER BY [Codigo],[Articulo],[Obra],[Ubicacion],[Partida],[Nro.Caja]
  END

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
