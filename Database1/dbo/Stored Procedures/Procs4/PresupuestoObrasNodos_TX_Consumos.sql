CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_Consumos]

@IdPresupuestoObrasNodo int,
@FechaDesde datetime = Null,
@FechaHasta datetime = Null,
@Excluyente varchar(2) = Null,
@IdObra int = Null

AS

SET NOCOUNT ON

SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,0)
SET @Excluyente=IsNull(@Excluyente,'NO')
SET @IdObra=IsNull(@IdObra,-1)

CREATE TABLE #Auxiliar0 (IdPresupuestoObrasNodo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdPresupuestoObrasNodo) ON [PRIMARY]
INSERT INTO #Auxiliar0 
 SELECT IdPresupuestoObrasNodo
 FROM PresupuestoObrasNodos
 WHERE (@IdPresupuestoObrasNodo=-1 or IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%', Lineage)>0) and (@IdObra=-1 or IdObra=@IdObra)

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
			 IdDetalleSalidaMateriales INTEGER, 
			 IdArticulo INTEGER, 
			 Fecha DATETIME, 
			 Cantidad NUMERIC(18,2), 
			 CantidadKit NUMERIC(18,2), 
			 ValorFleteUnitario NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1
 SELECT Det.IdDetalleSalidaMateriales, cv.IdArticulo, SalidasMateriales.FechaSalidaMateriales, IsNull(Det.Cantidad,0), IsNull(cv.Cantidad,0), 0
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN ConjuntosVersiones cv ON cv.IdArticuloConjunto=Det.IdArticulo and 
										  cv.FechaModificacion In (Select a502.FechaModificacion From #Auxiliar502 a502 
																	Where a502.IdArticuloConjunto=cv.IdArticuloConjunto and 
																		  a502.FechaModificacion2=(Select Top 1 a502_2.FechaModificacion2 From #Auxiliar502 a502_2 
																									Where a502_2.IdArticuloConjunto=a502.IdArticuloConjunto and a502_2.FechaModificacion2<=SalidasMateriales.FechaSalidaMateriales 
																									Order By a502_2.FechaModificacion2 Desc))
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	IsNull(Det.DescargaPorKit,'')='SI' and 
	IsNull(Det.IdPresupuestoObrasNodoFleteLarga,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta))
	

UPDATE #Auxiliar1
SET ValorFleteUnitario=IsNull((Select Top 1 fvp.Valor From FletesValoresPromedio fvp Where fvp.IdArticulo=#Auxiliar1.IdArticulo and fvp.Año=Year(#Auxiliar1.Fecha) and fvp.Mes=Month(#Auxiliar1.Fecha)),0)

CREATE TABLE #Auxiliar2 (
			 IdDetalleSalidaMateriales INTEGER, 
			 ValorFlete NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdDetalleSalidaMateriales, Sum(IsNull(#Auxiliar1.Cantidad,0)*IsNull(#Auxiliar1.CantidadKit,0)*IsNull(#Auxiliar1.ValorFleteUnitario,0))
 FROM #Auxiliar1
 GROUP BY IdDetalleSalidaMateriales

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111133'
SET @vector_T='0G993E344033300'

SELECT 
 Det.IdDetalleComprobanteProveedor as [IdAux], 
 TiposComprobante.Descripcion as [Tipo comp.], 
 cp.IdTipoComprobante as [IdAux1], 
 cp.IdComprobanteProveedor as [IdAux2], 
 cp.NumeroReferencia as [Nro.Ref.], 
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante], 
 Case 	When cp.IdProveedor is not null Then 'Cta. cte.' 
	When cp.IdCuenta is not null Then 'F.fijo' 
	When cp.IdCuentaOtros is not null Then 'Otros' 
	Else Null
 End as [Tipo], 
 IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante) as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha rec.], 
 IsNull(P1.RazonSocial,IsNull(P2.RazonSocial,C1.Descripcion)) as [Proveedor / Cuenta], 
 Det.Cantidad as [Cantidad],
 (IsNull(Det.ImporteIVA1,0) + IsNull(Det.ImporteIVA2,0) + IsNull(Det.ImporteIVA3,0) + IsNull(Det.ImporteIVA4,0) + IsNull(Det.ImporteIVA5,0) + IsNull(Det.ImporteIVA6,0) + 
	IsNull(Det.ImporteIVA7,0) + IsNull(Det.ImporteIVA8,0) + IsNull(Det.ImporteIVA9,0) + IsNull(Det.ImporteIVA10,0))*cp.CotizacionMoneda*TiposComprobante.Coeficiente as [Iva], 
 Det.Importe*cp.CotizacionMoneda*TiposComprobante.Coeficiente as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleComprobantesProveedores Det 
LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
LEFT OUTER JOIN Proveedores P1 ON cp.IdProveedor = P1.IdProveedor
LEFT OUTER JOIN Proveedores P2 ON cp.IdProveedorEventual = P2.IdProveedor
LEFT OUTER JOIN Cuentas C1 ON IsNull(cp.IdCuenta,cp.IdCuentaOtros) = C1.IdCuenta
LEFT OUTER JOIN Cuentas C2 ON Det.IdCuenta = C2.IdCuenta
LEFT OUTER JOIN TiposComprobante ON cp.IdTipoComprobante = TiposComprobante.IdTipoComprobante
LEFT OUTER JOIN DescripcionIva diva1 ON cp.IdCodigoIva = diva1.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva2 ON P1.IdCodigoIva = diva2.IdCodigoIva
LEFT OUTER JOIN DescripcionIva diva3 ON P2.IdCodigoIva = diva3.IdCodigoIva
LEFT OUTER JOIN DetalleRecepciones DetRec ON DetRec.IdDetalleRecepcion=Det.IdDetalleRecepcion
LEFT OUTER JOIN DetallePedidos DetPed ON DetPed.IdDetallePedido=Det.IdDetallePedido
LEFT OUTER JOIN DetalleRequerimientos DetReq ON DetReq.IdDetalleRequerimiento=IsNull(DetRec.IdDetalleRequerimiento,DetPed.IdDetalleRequerimiento)
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
WHERE IsNull(Det.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante) Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante) Between @FechaDesde And @FechaHasta))
--and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO'

UNION ALL

SELECT 
 Det.IdDetalleSalidaMateriales as [IdAux],
 'SAL.MAT.' as [Tipo comp.], 
 9 as [IdAux1], 
 SalidasMateriales.IdSalidaMateriales as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 dsmpo.Cantidad as [Cantidad],
 Null as [Iva], 
 Det.CostoUnitario*dsmpo.Cantidad as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales Det 
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
--LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull((Select Top 1 Conjuntos.IdObra From Conjuntos Where Conjuntos.IdArticulo=Det.IdArticulo),0)
WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	IsNull(Det.DescargaPorKit,'')<>'SI' and 
	((@Excluyente='NO' and (@FechaDesde=0 or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta))
--and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and (IsNull(Obras.EsPlantaDeProduccionInterna,'')<>'SI' or (IsNull(Obras.EsPlantaDeProduccionInterna,'')='SI' and IsNull(Det.DescargaPorKit,'')<>'SI'))

UNION ALL

SELECT 
 Det.IdDetalleSalidaMateriales as [IdAux],
 'SAL.ELAB.FLETE INT.' as [Tipo comp.], 
 9 as [IdAux1], 
 SalidasMateriales.IdSalidaMateriales as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 1 as [Cantidad],
 Null as [Iva], 
 Det.CostoFleteInterno as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales Det 
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	IsNull(Det.DescargaPorKit,'')='SI' and 
	IsNull(Det.IdPresupuestoObrasNodoFleteInterno,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta))

UNION ALL

SELECT 
 #Auxiliar2.IdDetalleSalidaMateriales as [IdAux],
 'SAL.ELAB.FLETE LARGA' as [Tipo comp.], 
 9 as [IdAux1], 
 SalidasMateriales.IdSalidaMateriales as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+
	Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+
	Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 1 as [Cantidad],
 Null as [Iva], 
 #Auxiliar2.ValorFlete as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN DetalleSalidasMateriales Det ON Det.IdDetalleSalidaMateriales=#Auxiliar2.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo

UNION ALL

SELECT 
 Det.IdDetalleSalidaMaterialesKit as [IdAux],
 'SAL.KIT' as [Tipo comp.], 
 9 as [IdAux1], 
 SalidasMateriales.IdSalidaMateriales as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 dsmpo.Cantidad as [Cantidad],
 Null as [Iva], 
 Articulos.CostoReposicion*dsmpo.Cantidad as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMaterialesKits Det 
LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
	((@Excluyente='NO' and (@FechaDesde=0 or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta)) and 
	IsNull(dsmpo.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) --and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 

UNION ALL

SELECT 
 Det.IdSubcontratoPxQ as [IdAux],
 'SUBCONTRATO' as [Tipo comp.], 
 70 as [IdAux1],
 Subcontratos.NumeroSubcontrato as [IdAux2],
 Substring('00000000',1,8-Len(Convert(varchar,Subcontratos.NumeroSubcontrato)))+Convert(varchar,Subcontratos.NumeroSubcontrato) as [Nro.Ref.], 
 Substring('00000000',1,8-Len(Convert(varchar,Det.NumeroCertificado)))+Convert(varchar,Det.NumeroCertificado) as [Comprobante], 
 Null as [Tipo], 
 dsd.FechaCertificadoHasta as [Fecha comp.], 
 Null as [Fecha rec.], 
 P1.RazonSocial as [Proveedor / Cuenta], 
 Det.CantidadAvance as [Cantidad], 
 Null as [Iva], 
 Det.ImporteTotal as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM SubcontratosPxQ Det 
LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor = SubcontratosDatos.IdProveedor
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Subcontratos.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodo
WHERE IsNull(Det.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and IsNull(Det.ImporteTotal,0)<>0 and 
	IsNull(SubcontratosDatos.Anulado,'')<>'SI' and 
	((@Excluyente='NO' and (@FechaDesde=0 or dsd.FechaCertificadoHasta Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not dsd.FechaCertificadoHasta Between @FechaDesde And @FechaHasta))

UNION ALL

SELECT 
 ponc.IdPresupuestoObrasNodoConsumo as [IdAux],
 'CONS.DIR.' as [Tipo comp.], 
 ponc.IdPresupuestoObrasNodoConsumo as [IdAux1],
 Null as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('00000000',1,8-Len(Convert(varchar,ponc.Numero)))+Convert(varchar,ponc.Numero) as [Comprobante], 
 Case When IsNull(ponc.Origen,'')='HH' Then 'Hs. hombre' 
	When IsNull(ponc.Origen,'')='HE' Then 'Hs. equipo' 
	Else Null 
 End as [Tipo], 
 ponc.Fecha as [Fecha comp.], 
 Null as [Fecha rec.], 
 ponc.Detalle COLLATE SQL_Latin1_General_CP1_CI_AS as [Proveedor / Cuenta], 
 ponc.Cantidad as [Cantidad],
 Null as [Iva], 
 ponc.Importe as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM PresupuestoObrasNodosConsumos ponc 
WHERE IsNull(ponc.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or ponc.Fecha Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not ponc.Fecha Between @FechaDesde And @FechaHasta))

UNION ALL

SELECT 
 PartesProduccion.IdParteProduccion as [IdAux],
 'PARTE PROD.' as [Tipo comp.], 
 PartesProduccion.IdParteProduccion as [IdAux1],
 Null as [IdAux2], 
 Null as [Nro.Ref.], 
 Substring('00000000',1,8-Len(Convert(varchar,PartesProduccion.NumeroParteProduccion)))+Convert(varchar,PartesProduccion.NumeroParteProduccion) as [Comprobante], 
 Null as [Tipo], 
 PartesProduccion.FechaParteProduccion as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 PartesProduccion.Cantidad as [Cantidad],
 Null as [Iva], 
 PartesProduccion.Cantidad*PartesProduccion.Importe as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM PartesProduccion
WHERE IsNull(PartesProduccion.IdPresupuestoObrasNodoMateriales,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or PartesProduccion.FechaParteProduccion Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not PartesProduccion.FechaParteProduccion Between @FechaDesde And @FechaHasta))

UNION ALL

SELECT 
 GastosFletes.IdGastoFlete as [IdAux],
 'GS.FLETES' as [Tipo comp.], 
 GastosFletes.IdGastoFlete as [IdAux1],
 Null as [IdAux2], 
 Null as [Nro.Ref.], 
 Null as [Comprobante], 
 Null as [Tipo], 
 GastosFletes.Fecha as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 1 as [Cantidad],
 GastosFletes.Iva * IsNull(GastosFletes.SumaResta,1) as [Iva], 
 GastosFletes.Total * IsNull(GastosFletes.SumaResta,1) as [Importe],
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM GastosFletes
WHERE IsNull(GastosFletes.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and 
	((@Excluyente='NO' and (@FechaDesde=0 or GastosFletes.Fecha Between @FechaDesde And @FechaHasta)) or 
	 (@Excluyente='SI' and not GastosFletes.Fecha Between @FechaDesde And @FechaHasta))

ORDER BY [Fecha comp.], [Tipo comp.], [Tipo], [Comprobante]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
