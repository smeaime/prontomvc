CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_ParaInforme]

@IdObra int,
@TipoInforme varchar(20),
@Desde int = Null,
@FechaDesde datetime = Null,
@Hasta int = Null,
@FechaHasta datetime = Null,
@Dts varchar(200) = Null

AS 

SET NOCOUNT ON

SET @Desde=IsNull(@Desde,-1)
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @Hasta=IsNull(@Hasta,-1)
SET @FechaHasta=IsNull(@FechaHasta,0)
SET @Dts=IsNull(@Dts,'')

DECLARE @IdTipoArticuloManoObra int, @IdTipoArticuloEquipos int, @IdTipoArticuloMateriales int, @IdTipoArticuloSubcontratos int

SET @IdTipoArticuloManoObra=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloManoObra'),0)
SET @IdTipoArticuloEquipos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloEquipos'),0)
SET @IdTipoArticuloMateriales=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloMateriales'),0)
SET @IdTipoArticuloSubcontratos=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloSubcontratos'),0)

CREATE TABLE #Auxiliar1 
			(
			 TipoMovimiento INTEGER,
			 Descripcion VARCHAR(200),
			 IdPresupuestoObrasNodo INTEGER,
			 Material VARCHAR(255),
			 IdObra INTEGER,
			 IdPresupuestoObraRubro INTEGER,
			 Detalle VARCHAR(50),
			 Mes INTEGER,
			 Año INTEGER,
			 Cantidad NUMERIC(18, 2),
			 Importe NUMERIC(18, 2),
			 CantidadPresupuestada NUMERIC(18, 2),
			 ImportePresupuestado NUMERIC(18, 2),
			 Fecha DATETIME,
			 Detalle1 VARCHAR(300)
			)
INSERT INTO #Auxiliar1 
 SELECT 10, pon.Descripcion, Det.IdPresupuestoObrasNodo, Articulos.Descripcion, pon.IdObra, pon.IdPresupuestoObraRubro, 'COMPROBANTE COMPRA', 
	Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
	Det.Cantidad, Det.Importe*IsNull(cp.CotizacionMoneda,1), 0, 0, IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante), 
	Convert(varchar,cp.FechaRecepcion,103)+' '+tc.DescripcionAb+' '+cp.Letra+'-'+
		Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2)+' - '+
		'Proveedor : '+IsNull(Proveedores.RazonSocial,'')
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON Det.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=IsNull(cp.IdProveedor,cp.IdProveedorEventual)
 LEFT OUTER JOIN TiposComprobante tc ON cp.IdTipoComprobante = tc.IdTipoComprobante
 WHERE IsNull(Det.IdPresupuestoObrasNodo,0)>0 and (@IdObra=-1 or pon.IdObra=@IdObra) --and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' 

 UNION ALL

 SELECT 20, pon.Descripcion, dsmpo.IdPresupuestoObrasNodo, Articulos.Descripcion, pon.IdObra, pon.IdPresupuestoObraRubro, 'SALIDA MATERIALES', 
	Month(SalidasMateriales.FechaSalidaMateriales), Year(SalidasMateriales.FechaSalidaMateriales), 
	dsmpo.Cantidad, Det.CostoUnitario*IsNull(Det.CotizacionMoneda,1)*dsmpo.Cantidad, 0, 0, SalidasMateriales.FechaSalidaMateriales,
	Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103)+' '+'SM '+
		Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON IsNull(dsmpo.IdPresupuestoObrasNodo,0)=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull((Select Top 1 Conjuntos.IdObra From Conjuntos Where Conjuntos.IdArticulo=Det.IdArticulo),0)
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0)>0 and IsNull(SalidasMateriales.Anulada,'')<>'SI' and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	(@IdObra=-1 or pon.IdObra=@IdObra) 
--and (IsNull(Obras.EsPlantaDeProduccionInterna,'')<>'SI' or (IsNull(Obras.EsPlantaDeProduccionInterna,'')='SI' and IsNull(Det.DescargaPorKit,'')<>'SI'))
/*
 UNION ALL

 SELECT 20, pon.Descripcion, dsmpo.IdPresupuestoObrasNodo, Articulos.Descripcion, pon.IdObra, pon.IdPresupuestoObraRubro, 'SALIDA MATERIALES', 
	Month(SalidasMateriales.FechaSalidaMateriales), Year(SalidasMateriales.FechaSalidaMateriales), 
	dsmpo.Cantidad, Articulos.CostoReposicion*IsNull(DetalleSalidasMateriales.CotizacionMoneda,1)*dsmpo.Cantidad, 0, 0, SalidasMateriales.FechaSalidaMateriales, 
	Convert(varchar,SalidasMateriales.FechaSalidaMateriales,103)+' '+'SM '+
		Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)
 FROM DetalleSalidasMaterialesKits Det 
 LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON IsNull(dsmpo.IdPresupuestoObrasNodo,0)=pon.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0)>0 and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and (@IdObra=-1 or pon.IdObra=@IdObra)
*/
 
 UNION ALL

 SELECT 40, pon.Descripcion, Det.IdPresupuestoObrasNodo, Subcontratos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS, 
	@IdObra, pon.IdPresupuestoObraRubro, 'SUBCONTRATO', Month(dsd.FechaCertificadoHasta), Year(dsd.FechaCertificadoHasta), 
	Det.CantidadAvance, Det.ImporteTotal, 0, 0, dsd.FechaCertificadoHasta, 
	Convert(varchar,dsd.FechaCertificadoHasta,103)+' '+'SUBCONTRATO'+' '+
		Substring('00000000',1,8-Len(Convert(varchar,Subcontratos.NumeroSubcontrato)))+Convert(varchar,Subcontratos.NumeroSubcontrato)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Det.NumeroCertificado)))+Convert(varchar,Det.NumeroCertificado)+' - '+
		'Proveedor : '+IsNull(P1.RazonSocial,'')
 FROM SubcontratosPxQ Det 
 LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
 LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
 LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
 LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor = SubcontratosDatos.IdProveedor
 LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Subcontratos.IdUnidad
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodo
 WHERE IsNull(Det.IdPresupuestoObrasNodo,0)>0 and IsNull(SubcontratosDatos.Anulado,'')<>'SI'

 UNION ALL

 SELECT 50, pon.Descripcion, GastosFletes.IdPresupuestoObrasNodo, GastosFletes.Detalle COLLATE SQL_Latin1_General_CP1_CI_AS, 
	@IdObra, pon.IdPresupuestoObraRubro, 'GS.FLETES', Month(GastosFletes.Fecha), Year(GastosFletes.Fecha), 
	1, GastosFletes.Total * IsNull(GastosFletes.SumaResta,1), 0, 0, GastosFletes.Fecha, 
	Convert(varchar,GastosFletes.Fecha,103)+' '+'GS.FLETES'+' Detalle : '+IsNull(GastosFletes.Detalle,'')
 FROM GastosFletes
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo = GastosFletes.IdPresupuestoObrasNodo
 WHERE IsNull(GastosFletes.IdPresupuestoObrasNodo,0)>0 

 UNION ALL

 SELECT 30, pon.Descripcion, ponc.IdPresupuestoObrasNodo, ponc.Detalle, pon.IdObra, pon.IdPresupuestoObraRubro, 'CONSUMO DIRECTO', 
	Month(ponc.Fecha), Year(ponc.Fecha), ponc.Cantidad, ponc.Importe, 0, 0, ponc.Fecha, 
	Convert(varchar,ponc.Fecha,103)+' '+'CONS '+Substring('00000000',1,8-Len(Convert(varchar,ponc.Numero)))+Convert(varchar,ponc.Numero)
 FROM PresupuestoObrasNodosConsumos ponc 
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON ponc.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
 WHERE (@IdObra=-1 or pon.IdObra=@IdObra)

UPDATE #Auxiliar1
SET Cantidad=1
WHERE IsNull(Cantidad,0)=0

IF @TipoInforme='Detallado1'
    BEGIN
	INSERT INTO #Auxiliar1 
	 SELECT 0, pon.Descripcion, PxQ.IdPresupuestoObrasNodo, Null, pon.IdObra, Null, 'PRESUPUESTO', PxQ.Mes, PxQ.Año, 0, 0, PxQ.Cantidad, 
		PxQ.Importe, Null, 'PRESUPUESTO'
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 LEFT OUTER JOIN PresupuestoObrasNodos pon ON PxQ.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
	 WHERE (@IdObra=-1 or pon.IdObra=@IdObra) and PxQ.CodigoPresupuesto=0

	TRUNCATE TABLE _TempCuboPresupuestoObra
	INSERT INTO _TempCuboPresupuestoObra 
	 SELECT IsNull(CuentasGastos.Codigo+' ','')+CuentasGastos.Descripcion, 
		Convert(datetime,'1/'+Convert(varchar,#Auxiliar1.Mes)+'/'+Convert(varchar,#Auxiliar1.Año)), #Auxiliar1.Detalle1, 
		IsNull(#Auxiliar1.CantidadPresupuestada,0), IsNull(#Auxiliar1.ImportePresupuestado,0), IsNull(#Auxiliar1.Cantidad,0), 
		IsNull(#Auxiliar1.Importe,0)
	FROM #Auxiliar1 
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
	LEFT OUTER JOIN CuentasGastos On CuentasGastos.IdCuentaGasto=pon.IdCuentaGasto
	WHERE CuentasGastos.IdCuentaGasto is not null
    END

SET NOCOUNT OFF

IF @TipoInforme='Detallado'
    BEGIN
		SET NOCOUNT ON

		CREATE TABLE #Auxiliar2 
					(
					 IdObra INTEGER,
					 IdPresupuestoObrasNodo INTEGER,
					 IdNodoPadre INTEGER,
					 Descripcion VARCHAR(255),
					 TipoNodo INTEGER,
					 Lineage VARCHAR(255),
					 Item VARCHAR(20),
					 Depth INTEGER,
					 IdPresupuestoObraRubro INTEGER,
					 SubItem1 VARCHAR(10),
					 SubItem2 VARCHAR(10),
					 SubItem3 VARCHAR(10),
					 SubItem4 VARCHAR(10),
					 SubItem5 VARCHAR(10),
					 Descripcion1 VARCHAR(255),
					 Descripcion2 VARCHAR(255),
					 Descripcion3 VARCHAR(255),
					 Descripcion4 VARCHAR(255),
					 Descripcion5 VARCHAR(255)
					)
		INSERT INTO #Auxiliar2 
		 SELECT P.IdObra, P.IdPresupuestoObrasNodo, P.IdNodoPadre, IsNull(P.Descripcion,O.Descripcion), P.TipoNodo, P.Lineage, P.Item, P.Depth, 
				P.IdPresupuestoObraRubro, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, Null, Null, Null, Null, Null
		 FROM PresupuestoObrasNodos P
		 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
		 WHERE P.IdNodoPadre is null and IsNull(O.ActivarPresupuestoObra,'NO')='SI' and (@IdObra=-1 or P.IdObra=@IdObra)
		 ORDER BY P.IdObra, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, IsNull(P.Descripcion,O.Descripcion), P.IdPresupuestoObrasNodo

		INSERT INTO #Auxiliar2 
		 SELECT P.IdObra, P.IdPresupuestoObrasNodo, P.IdNodoPadre, P.Descripcion, P.TipoNodo, P.Lineage, P.Item, P.Depth, 
				P.IdPresupuestoObraRubro, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, Null, Null, Null, Null, Null
		 FROM PresupuestoObrasNodos P
		 LEFT OUTER JOIN Obras O ON P.IdObra = O.IdObra
		 WHERE P.IdNodoPadre is not null and IsNull(O.ActivarPresupuestoObra,'NO')='SI' and (@IdObra=-1 or P.IdObra=@IdObra)
		 ORDER BY P.IdObra, P.IdNodoPadre, P.SubItem1, P.SubItem2, P.SubItem3, P.SubItem4, P.SubItem5, P.Item, P.Descripcion, P.IdPresupuestoObrasNodo

		UPDATE #Auxiliar2
		SET Descripcion5=Item+' '+Descripcion, 
			Descripcion4=(Select Top 1 P4.Item+' '+P4.Descripcion From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre), 
			Descripcion3=(Select Top 1 P3.Item+' '+P3.Descripcion From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre)),
			Descripcion2=(Select Top 1 P2.Item+' '+P2.Descripcion From PresupuestoObrasNodos P2 Where P2.IdPresupuestoObrasNodo=(Select Top 1 P3.IdNodoPadre From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre))),
			Descripcion1=(Select Top 1 P1.Item+' '+P1.Descripcion From PresupuestoObrasNodos P1 Where P1.IdPresupuestoObrasNodo=(Select Top 1 P2.IdNodoPadre From PresupuestoObrasNodos P2 Where P2.IdPresupuestoObrasNodo=(Select Top 1 P3.IdNodoPadre From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre))))
		WHERE Depth=5

		UPDATE #Auxiliar2
		SET Descripcion4=Item+' '+Descripcion, 
			Descripcion3=(Select Top 1 P4.Item+' '+P4.Descripcion From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre), 
			Descripcion2=(Select Top 1 P3.Item+' '+P3.Descripcion From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre)),
			Descripcion1=(Select Top 1 P2.Item+' '+P2.Descripcion From PresupuestoObrasNodos P2 Where P2.IdPresupuestoObrasNodo=(Select Top 1 P3.IdNodoPadre From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre)))
		WHERE Depth=4

		UPDATE #Auxiliar2
		SET Descripcion3=Item+' '+Descripcion, 
			Descripcion2=(Select Top 1 P4.Item+' '+P4.Descripcion From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre), 
			Descripcion1=(Select Top 1 P3.Item+' '+P3.Descripcion From PresupuestoObrasNodos P3 Where P3.IdPresupuestoObrasNodo=(Select Top 1 P4.IdNodoPadre From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre))
		WHERE Depth=3

		UPDATE #Auxiliar2
		SET Descripcion2=Item+' '+Descripcion, 
			Descripcion1=(Select Top 1 P4.Item+' '+P4.Descripcion From PresupuestoObrasNodos P4 Where P4.IdPresupuestoObrasNodo=#Auxiliar2.IdNodoPadre)
		WHERE Depth=2

		UPDATE #Auxiliar2
		SET Descripcion1=Item+' '+Descripcion
		WHERE Depth=1

--		DELETE #Auxiliar2
--		WHERE Depth<>(Select MAX(Depth) From #Auxiliar2 A Where A.IdObra=#Auxiliar2.IdObra)

		SET NOCOUNT OFF

		SELECT
		 #Auxiliar2.IdPresupuestoObrasNodo,
		 Obras.NumeroObra as [NumeroObra],
		 Obras.Descripcion as [Obra],
		 #Auxiliar2.Descripcion1 as [Nivel 1],
		 #Auxiliar2.Descripcion2 as [Nivel 2],
		 #Auxiliar2.Descripcion3 as [Nivel 3],
		 #Auxiliar2.Descripcion4 as [Nivel 4],
		 #Auxiliar2.Descripcion5 as [Nivel 5],
		 #Auxiliar1.Material as [Material],
		 #Auxiliar1.Detalle as [Detalle],
		 #Auxiliar1.Detalle1 as [Detalle comprob.],
		 #Auxiliar1.Fecha as [Fecha],
		 Case When #Auxiliar2.IdPresupuestoObraRubro=@IdTipoArticuloManoObra Then IsNull(#Auxiliar1.Importe,0) Else Null End as [Rubro 1],
		 Case When #Auxiliar2.IdPresupuestoObraRubro=@IdTipoArticuloEquipos Then IsNull(#Auxiliar1.Importe,0) Else Null End as [Rubro 2],
		 Case When #Auxiliar2.IdPresupuestoObraRubro=@IdTipoArticuloMateriales Then IsNull(#Auxiliar1.Importe,0) Else Null End as [Rubro 3],
		 Case When #Auxiliar2.IdPresupuestoObraRubro=@IdTipoArticuloSubcontratos Then IsNull(#Auxiliar1.Importe,0) Else Null End as [Rubro 4],
		 Case When #Auxiliar2.IdPresupuestoObraRubro<>@IdTipoArticuloManoObra and  #Auxiliar2.IdPresupuestoObraRubro<>@IdTipoArticuloEquipos and  
				#Auxiliar2.IdPresupuestoObraRubro<>@IdTipoArticuloMateriales and  #Auxiliar2.IdPresupuestoObraRubro<>@IdTipoArticuloSubcontratos 
			Then IsNull(#Auxiliar1.Importe,0) Else Null End as [Rubro 5]
		FROM #Auxiliar2 
		LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar2.IdPresupuestoObrasNodo = #Auxiliar1.IdPresupuestoObrasNodo and #Auxiliar1.Fecha between @FechaDesde and @Fechahasta
		LEFT OUTER JOIN Obras ON Obras.IdObra = #Auxiliar2.IdObra
		LEFT OUTER JOIN Tipos On Tipos.IdTipo = #Auxiliar2.IdPresupuestoObraRubro
		WHERE IsNull(#Auxiliar1.Importe,0)<>0
		ORDER BY [NumeroObra], [Nivel 1], [Nivel 2], [Nivel 3], [Nivel 4], [Nivel 5], [Fecha], [Detalle comprob.]

		DROP TABLE #Auxiliar2
    END

IF @TipoInforme='Detallado1'
    BEGIN
	SELECT
	 Obras.NumeroObra as [NumeroObra],
	 Obras.Descripcion as [Obra],
	 CuentasGastos.Codigo as [Codigo],
	 CuentasGastos.Descripcion as [CentroCostos],
	 #Auxiliar1.Mes as [Mes],
	 #Auxiliar1.Año as [Año],
	 Sum(IsNull(#Auxiliar1.Cantidad,0)) as [Cantidad],
	 Sum(IsNull(#Auxiliar1.Importe,0)) as [Importe],
	 Sum(IsNull(#Auxiliar1.CantidadPresupuestada,0)) as [CantidadPresupuestada],
	 Sum(IsNull(#Auxiliar1.ImportePresupuestado,0)) as [ImportePresupuestado]
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN PresupuestoObrasNodos pon ON #Auxiliar1.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo
	LEFT OUTER JOIN CuentasGastos On CuentasGastos.IdCuentaGasto=pon.IdCuentaGasto
	WHERE CuentasGastos.IdCuentaGasto is not null
	GROUP BY Obras.NumeroObra, Obras.Descripcion, CuentasGastos.Codigo, CuentasGastos.Descripcion, #Auxiliar1.Año, #Auxiliar1.Mes
	ORDER BY Obras.NumeroObra, Obras.Descripcion, CuentasGastos.Codigo, CuentasGastos.Descripcion, #Auxiliar1.Año, #Auxiliar1.Mes

	DECLARE @Resultado INT
	EXEC @Resultado=master..xp_cmdshell @Dts
    END

IF @TipoInforme='Resumen1'
    BEGIN
	SELECT
	 Obras.NumeroObra as [NumeroObra],
	 Obras.Descripcion as [Obra],
	 Tipos.Descripcion as [Rubro],
	 Sum(Case When @Desde=0 and #Auxiliar1.Fecha<@FechaDesde
			Then IsNull(#Auxiliar1.Importe,0) 
			Else 0 
		End) as [Acumulado],
	 Sum(Case When (@Desde=-1 or (@Desde=0 and #Auxiliar1.Fecha>=@FechaDesde)) and (@Hasta=-1 or (@Hasta=0 and #Auxiliar1.Fecha<=@FechaHasta)) 
			Then IsNull(#Auxiliar1.Importe,0) 
			Else 0 
		End) as [Importe]
	FROM #Auxiliar1 
	LEFT OUTER JOIN Obras ON #Auxiliar1.IdObra = Obras.IdObra
	LEFT OUTER JOIN Tipos On Tipos.IdTipo=#Auxiliar1.IdPresupuestoObraRubro
	GROUP BY Obras.NumeroObra, Obras.Descripcion, Tipos.Descripcion
	ORDER BY Obras.NumeroObra, Tipos.Descripcion
    END

DROP TABLE #Auxiliar1