CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_ConsumosParaImputar]

@ActivarRangoFechas varchar(2) = Null,
@FechaDesde Datetime = Null,
@FechaHasta Datetime = Null,
@IncluirAsignados varchar(2) = Null,
@TipoMovimiento varchar(1) = Null,
@IdObra int = Null

AS

SET @ActivarRangoFechas=IsNull(@ActivarRangoFechas,'NO')
SET @FechaDesde=IsNull(@FechaDesde,0)
SET @FechaHasta=IsNull(@FechaHasta,GetDate())
SET @IncluirAsignados=IsNull(@IncluirAsignados,'NO')
SET @TipoMovimiento=IsNull(@TipoMovimiento,'T')
SET @IdObra=IsNull(@IdObra,-1)

SET NOCOUNT ON

DECLARE @TomarCuentaDePresupuestoEnComprobantesProveedores varchar(2)

SET @TomarCuentaDePresupuestoEnComprobantesProveedores=IsNull((Select Top 1 Valor From Parametros2 Where Campo='TomarCuentaDePresupuestoEnComprobantesProveedores'),'NO')

CREATE TABLE #Auxiliar501 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 datetime)
CREATE NONCLUSTERED INDEX IX__Auxiliar501 ON #Auxiliar501 (IdArticuloConjunto,FechaModificacion2,FechaModificacion Desc) ON [PRIMARY]
INSERT INTO #Auxiliar501 
 SELECT IdArticuloConjunto, FechaModificacion, FechaModificacion
 FROM ConjuntosVersiones

CREATE TABLE #Auxiliar502 (IdArticuloConjunto int, FechaModificacion datetime, FechaModificacion2 datetime)
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
 WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and 
	IsNull(SalidasMateriales.TipoSalida,1)<>4 and /* Descartar las salidas entre obras */
	IsNull(Det.DescargaPorKit,'')='SI' and 
	Det.IdEquipoDestino is null and 
	(@ActivarRangoFechas='NO' or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or IsNull(Det.IdPresupuestoObrasNodoFleteLarga,0)=0) and 
	(@TipoMovimiento='T' or @TipoMovimiento='S') and 
	(@IdObra<=0 or IsNull(SalidasMateriales.IdObra,Det.IdObra)=@IdObra) and 
	(IsNull(Det.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='SI') and 
	cv.IdArticulo is not null

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

DECLARE @IdTipoCuentaGrupoIVA int, @IdTipoCuentaPercepciones int

SET @IdTipoCuentaGrupoIVA=IsNull((Select IdTipoCuentaGrupoIVA From Parametros Where IdParametro=1),0)
SET @IdTipoCuentaPercepciones=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoCuentaGrupoPercepciones'),0)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111133'
SET @vector_T='0G99999GE3441D211E332500'

SET NOCOUNT OFF

SELECT 
 Det.IdDetalleComprobanteProveedor as [IdAux], 
 TiposComprobante.Descripcion as [Tipo comp.], 
 Det.IdDetalleComprobanteProveedor as [IdAux1], 
 Null as [IdAux2], 
 cp.IdTipoComprobante as [IdAux3], 
 Det.IdComprobanteProveedor as [IdAux4], 
 Det.IdObra as [IdAux5], 
 Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroReferencia)))+Convert(varchar,cp.NumeroReferencia) as [Nro.Ref.], 
 cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2) as [Comprobante], 
 Case When cp.IdProveedor is not null Then 'Cta. cte.' When cp.IdCuenta is not null Then 'F.fijo' When cp.IdCuentaOtros is not null Then 'Otros' Else Null End as [Tipo], 
 cp.FechaComprobante as [Fecha comp.], 
 cp.FechaRecepcion as [Fecha rec.], 
 IsNull(P1.RazonSocial,IsNull(P2.RazonSocial,C1.Descripcion)) as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 Det.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When Det.IdPresupuestoObrasNodo is null Then Null Else Det.Cantidad End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 (IsNull(Det.ImporteIVA1,0) + IsNull(Det.ImporteIVA2,0) + IsNull(Det.ImporteIVA3,0) + IsNull(Det.ImporteIVA4,0) + IsNull(Det.ImporteIVA5,0) + IsNull(Det.ImporteIVA6,0) + 
	IsNull(Det.ImporteIVA7,0) + IsNull(Det.ImporteIVA8,0) + IsNull(Det.ImporteIVA9,0) + IsNull(Det.ImporteIVA10,0))*cp.CotizacionMoneda*TiposComprobante.Coeficiente as [Iva], 
 Det.Importe*cp.CotizacionMoneda*TiposComprobante.Coeficiente as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 cp.Observaciones as [Observaciones], 
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
LEFT OUTER JOIN Unidades ON IsNull(DetRec.IdUnidad,IsNull(DetPed.IdUnidad,DetReq.IdUnidad)) = Unidades.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra = Det.IdObra
WHERE IsNull(cp.Confirmado,'')<>'NO' and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO' and  
	(@ActivarRangoFechas='NO' or IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante) Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or IsNull(Det.IdPresupuestoObrasNodo,0)=0) and  
	(@TipoMovimiento='T' or @TipoMovimiento='C') and 
	(@IdObra<=0 or Det.IdObra=@IdObra) and 
	IsNull(C2.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaGrupoIVA and IsNull(C2.IdTipoCuentaGrupo,-1)<>@IdTipoCuentaPercepciones and 
--	IsNull(Det.TomarEnCalculoDeImpuestos,'')<>'NO' and 
	Det.IdEquipoDestino is null and Det.IdDetalleRecepcion is null and IsNull(Det.NumeroSubcontrato,0)=0  and 
	Exists(Select Top 1 p.IdObra From PresupuestoObrasNodos p Where p.IdObra=Det.IdObra) and 
	IsNull(C2.ImputarAPresupuestoDeObra,'')='SI' and 
	(IsNull(Det.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='NO') 
--and (Obras.IdObra is null or IsNull(Obras.ActivarPresupuestoObra,'')='SI')
	
UNION ALL

SELECT 
 Det.IdDetalleSalidaMateriales as [IdAux],
 'SAL.MAT.' as [Tipo comp.], 
 Det.IdDetalleSalidaMateriales as [IdAux1],
 dsmpo.IdDetalleSalidaMaterialesPresupuestosObras as [IdAux2],
 50 as [IdAux3], 
 Det.IdSalidaMateriales as [IdAux4], 
 Det.IdObra as [IdAux5], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 Det.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When dsmpo.IdPresupuestoObrasNodo is null Then Null Else dsmpo.Cantidad End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva], 
 Det.CostoUnitario*Det.Cantidad as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 SalidasMateriales.Observaciones as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales Det 
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = dsmpo.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra = Det.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	IsNull(SalidasMateriales.TipoSalida,1)<>4 and /* Descartar las salidas entre obras */
	IsNull(Det.DescargaPorKit,'')<>'SI' and 
	Det.IdEquipoDestino is null and 
	(@ActivarRangoFechas='NO' or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or (IsNull(dsmpo.IdPresupuestoObrasNodo,0)=0 and @TomarCuentaDePresupuestoEnComprobantesProveedores='NO')) and 
	(@TipoMovimiento='T' or @TipoMovimiento='S') and 
	(@IdObra<=0 or IsNull(SalidasMateriales.IdObra,Det.IdObra)=@IdObra) and 
	(IsNull(Det.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='SI') 
--and (Obras.IdObra is null or IsNull(Obras.ActivarPresupuestoObra,'')='SI')

UNION ALL

-- SALIDA DE KIT (ELABORADO) => FLETE INTERNO
SELECT 
 Det.IdDetalleSalidaMateriales as [IdAux],
 'SAL.ELAB.FLETE INT.' as [Tipo comp.], 
 Det.IdSalidaMateriales as [IdAux1],
 Det.IdDetalleSalidaMateriales as [IdAux2],
 50 as [IdAux3], 
 Det.IdSalidaMateriales as [IdAux4], 
 Det.IdObra as [IdAux5], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 1 as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When Det.IdPresupuestoObrasNodoFleteInterno is null Then Null Else 1 End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva], 
 Det.CostoFleteInterno as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 SalidasMateriales.Observaciones as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMateriales Det 
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodoFleteInterno
LEFT OUTER JOIN Obras ON Obras.IdObra = Det.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and 
	IsNull(SalidasMateriales.TipoSalida,1)<>4 and /* Descartar las salidas entre obras */
	IsNull(Det.DescargaPorKit,'')='SI' and 
	Det.IdEquipoDestino is null and 
	(@ActivarRangoFechas='NO' or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or IsNull(Det.IdPresupuestoObrasNodoFleteInterno,0)=0) and 
	(@TipoMovimiento='T' or @TipoMovimiento='S') and 
	(@IdObra<=0 or IsNull(SalidasMateriales.IdObra,Det.IdObra)=@IdObra) and 
	(IsNull(Det.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='SI') 

UNION ALL

-- SALIDA DE KIT (ELABORADO) => FLETE LARGA
SELECT 
 #Auxiliar2.IdDetalleSalidaMateriales as [IdAux],
 'SAL.ELAB.FLETE LARGA' as [Tipo comp.], 
 Det.IdSalidaMateriales as [IdAux1],
 #Auxiliar2.IdDetalleSalidaMateriales as [IdAux2],
 50 as [IdAux3], 
 Det.IdSalidaMateriales as [IdAux4], 
 Det.IdObra as [IdAux5], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 1 as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When Det.IdPresupuestoObrasNodoFleteInterno is null Then Null Else 1 End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva], 
 #Auxiliar2.ValorFlete as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 SalidasMateriales.Observaciones as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN DetalleSalidasMateriales Det ON Det.IdDetalleSalidaMateriales=#Auxiliar2.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodoFleteLarga
LEFT OUTER JOIN Obras ON Obras.IdObra = Det.IdObra

UNION ALL

SELECT 
 Det.IdDetalleSalidaMaterialesKit as [IdAux],
 'SAL.KIT' as [Tipo comp.], 
 Det.IdDetalleSalidaMaterialesKit as [IdAux1],
 dsmpo.IdDetalleSalidaMaterialesPresupuestosObras as [IdAux2],
 50 as [IdAux3], 
 DetalleSalidasMateriales.IdSalidaMateriales as [IdAux4], 
 DetalleSalidasMateriales.IdObra as [IdAux5], 
 Null as [Nro.Ref.], 
 Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales) as [Comprobante], 
 Null as [Tipo], 
 SalidasMateriales.FechaSalidaMateriales as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 Det.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When dsmpo.IdPresupuestoObrasNodo is null Then Null Else dsmpo.Cantidad End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva],  Articulos.CostoReposicion*Det.Cantidad as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 SalidasMateriales.Observaciones as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM DetalleSalidasMaterialesKits Det 
LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
LEFT OUTER JOIN Unidades ON Det.IdUnidad = Unidades.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = dsmpo.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra = DetalleSalidasMateriales.IdObra
WHERE IsNull(SalidasMateriales.Anulada,'')<>'SI' and --IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' and 
	IsNull(SalidasMateriales.TipoSalida,1)<>4 and /* Descartar las salidas entre obras */
	DetalleSalidasMateriales.IdEquipoDestino is null and 
	(@ActivarRangoFechas='NO' or SalidasMateriales.FechaSalidaMateriales Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or (IsNull(dsmpo.IdPresupuestoObrasNodo,0)=0 and @TomarCuentaDePresupuestoEnComprobantesProveedores='NO')) and 
	(@TipoMovimiento='T' or @TipoMovimiento='S') and 
	(@IdObra<=0 or DetalleSalidasMateriales.IdObra=@IdObra) and 
	(IsNull(Det.IdArticulo,0)=0 or IsNull(Articulos.RegistrarStock,'SI')='SI') 
--and (Obras.IdObra is null or IsNull(Obras.ActivarPresupuestoObra,'')='SI')

UNION ALL

SELECT 
 Det.IdSubcontratoPxQ as [IdAux],
 'SUBCONTRATO' as [Tipo comp.], 
 Det.IdSubcontratoPxQ as [IdAux1],
 Null as [IdAux2],
 70 as [IdAux3], 
 Subcontratos.NumeroSubcontrato as [IdAux4], 
 SubcontratosDatos.IdObra as [IdAux5], 
 Substring('00000000',1,8-Len(Convert(varchar,Subcontratos.NumeroSubcontrato)))+Convert(varchar,Subcontratos.NumeroSubcontrato) as [Nro.Ref.], 
 Substring('00000000',1,8-Len(Convert(varchar,Det.NumeroCertificado)))+Convert(varchar,Det.NumeroCertificado) as [Comprobante], 
 Null as [Tipo], 
 dsd.FechaCertificadoHasta as [Fecha comp.], 
 Null as [Fecha rec.], 
 P1.RazonSocial as [Proveedor / Cuenta], 
 Subcontratos.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS as [Material],
 Subcontratos.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Det.CantidadAvance as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva], 
 Det.ImporteTotal as [Importe],
 Null as [Obra],
 Null as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM SubcontratosPxQ Det 
LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
LEFT OUTER JOIN Proveedores P1 ON P1.IdProveedor = SubcontratosDatos.IdProveedor
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = Subcontratos.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = Det.IdPresupuestoObrasNodo
WHERE (@ActivarRangoFechas='NO' or dsd.FechaCertificadoHasta Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or IsNull(Det.IdPresupuestoObrasNodo,0)=0) and Det.NumeroCertificado is not null and 
	(@TipoMovimiento='T' or @TipoMovimiento='U') and IsNull(Det.ImporteTotal,0)<>0 and IsNull(SubcontratosDatos.Anulado,'')<>'SI'

UNION ALL

SELECT 
 PartesProduccion.IdParteProduccion as [IdAux],
 'PARTE PROD.' as [Tipo comp.], 
 PartesProduccion.IdParteProduccion as [IdAux1],
 Null as [IdAux2],
 71 as [IdAux3], 
 PartesProduccion.IdParteProduccion as [IdAux4],
 PartesProduccion.IdObra as [IdAux5], 
 Null as [Nro.Ref.], 
 Substring('00000000',1,8-Len(Convert(varchar,PartesProduccion.NumeroParteProduccion)))+Convert(varchar,PartesProduccion.NumeroParteProduccion) as [Comprobante], 
 Null as [Tipo], 
 PartesProduccion.FechaParteProduccion as [Fecha comp.], 
 Null as [Fecha rec.], 
 Null as [Proveedor / Cuenta], 
 Articulos.Descripcion as [Material],
 PartesProduccion.Cantidad as [Cant.], 
 Unidades.Abreviatura as [Un.],
 Case When PartesProduccion.IdPresupuestoObrasNodo is null Then Null Else PartesProduccion.Cantidad End as [Cant.Asig.], 
 PresupuestoObrasNodos.Item+' - '+PresupuestoObrasNodos.Descripcion as [Etapa],
 Null as [Iva], 
 PartesProduccion.Importe*PartesProduccion.Cantidad as [Importe],
 Obras.NumeroObra+' '+Obras.Descripcion as [Obra],
 Null as [Observaciones], 
 @Vector_T as Vector_T, 
 @Vector_X as Vector_X
FROM PartesProduccion 
LEFT OUTER JOIN Articulos ON Articulos.IdArticulo = PartesProduccion.IdArticulo
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad = PartesProduccion.IdUnidad
LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo = PartesProduccion.IdPresupuestoObrasNodo
LEFT OUTER JOIN Obras ON Obras.IdObra = PartesProduccion.IdObra
WHERE (@ActivarRangoFechas='NO' or PartesProduccion.FechaParteProduccion Between @FechaDesde And @FechaHasta) and 
	(@IncluirAsignados='SI' or IsNull(PartesProduccion.IdPresupuestoObrasNodo,0)=0) and 
	(@IdObra<=0 or PartesProduccion.IdObra=@IdObra) and 
	(@TipoMovimiento='T' or @TipoMovimiento='P') and 
	IsNull(Obras.ActivarPresupuestoObra,'')='SI'

ORDER BY [Fecha comp.], [Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar501
DROP TABLE #Auxiliar502
