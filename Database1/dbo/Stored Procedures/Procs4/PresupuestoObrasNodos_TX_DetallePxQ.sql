CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_DetallePxQ]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int = Null,
@Comparar1 int = Null,
@Comparar2 int = Null,
@CompararTomandoReal int = Null,
@IdentificadorSesion int = Null

AS 

SET NOCOUNT ON

SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,-1)
SET @Comparar1=IsNull(@Comparar1,-2)
SET @Comparar2=IsNull(@Comparar2,-2)
SET @CompararTomandoReal=IsNull(@CompararTomandoReal,0)
SET @IdentificadorSesion=IsNull(@IdentificadorSesion,-1)

DECLARE @Elementos int, @ConHijos varchar(2), @IdNodoPadre int

SET @ConHijos='NO'
IF Exists(Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where IsNull(IdNodoPadre,0)=@IdPresupuestoObrasNodo)
	SET @ConHijos='SI'

SET @IdNodoPadre=IsNull((Select Top 1 IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)

CREATE TABLE #Auxiliar0 (IdPresupuestoObrasNodo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (IdPresupuestoObrasNodo) ON [PRIMARY]
INSERT INTO #Auxiliar0 
 SELECT IdPresupuestoObrasNodo
 FROM PresupuestoObrasNodos
 WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo or Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%', Lineage)>0

SET @Elementos=IsNull((Select Count(*) From #Auxiliar0),0)

CREATE TABLE #Auxiliar3 
			(
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 4),
			 Importe NUMERIC(18, 2),
			 CantidadTeorica NUMERIC(18, 4),
			 CantidadPresupuestoPadre NUMERIC(18, 2),
			 CantidadRealPadre NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar3 
 SELECT Year(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), Month(IsNull(cp.FechaAsignacionPresupuesto,cp.FechaComprobante)), 
		Det.Cantidad, Det.Importe*cp.CotizacionMoneda*tc.Coeficiente, Null, Null, Null
 FROM DetalleComprobantesProveedores Det 
 LEFT OUTER JOIN ComprobantesProveedores cp ON Det.IdComprobanteProveedor=cp.IdComprobanteProveedor
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=cp.IdTipoComprobante
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(Det.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) --and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='NO'

INSERT INTO #Auxiliar3 
 SELECT Year(SalidasMateriales.FechaSalidaMateriales), Month(SalidasMateriales.FechaSalidaMateriales), dsmpo.Cantidad, Det.CostoUnitario*dsmpo.Cantidad, Null, Null, Null
 FROM DetalleSalidasMateriales Det 
 LEFT OUTER JOIN SalidasMateriales ON Det.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMateriales=dsmpo.IdDetalleSalidaMateriales
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Obras ON Obras.IdObra=IsNull((Select Top 1 Conjuntos.IdObra From Conjuntos Where Conjuntos.IdArticulo=Det.IdArticulo),0)
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and IsNull(Det.DescargaPorKit,'')<>'SI'
--and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 
--and (IsNull(Obras.EsPlantaDeProduccionInterna,'')<>'SI' or (IsNull(Obras.EsPlantaDeProduccionInterna,'')='SI' and IsNull(Det.DescargaPorKit,'')<>'SI'))

INSERT INTO #Auxiliar3 
 SELECT Year(SalidasMateriales.FechaSalidaMateriales), Month(SalidasMateriales.FechaSalidaMateriales), dsmpo.Cantidad, Articulos.CostoReposicion*dsmpo.Cantidad, Null, Null, Null
 FROM DetalleSalidasMaterialesKits Det 
 LEFT OUTER JOIN DetalleSalidasMateriales ON Det.IdDetalleSalidaMateriales=DetalleSalidasMateriales.IdDetalleSalidaMateriales
 LEFT OUTER JOIN SalidasMateriales ON DetalleSalidasMateriales.IdSalidaMateriales=SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN DetalleSalidasMaterialesPresupuestosObras dsmpo ON Det.IdDetalleSalidaMaterialesKit=dsmpo.IdDetalleSalidaMaterialesKit
 LEFT OUTER JOIN Articulos ON Det.IdArticulo = Articulos.IdArticulo
 WHERE IsNull(dsmpo.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) --and IsNull(Articulos.ADistribuirEnPresupuestoDeObra,'NO')='SI' 

INSERT INTO #Auxiliar3 
 SELECT Year(dsd.FechaCertificadoHasta), Month(dsd.FechaCertificadoHasta), IsNull(Det.CantidadAvance,0), IsNull(Det.ImporteTotal,0), Null, Null, Null
 FROM SubcontratosPxQ Det 
 LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=Det.IdSubcontrato
 LEFT OUTER JOIN SubcontratosDatos ON SubcontratosDatos.NumeroSubcontrato=Subcontratos.NumeroSubcontrato
 LEFT OUTER JOIN DetalleSubcontratosDatos dsd ON dsd.IdSubcontratoDatos=SubcontratosDatos.IdSubcontratoDatos and dsd.NumeroCertificado=Det.NumeroCertificado
 WHERE dsd.FechaCertificadoHasta is not null and IsNull(Det.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0) and IsNull(SubcontratosDatos.Anulado,'')<>'SI'

INSERT INTO #Auxiliar3 
 SELECT Year(ponc.Fecha), Month(ponc.Fecha), ponc.Cantidad, ponc.Importe, Null, Null, Null
 FROM PresupuestoObrasNodosConsumos ponc 
 WHERE IsNull(ponc.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0)

INSERT INTO #Auxiliar3 
 SELECT Year(PartesProduccion.FechaParteProduccion), Month(PartesProduccion.FechaParteProduccion), PartesProduccion.Cantidad, PartesProduccion.Cantidad*PartesProduccion.Importe, Null, Null, Null
 FROM PartesProduccion 
 WHERE IsNull(PartesProduccion.IdPresupuestoObrasNodoMateriales,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0)

INSERT INTO #Auxiliar3 
 SELECT Year(GastosFletes.Fecha), Month(GastosFletes.Fecha), 1, GastosFletes.Total * IsNull(GastosFletes.SumaResta,1), Null, Null, Null
 FROM GastosFletes 
 WHERE IsNull(GastosFletes.IdPresupuestoObrasNodo,0) In (Select IdPresupuestoObrasNodo From #Auxiliar0)

IF @IdentificadorSesion<=0
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, Null, PxQ.CantidadTeorica, Null
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdNodoPadre and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)

	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, Null, Null, PxQ.CantidadAvance
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdNodoPadre and PxQ.CodigoPresupuesto=0

	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, PxQ.CantidadTeorica, Null, Null
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, Null, PxQ.CantidadTeorica,Null
	 FROM _TempPresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdentificadorSesion=@IdentificadorSesion and PxQ.IdPresupuestoObrasNodo=@IdNodoPadre and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)

	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, Null, Null, PxQ.CantidadAvance
	 FROM _TempPresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdentificadorSesion=@IdentificadorSesion and PxQ.IdPresupuestoObrasNodo=@IdNodoPadre and PxQ.CodigoPresupuesto=0

/*
	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, PxQ.CantidadTeorica, Null, Null
	 FROM _TempPresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdentificadorSesion=@IdentificadorSesion and PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
*/
	INSERT INTO #Auxiliar3 
	 SELECT PxQ.Año, PxQ.Mes, Null, Null, PxQ.CantidadTeorica, Null, Null
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
  END


CREATE TABLE #Auxiliar4 
			(
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 4),
			 Importe NUMERIC(18, 2),
			 CantidadTeorica NUMERIC(18, 4),
			 CantidadPresupuestoPadre NUMERIC(18, 2),
			 CantidadRealPadre NUMERIC(18, 4)
			)
INSERT INTO #Auxiliar4 
 SELECT #Auxiliar3.Año, #Auxiliar3.Mes, Sum(IsNull(#Auxiliar3.Cantidad,0)), Sum(IsNull(#Auxiliar3.Importe,0)), Sum(IsNull(#Auxiliar3.CantidadTeorica,0)), 
	Sum(IsNull(#Auxiliar3.CantidadPresupuestoPadre,0)), Sum(IsNull(#Auxiliar3.CantidadRealPadre,0))
 FROM #Auxiliar3
 GROUP BY #Auxiliar3.Año, #Auxiliar3.Mes

--select * from #Auxiliar4 order by año,mes

CREATE TABLE #Auxiliar1 
			(
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 4),
			 Importe NUMERIC(18, 2),
			 CantidadReal NUMERIC(18, 4),
			 ImporteReal NUMERIC(18, 2),
			 CantidadTeorica NUMERIC(18, 4),
			 Certificado NUMERIC(18, 4),
			 CantidadRealPadre NUMERIC(18, 4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Año,Mes) ON [PRIMARY]

IF @Comparar1=-2
--	IF @IdentificadorSesion<=0
	  BEGIN
		INSERT INTO #Auxiliar1 
		 SELECT PxQ.Año, PxQ.Mes, 
			Case When @CompararTomandoReal=1 
				Then Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else 0 End 
				Else PxQ.Cantidad 
			End, 
			Case When @CompararTomandoReal=1 
				Then Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else 0 End Else 0 End 
				Else PxQ.Importe 
			End,
			0, 0, PxQ.CantidadTeorica, 0, #Auxiliar4.CantidadRealPadre
		 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
		 LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.Año=PxQ.Año and #Auxiliar4.Mes=PxQ.Mes
		 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)

		INSERT INTO #Auxiliar1 
		 SELECT PxQ.Año, PxQ.Mes, 
			Case When @CompararTomandoReal=1 
				Then Case When @ConHijos='NO' Then 0 Else PxQ.CantidadAvance End 
				Else 0
			End, 
			Case When @CompararTomandoReal=1 
				Then Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then 0 Else PxQ.CantidadAvance End Else 0 End 
				Else 0
			End,
			Case When @Elementos<=1 Then 0 Else PxQ.CantidadAvance End, 0, 0, PxQ.Certificado, 0
		 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
		 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and PxQ.CodigoPresupuesto=0
	  END
/*
	ELSE
	  BEGIN
		INSERT INTO #Auxiliar1 
		 SELECT PxQ.Año, PxQ.Mes, 
			Case When @CompararTomandoReal=1 
				Then Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else 0 End 
				Else PxQ.Cantidad 
			End, 
			Case When @CompararTomandoReal=1 
				Then Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else 0 End Else 0 End 
				Else PxQ.Importe 
			End,
			0, 0, PxQ.CantidadTeorica, 0
		 FROM _TempPresupuestoObrasNodosPxQxPresupuesto PxQ
		 LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.Año=PxQ.Año and #Auxiliar4.Mes=PxQ.Mes
		 WHERE PxQ.IdentificadorSesion=@IdentificadorSesion and PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo --and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)

		INSERT INTO #Auxiliar1 
		 SELECT PxQ.Año, PxQ.Mes, 
			Case When @CompararTomandoReal=1 
				Then Case When @ConHijos='NO' Then 0 Else PxQ.CantidadAvance End 
				Else 0
			End, 
			Case When @CompararTomandoReal=1 
				Then Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then 0 Else PxQ.CantidadAvance End Else 0 End 
				Else 0
			End,
			Case When @Elementos<=1 Then 0 Else PxQ.CantidadAvance End, 0, 0, PxQ.Certificado
		 FROM _TempPresupuestoObrasNodosPxQxPresupuesto PxQ
		 WHERE PxQ.IdentificadorSesion=@IdentificadorSesion and PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo --and PxQ.CodigoPresupuesto=0
	  END
*/

IF @Comparar1=-1
	INSERT INTO #Auxiliar1 
	 SELECT #Auxiliar4.Año, #Auxiliar4.Mes, #Auxiliar4.Cantidad, #Auxiliar4.Importe, 0, 0, 0, 0, #Auxiliar4.CantidadRealPadre
	 FROM #Auxiliar4 

IF @Comparar1>=0
	INSERT INTO #Auxiliar1 
	 SELECT PxQ.Año, PxQ.Mes, 
		Case When @Elementos<=1 Then 0 Else PxQ.CantidadTeorica End, 
		Case When @ConHijos='NO' Then 0 Else Case When @CompararTomandoReal=1 Then PxQ.CantidadAvance Else PxQ.Cantidad End	* PxQ.Importe End, 
			--IsNull((Select Top 1 Importe From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@Comparar1),0) End, -- 0, 
		Case When @CompararTomandoReal=1 
			Then Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else PxQ.CantidadAvance End 
			Else PxQ.Cantidad 
		End, 
		Case When @CompararTomandoReal=1 
			Then #Auxiliar4.Importe --Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else PxQ.CantidadAvance End Else 0 End 
			Else PxQ.Importe 
		End,
		PxQ.CantidadTeorica, PxQ.Certificado, #Auxiliar4.CantidadRealPadre
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.Año=PxQ.Año and #Auxiliar4.Mes=PxQ.Mes
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and PxQ.CodigoPresupuesto=@Comparar1
--select * from #Auxiliar1 order by año,mes

IF @Comparar2=-2
	INSERT INTO #Auxiliar1 
	 SELECT Año, Mes, 
		0, 0, 
		Case When @CompararTomandoReal=1 
			Then Case When CantidadPresupuestoPadre<>0 Then CantidadRealPadre/CantidadPresupuestoPadre*CantidadTeorica Else 0 End 
			Else Case When @Elementos<=1 Then Cantidad Else 0 End 
		End, 
		Importe, 0, 0, CantidadRealPadre
	 FROM #Auxiliar4 
/*
	 SELECT #Auxiliar4.Año, #Auxiliar4.Mes, 0, 0, Case When @Elementos<=1 Then #Auxiliar4.Cantidad Else 0 End, #Auxiliar4.Importe, 0, 0
	 FROM #Auxiliar4 
*/

IF @Comparar2=-1
	INSERT INTO #Auxiliar1 
	 SELECT Año, Mes, 
		Case When @CompararTomandoReal=1 
			Then Case When CantidadPresupuestoPadre<>0 Then CantidadRealPadre/CantidadPresupuestoPadre*CantidadTeorica Else 0 End 
			Else Case When @Elementos<=1 Then Cantidad Else 0 End 
		End, 
		Case When @CompararTomandoReal=1 
			Then Case When CantidadPresupuestoPadre<>0 Then CantidadRealPadre/CantidadPresupuestoPadre*CantidadTeorica Else 0 End 
			Else Case When @Elementos<=1 Then Cantidad Else 0 End 
		End * IsNull((Select Top 1 PxQ.Importe From PresupuestoObrasNodosPxQxPresupuesto PxQ Where PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and PxQ.CodigoPresupuesto=@CodigoPresupuesto and PxQ.Año=#Auxiliar4.Año and PxQ.Mes=#Auxiliar4.Mes),0), --Importe, 
		0, 0, 0, 0, CantidadRealPadre
	 FROM #Auxiliar4 
/*
select *,@ConHijos,(Select Top 1 Importe From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto)
from #Auxiliar4 order by año,mes
*/
IF @Comparar2>=0
	INSERT INTO #Auxiliar1 
	 SELECT PxQ.Año, PxQ.Mes, 0, 0, Case When @CompararTomandoReal=1 Then Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else PxQ.CantidadAvance End Else PxQ.Cantidad End, 
			Case When @CompararTomandoReal=1 Then Case When PxQ.CantidadTeorica<>0 Then PxQ.Importe/PxQ.CantidadTeorica*Case When @ConHijos='NO' Then #Auxiliar4.Cantidad Else PxQ.CantidadAvance End Else 0 End Else PxQ.Importe End, 
			PxQ.CantidadTeorica, PxQ.Certificado, #Auxiliar4.CantidadRealPadre
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 LEFT OUTER JOIN #Auxiliar4 ON #Auxiliar4.Año=PxQ.Año and #Auxiliar4.Mes=PxQ.Mes
	 WHERE PxQ.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and PxQ.CodigoPresupuesto=@Comparar2


CREATE TABLE #Auxiliar2 
			(
			 Año INTEGER,
			 Mes INTEGER,
			 Cantidad NUMERIC(18, 4),
			 Importe NUMERIC(18, 2),
			 CantidadReal NUMERIC(18, 4),
			 ImporteReal NUMERIC(18, 2),
			 CantidadTeorica NUMERIC(18, 4),
			 Certificado NUMERIC(18, 4),
			 CantidadRealPadre NUMERIC(18, 4), 
			 Redeterminaciones NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT Año, Mes, Sum(IsNull(Cantidad,0)), Sum(IsNull(Importe,0)), Sum(IsNull(CantidadReal,0)), Sum(IsNull(ImporteReal,0)), Sum(IsNull(CantidadTeorica,0)), Sum(IsNull(Certificado,0)), 0, 0
 FROM #Auxiliar1
 GROUP BY Año, Mes

UPDATE #Auxiliar2
SET CantidadRealPadre=ISNULL((Select Top 1 #Auxiliar1.CantidadRealPadre From #Auxiliar1 Where #Auxiliar1.Año=#Auxiliar2.Año and #Auxiliar1.Mes=#Auxiliar2.Mes and ISNULL(#Auxiliar1.CantidadRealPadre,0)<>0),0)

UPDATE #Auxiliar2
SET Redeterminaciones=ISNULL((Select Top 1 Sum(IsNull(por.Importe,0)) From PresupuestoObrasRedeterminaciones por Where por.Año=#Auxiliar2.Año and por.Mes=#Auxiliar2.Mes and por.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)

SET NOCOUNT ON

--select * from #Auxiliar1 order by Año, Mes

SELECT *
FROM #Auxiliar2
ORDER BY Año, Mes

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4