CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_EtapasImputablesPorObraParaCombo]  
  
@IdObra int = Null,  
@PresupuestoObraRubro varchar(1) = Null,  
@CodigoPresupuesto int = Null,  
@ConHijos varchar(2) = Null,  
@Resumen varchar(30) = Null  

AS   

SET NOCOUNT ON  
  
SET @IdObra=IsNull(@IdObra,-1)  
SET @PresupuestoObraRubro=IsNull(@PresupuestoObraRubro,'*')  
SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)  
SET @ConHijos=IsNull(@ConHijos,'*')  
SET @Resumen=IsNull(@Resumen,'')  
  
DECLARE @IdPresupuestoObraRubro1 int, @IdPresupuestoObraRubro2 int, @proc_name varchar(1000), @IdPresupuestoObrasNodo int, @Etapa varchar(200), 
		@Rubro varchar(50), @IdNodoPadre int, @CantidadTeoricaTotal numeric(18,2), @CantidadTeoricaTotalPadre numeric(18,2), 
		@ImporteTeoricaTotal numeric(18,2), @ImporteTeoricaTotalPadre numeric(18,2)  
  
SET @IdPresupuestoObraRubro1=-1  
SET @IdPresupuestoObraRubro2=-1  
  
IF @PresupuestoObraRubro='M'  
	SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloMateriales'),0)  
	SET @IdPresupuestoObraRubro2=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloAuxiliares'),0)  
IF @PresupuestoObraRubro='E'  
	SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloEquipos'),0)  
IF @PresupuestoObraRubro='O'  
	SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloManoObra'),0)  
IF @PresupuestoObraRubro='S'  
	SET @IdPresupuestoObraRubro1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdTipoArticuloSubcontratos'),0)  
  
CREATE TABLE #Auxiliar10 (IdPresupuestoObrasNodo INTEGER, Hijos VARCHAR(2), ConHijosPadres VARCHAR(2))  
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar10 (IdPresupuestoObrasNodo) ON [PRIMARY]  
INSERT INTO #Auxiliar10   
 SELECT pon.IdPresupuestoObrasNodo,   
		 --Case When Exists(Select Top 1 pon1.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon1 Where Patindex('%/'+Convert(varchar,pon.IdPresupuestoObrasNodo)+'/%', pon1.Lineage)>0) Then 'SI' Else 'NO' End  
		 Case When Exists(Select Top 1 pon1.IdNodoPadre From PresupuestoObrasNodos pon1 Where pon1.IdNodoPadre=pon.IdPresupuestoObrasNodo) Then 'SI' Else 'NO' End,  
		 Case When IsNull((Select Top 1 (Select Top 1 pon2.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon2 Where pon2.IdNodoPadre=pon1.IdPresupuestoObrasNodo) From PresupuestoObrasNodos pon1 Where pon1.IdNodoPadre=pon.IdPresupuestoObrasNodo),0)>0 Then 'SI' Else 'NO' End 
 FROM PresupuestoObrasNodos pon  
 LEFT OUTER JOIN Obras O ON O.IdObra = pon.IdObra  
 WHERE (@IdObra=-1 or pon.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and pon.IdNodoPadre is not null  
  
SET NOCOUNT OFF  
  
IF @Resumen=''  
	SELECT P.*, pond.Importe, pond.Cantidad, pond.CantidadBase, pond.Rendimiento, pond.Incidencia, pond.Costo, U.Abreviatura as [Unidad],   
			IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo],   
			C.Codigo as [CCostos], pond.PrecioVentaUnitario, RTrim(LTrim(IsNull(R.Descripcion,'Varios'))) as [Rubro], a.Hijos as [Hijos], a.ConHijosPadres as [ConHijosPadres]  
	FROM PresupuestoObrasNodos P  
	LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto  
	LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
	LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
	LEFT OUTER JOIN Unidades U ON P.idUnidad=U.IdUnidad  
	LEFT OUTER JOIN CuentasGastos C ON P.IdCuentaGasto=C.IdCuentaGasto  
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
	LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
			(@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
			(@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
	ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloPadres'  
	SELECT P.IdPresupuestoObrasNodo, IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo], P.Item as [Item], pond.PrecioVentaUnitario
	FROM PresupuestoObrasNodos P  
	LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto  
	LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
	LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
	LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and a.Hijos='SI'  
	ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloHijos'  
	SELECT P.IdPresupuestoObrasNodo, IsNull(P.Item+' ','') + IsNull(P2.Descripcion+' - ', '') + IsNull(P.Descripcion, Obras.Descripcion) as [Titulo], P.Item as [Item]  
	FROM PresupuestoObrasNodos P  
	LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
	LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
	LEFT OUTER JOIN PresupuestoObrasNodos P2 ON P2.IdPresupuestoObrasNodo=P.IdNodoPadre  
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
			(@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
			(@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
	ORDER BY P.Subitem1, P.Subitem2, P.Subitem3, P.Subitem4, P.Subitem5, P.Item, P.Descripcion  
  
IF @Resumen='SoloHijosPorRubro'  
	SELECT DISTINCT RTrim(LTrim(IsNull(P.Descripcion,Obras.Descripcion))) as [Etapa], RTrim(LTrim(IsNull(R.Descripcion,'Varios'))) as [Rubro]  
	FROM PresupuestoObrasNodos P  
	LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
	LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
	(@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
	(@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
	ORDER BY [Rubro], [Etapa]  
  
IF @Resumen='SoloHijosPorRubroConCostos' or @Resumen='SoloHijosPorRubroConCostosRs' or @Resumen='SoloHijosPorRubroConCostosRs2' or @Resumen='SoloHijosPorRubroConCostosRs3'  
  BEGIN  
	SET NOCOUNT ON  

	SET @proc_name='PresupuestoObrasNodos_TX_DetallePxQ'  

	CREATE TABLE #Auxiliar8   
	(  
	 Año INTEGER,  
	 Mes INTEGER,  
	 Cantidad NUMERIC(18, 2),  
	 Importe NUMERIC(18, 2),  
	 CantidadReal NUMERIC(18, 2),  
	 ImporteReal NUMERIC(18, 2),  
	 CantidadTeorica NUMERIC(18, 4),  
	 Certificado NUMERIC(18, 2),  
	 CantidadRealPadre NUMERIC(18, 2),  
	 Redeterminaciones NUMERIC(18, 2)  
	)  

	CREATE TABLE #Auxiliar91   
	(  
	 IdPresupuestoObrasNodo INTEGER,  
	 Etapa VARCHAR(200),  
	 Rubro VARCHAR(50),  
	 Año INTEGER,  
	 Mes INTEGER,  
	 Cantidad NUMERIC(18, 2),  
	 Importe NUMERIC(18, 2),  
	 CantidadReal NUMERIC(18, 2),  
	 ImporteReal NUMERIC(18, 2),  
	 CantidadTeorica NUMERIC(18, 4),  
	 Certificado NUMERIC(18, 2),  
	 CantidadRealPadre NUMERIC(18, 2),  
	 CantidadTeoricaTotal NUMERIC(18, 4),  
	 CantidadTeoricaTotalPadre NUMERIC(18, 4),  
	 CantidadProporcionalConPadre NUMERIC(18, 2),  
	 PrecioUnitarioTeorico NUMERIC(18, 2),  
	 PrecioUnitarioReal NUMERIC(18, 2),  
	 ConPrecioUnitarioTeorico INTEGER,  
	 ConPrecioUnitarioReal INTEGER,  
	 PrecioUnitarioTeoricoTotal NUMERIC(18, 2)  
	)  

	CREATE TABLE #Auxiliar92   
	(  
	 Etapa VARCHAR(200),  
	 Rubro VARCHAR(50),  
	 Año INTEGER,  
	 Mes INTEGER,  
	 CantidadTeorica NUMERIC(18, 4),  
	 PrecioUnitarioTeorico NUMERIC(18, 2),  
	 Importe NUMERIC(18, 2),  
	 CantidadReal NUMERIC(18, 2),  
	 PrecioUnitarioReal NUMERIC(18, 2),  
	 ImporteReal NUMERIC(18, 2),  
	 SumaPrecioUnitarioTeorico NUMERIC(18, 2),  
	 SumaPrecioUnitarioReal NUMERIC(18, 2),  
	 SumaConPrecioUnitarioTeorico INTEGER,  
	 SumaConPrecioUnitarioReal INTEGER,  
	 CantidadTeoricaTotal NUMERIC(18, 4),  
	 CantidadTeoricaTotalPadre NUMERIC(18, 4),  
	 CantidadRealPadre NUMERIC(18, 2),  
	 CantidadTeoricaProporcionalPadre NUMERIC(18, 4)  
	)  

	CREATE TABLE #Auxiliar7   
	(  
	 IdPresupuestoObrasNodo INTEGER,  
	 Etapa VARCHAR(200),  
	 Rubro VARCHAR(50)  
	)  
	CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar10 (IdPresupuestoObrasNodo) ON [PRIMARY]  

	INSERT INTO #Auxiliar7   
	 SELECT P.IdPresupuestoObrasNodo, RTrim(LTrim(IsNull(P.Descripcion,Obras.Descripcion))), RTrim(LTrim(IsNull(R.Descripcion,'Varios')))  
	 FROM PresupuestoObrasNodos P  
	 LEFT OUTER JOIN Obras ON Obras.IdObra=P.IdObra  
	 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro  
	 LEFT OUTER JOIN #Auxiliar10 a ON a.IdPresupuestoObrasNodo=P.IdPresupuestoObrasNodo  
	 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and   
			(@ConHijos='*' or (@ConHijos='NO' and a.Hijos='SI') or (@ConHijos='SI' and a.Hijos='NO')) and   
			(@IdPresupuestoObraRubro1=-1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro1 or P.IdPresupuestoObraRubro=@IdPresupuestoObraRubro2)  
	-- (GasOil) and P.IdPresupuestoObrasNodo in(2278,2288,2298,2308,2318,2330,2347,2361,2367,2378,2392,2405,2419,2434,2449,2457,2467,2494,2511,2531,2544,2552,2564,2576,2583,2593,2603,2611,2619,2626,2633,2641,2650,2658)  
	--and P.IdPresupuestoObrasNodo in(2279,2289,2299,2309,2319,2331,2348,2362,2368,2379,2393,2406,2420,2435,2450,2458,2468,2495,2512,2532,2545,2553,2565,2577,2584,2594,2604,2612,2620,2627,2634,2642,2651,2659,2679)  
	--and P.IdPresupuestoObrasNodo in(2267,2606)  

	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo, Etapa, Rubro FROM #Auxiliar7 ORDER BY IdPresupuestoObrasNodo  
	OPEN Cur  
	FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Etapa, @Rubro  
	WHILE @@FETCH_STATUS = 0  
	  BEGIN  
		TRUNCATE TABLE #Auxiliar8  
		INSERT INTO #Auxiliar8   
		 EXECUTE @proc_name @IdPresupuestoObrasNodo, @CodigoPresupuesto  

		UPDATE #Auxiliar8  
		SET CantidadReal=1  
		WHERE IsNull(CantidadReal,0)=0 and IsNull(ImporteReal,0)<>0  

		SET @IdNodoPadre=IsNull((Select IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)  
		SET @CantidadTeoricaTotal=IsNull((Select Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)  
		SET @ImporteTeoricaTotal=IsNull((Select Importe*Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)  
		SET @CantidadTeoricaTotalPadre=IsNull((Select Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdNodoPadre and CodigoPresupuesto=@CodigoPresupuesto),0)  
		SET @ImporteTeoricaTotalPadre=IsNull((Select Importe*Cantidad From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdNodoPadre and CodigoPresupuesto=@CodigoPresupuesto),0)  

		INSERT INTO #Auxiliar91  
		 SELECT @IdPresupuestoObrasNodo, @Etapa, @Rubro, Año, Mes, Cantidad, Importe*Cantidad, CantidadReal, ImporteReal, CantidadTeorica, Certificado,   
				CantidadRealPadre, @CantidadTeoricaTotal, @CantidadTeoricaTotalPadre,   
				Case When @CantidadTeoricaTotalPadre<>0 Then (CantidadRealPadre/@CantidadTeoricaTotalPadre)*@CantidadTeoricaTotal Else 0 End,   
				Importe, --Case When CantidadTeorica<>0 Then Importe/CantidadTeorica Else 0 End **** Ahora el Importe es el precio unitario  
				Case When CantidadReal<>0 Then ImporteReal/CantidadReal Else 0 End,   
				0, 0, @ImporteTeoricaTotal  
		 FROM #Auxiliar8  

		FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Etapa, @Rubro  
	  END  
	CLOSE Cur  
	DEALLOCATE Cur  

	UPDATE #Auxiliar91  
	SET ConPrecioUnitarioTeorico=1  
	WHERE IsNull(PrecioUnitarioTeorico,0)<>0  

	UPDATE #Auxiliar91  
	SET ConPrecioUnitarioReal=1  
	WHERE IsNull(PrecioUnitarioReal,0)<>0  

	INSERT INTO #Auxiliar92  
	 SELECT Etapa, Rubro, Año, Mes, Sum(IsNull(CantidadTeorica,0)), 0, Sum(IsNull(Importe,0)), Sum(IsNull(CantidadReal,0)), 0, Sum(IsNull(ImporteReal,0)),   
			Sum(IsNull(PrecioUnitarioTeorico,0)), Sum(IsNull(PrecioUnitarioReal,0)), Sum(IsNull(ConPrecioUnitarioTeorico,0)), Sum(IsNull(ConPrecioUnitarioReal,0)),   
			Sum(Case When IsNull(CantidadRealPadre,0)<>0 Then IsNull(CantidadTeoricaTotal,0) Else 0 End),   
			Sum(Case When IsNull(CantidadRealPadre,0)<>0 Then IsNull(CantidadTeoricaTotalPadre,0) Else 0 End), Sum(IsNull(CantidadRealPadre,0)), Sum(IsNull(CantidadProporcionalConPadre,0))  
	 FROM #Auxiliar91  
	 GROUP BY Etapa, Rubro, Año, Mes  

	/*  
	UPDATE #Auxiliar92  
	SET PrecioUnitarioTeorico=Case When IsNull(SumaConPrecioUnitarioTeorico,0)<>0 Then SumaPrecioUnitarioTeorico/SumaConPrecioUnitarioTeorico Else 0 End,   
	PrecioUnitarioReal=Case When IsNull(SumaConPrecioUnitarioReal,0)<>0 Then SumaPrecioUnitarioReal/SumaConPrecioUnitarioReal Else 0 End  
	*/  

	UPDATE #Auxiliar92  
	SET PrecioUnitarioTeorico = 
		Case When IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)<>0   
		  Then IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)*IsNull(a91.PrecioUnitarioTeorico,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0) /   
			IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)  
		  Else IsNull((Select Top 1 IsNull(a91.PrecioUnitarioTeorico,0) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes and IsNull(a91.PrecioUnitarioTeorico,0)<>0),0)  
		End  

	UPDATE #Auxiliar92  
	SET PrecioUnitarioReal=Case When IsNull(CantidadReal,0)<>0 Then ImporteReal/CantidadReal Else 0 End  
  
	 SET NOCOUNT OFF  
	  
	 IF @Resumen='SoloHijosPorRubroConCostos'  
		SELECT #Auxiliar91.* --, pon.Item  
		FROM #Auxiliar91   
		--left outer join PresupuestoObrasNodos pon on pon.IdPresupuestoObrasNodo=#Auxiliar91.IdPresupuestoObrasNodo  
		--Where año=2013 --and mes=10    
		ORDER BY #Auxiliar91.Rubro, #Auxiliar91.Etapa, #Auxiliar91.IdPresupuestoObrasNodo, #Auxiliar91.Año, #Auxiliar91.Mes  
	  
	 IF @Resumen='SoloHijosPorRubroConCostosRs'  
		SELECT *   
		FROM #Auxiliar92  
		--Where año=2013 --and mes=10   
		ORDER BY Rubro, Etapa, Año, Mes  
	  
	 IF @Resumen='SoloHijosPorRubroConCostosRs2'  
		SELECT Rubro, Año, Mes, Sum(IsNull(CantidadReal,0)) as [CantidadReal], Sum(IsNull(ImporteReal,0)) as [ImporteReal]  
		FROM #Auxiliar92  
		GROUP BY Rubro, Año, Mes  
		ORDER BY Rubro, Año, Mes  
	  
	 IF @Resumen='SoloHijosPorRubroConCostosRs3'  
		SELECT Rubro, Etapa, Año, Mes, Max(PrecioUnitarioTeorico) as [PrecioUnitario], dbo.PresupuestoObrasNodos_Items(Etapa,@IdObra)as [Items]  
		FROM #Auxiliar92  
		GROUP BY Rubro, Etapa, Año, Mes  
		ORDER BY Rubro, Etapa, Año, Mes  
  
	 DROP TABLE #Auxiliar7  
	 DROP TABLE #Auxiliar8  
	 DROP TABLE #Auxiliar91  
	 DROP TABLE #Auxiliar92  
  END  
  
DROP TABLE #Auxiliar10