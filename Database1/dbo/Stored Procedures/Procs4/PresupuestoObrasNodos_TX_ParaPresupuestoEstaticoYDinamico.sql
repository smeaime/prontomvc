CREATE Procedure [dbo].[PresupuestoObrasNodos_TX_ParaPresupuestoEstaticoYDinamico]

@IdObra int,
@CodigoPresupuesto int, 
@Datos varchar(10)

AS 

SET NOCOUNT ON

DECLARE @IdPresupuestoObrasNodo int, @Año int, @Mes int, @IdPresupuestoObrasNodo1 int, @IdPresupuestoObrasNodosPxQxPresupuesto int, 
		@IdPresupuestoObraRubro1 int, @IdPresupuestoObraRubro2 int, @proc_name varchar(1000), @Etapa varchar(200), @Rubro varchar(50), @IdNodoPadre int, 
		@CantidadTeoricaTotal numeric(18,2), @CantidadTeoricaTotalPadre numeric(18,2), @ImporteTeoricaTotal numeric(18,2), @ImporteTeoricaTotalPadre numeric(18,2)

/* ///////////////////////////////////////////////////// */
/*  Rutinas para que de igual al seguimiento de costos   */
/* ///////////////////////////////////////////////////// */

CREATE TABLE #Auxiliar10 (IdPresupuestoObrasNodo INTEGER, Hijos VARCHAR(2))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar10 (IdPresupuestoObrasNodo) ON [PRIMARY]
INSERT INTO #Auxiliar10 
 SELECT pon.IdPresupuestoObrasNodo, 
	--Case When Exists(Select Top 1 pon1.IdPresupuestoObrasNodo From PresupuestoObrasNodos pon1 Where Patindex('%/'+Convert(varchar,pon.IdPresupuestoObrasNodo)+'/%', pon1.Lineage)>0) Then 'SI' Else 'NO' End
	Case When Exists(Select Top 1 pon1.IdNodoPadre From PresupuestoObrasNodos pon1 Where pon1.IdNodoPadre=pon.IdPresupuestoObrasNodo) Then 'SI' Else 'NO' End
 FROM PresupuestoObrasNodos pon
 LEFT OUTER JOIN Obras O ON O.IdObra = pon.IdObra
 WHERE (@IdObra=-1 or pon.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and pon.IdNodoPadre is not null

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
			 Cantidad NUMERIC(18, 3),
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
			 PrecioUnitarioTeoricoTotal NUMERIC(18, 2),
			 ImporteParaEstatico NUMERIC(18, 2)
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
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(Obras.IdObraRelacionada,0)=@IdObra) and P.IdNodoPadre is not null and a.Hijos='NO'

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
	 SELECT @IdPresupuestoObrasNodo, @Etapa, @Rubro, a8.Año, a8.Mes, a8.Cantidad, a8.Importe*a8.CantidadTeorica, a8.CantidadReal, a8.ImporteReal, 
			a8.CantidadTeorica, a8.Certificado, a8.CantidadRealPadre, @CantidadTeoricaTotal, @CantidadTeoricaTotalPadre, 
			Case When @CantidadTeoricaTotalPadre<>0 Then (a8.CantidadRealPadre/@CantidadTeoricaTotalPadre)*@CantidadTeoricaTotal Else 0 End, 
			a8.Importe, --Case When CantidadTeorica<>0 Then Importe/CantidadTeorica Else 0 End **** Ahora el Importe es el precio unitario
			Case When a8.CantidadReal<>0 Then a8.ImporteReal/a8.CantidadReal Else 0 End, 0, 0, @ImporteTeoricaTotal, pond.Importe*a8.CantidadTeorica
	 FROM #Auxiliar8 a8
	 LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto

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

UPDATE #Auxiliar92
SET PrecioUnitarioTeorico =	Case When IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)<>0 
									Then IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)*IsNull(a91.PrecioUnitarioTeorico,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0) / 
										 IsNull((Select Sum(IsNull(a91.CantidadTeorica,0)) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes),0)
									Else IsNull((Select Top 1 IsNull(a91.PrecioUnitarioTeorico,0) From #Auxiliar91 a91 Where a91.Etapa=#Auxiliar92.Etapa and a91.Rubro=#Auxiliar92.Rubro and a91.Año=#Auxiliar92.Año and a91.Mes=#Auxiliar92.Mes and IsNull(a91.PrecioUnitarioTeorico,0)<>0),0)
							End

UPDATE #Auxiliar92
SET PrecioUnitarioReal=Case When IsNull(CantidadReal,0)<>0 Then ImporteReal/CantidadReal Else 0 End

/* ///////////////////////////////////////////////////// */

/*  Para saber si el nodo tiene hijos  */
CREATE TABLE #Auxiliar1 (IdPresupuestoObrasNodo INTEGER, Hijos VARCHAR(2))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPresupuestoObrasNodo) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT P.IdPresupuestoObrasNodo, Case When Exists(Select Top 1 P1.IdNodoPadre From PresupuestoObrasNodos P1 Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo) Then 'SI' Else 'NO' End
 FROM PresupuestoObrasNodos P
 LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) --and P.IdNodoPadre is not null

/*  Para saber la relacion entre avance real y teorico (solo de los padres)  */
CREATE TABLE #Auxiliar0 (IdPresupuestoObrasNodo INTEGER, Año INTEGER, Mes INTEGER, CantidadAvance NUMERIC(18,8), CantidadTeorica NUMERIC(18,8))
CREATE TABLE #Auxiliar2 (IdPresupuestoObrasNodo INTEGER, Año INTEGER, Mes INTEGER, CantidadAvance NUMERIC(18,8), CantidadTeorica NUMERIC(18,8))
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdPresupuestoObrasNodo, Año, Mes) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT P.IdPresupuestoObrasNodo, PxQ.Año, PxQ.Mes, 0, IsNull(PxQ.CantidadTeorica,0)
 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
 LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and PxQ.CodigoPresupuesto=@CodigoPresupuesto and --P.IdNodoPadre is not null and 
		Exists(Select Top 1 P1.IdNodoPadre From PresupuestoObrasNodos P1 
				Left Outer Join #Auxiliar1 ON #Auxiliar1.IdPresupuestoObrasNodo = P1.IdPresupuestoObrasNodo
				Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo and #Auxiliar1.Hijos<>'SI')

INSERT INTO #Auxiliar0 
 SELECT P.IdPresupuestoObrasNodo, PxQ.Año, PxQ.Mes, IsNull(PxQ.CantidadAvance,0), 0
 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
 LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
 LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and PxQ.CodigoPresupuesto=0 and --P.IdNodoPadre is not null and 
		Exists(Select Top 1 P1.IdNodoPadre From PresupuestoObrasNodos P1 
				Left Outer Join #Auxiliar1 ON #Auxiliar1.IdPresupuestoObrasNodo = P1.IdPresupuestoObrasNodo
				Where P1.IdNodoPadre=P.IdPresupuestoObrasNodo and #Auxiliar1.Hijos<>'SI')

INSERT INTO #Auxiliar2 
 SELECT IdPresupuestoObrasNodo, Año, Mes, Sum(IsNull(CantidadAvance,0)), Sum(IsNull(CantidadTeorica,0))
 FROM #Auxiliar0
 GROUP BY IdPresupuestoObrasNodo, Año, Mes


/*  Verificar que si el nodo padre tiene informacion en un mes y año dados, los hijos tengan al menos un registro en la tabla PresupuestoObrasNodosPxQxPresupuesto */
CREATE TABLE #Auxiliar3 (IdPresupuestoObrasNodo int)
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdPresupuestoObrasNodo) ON [PRIMARY]

DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo, Año, Mes FROM #Auxiliar2 ORDER BY IdPresupuestoObrasNodo, Año, Mes
OPEN Cur1
FETCH NEXT FROM Cur1 INTO @IdPresupuestoObrasNodo, @Año, @Mes
WHILE @@FETCH_STATUS = 0
  BEGIN
	TRUNCATE TABLE #Auxiliar3
	INSERT INTO #Auxiliar3 
	 SELECT P.IdPresupuestoObrasNodo
	 FROM PresupuestoObrasNodos P
	 WHERE P.IdNodoPadre=@IdPresupuestoObrasNodo

	DECLARE Cur2 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo FROM #Auxiliar3 ORDER BY IdPresupuestoObrasNodo
	OPEN Cur2
	FETCH NEXT FROM Cur2 INTO @IdPresupuestoObrasNodo1
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @IdPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuesto From PresupuestoObrasNodosPxQxPresupuesto Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo1 and CodigoPresupuesto=@CodigoPresupuesto and Año=@Año and Mes=@Mes),0)
		IF @IdPresupuestoObrasNodosPxQxPresupuesto=0
			INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
			(IdPresupuestoObrasNodo, CodigoPresupuesto, Mes, Año)
			VALUES
			(@IdPresupuestoObrasNodo1, @CodigoPresupuesto, @Mes, @Año)
		FETCH NEXT FROM Cur2 INTO @IdPresupuestoObrasNodo1
	  END
	CLOSE Cur2
	DEALLOCATE Cur2

	FETCH NEXT FROM Cur1 INTO @IdPresupuestoObrasNodo, @Año, @Mes
  END
CLOSE Cur1
DEALLOCATE Cur1

CREATE TABLE #Auxiliar4 
			(
--			 IdObra INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 Rubro VARCHAR(50),
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)

CREATE TABLE #Auxiliar5 
			(
--			 IdObra INTEGER,
			 Año INTEGER,
			 Mes INTEGER,
			 Rubro VARCHAR(50),
			 Ingresos NUMERIC(18, 2),
			 Egresos NUMERIC(18, 2)
			)

SET NOCOUNT OFF

IF @Datos='RUBROS'
	SELECT DISTINCT IsNull(R.Descripcion,'Varios') as [Rubro]
	FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
	LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
	ORDER BY [Rubro]

IF @Datos='ESTATICO'
  BEGIN
/*
	SELECT P.IdObra as [IdObra], PxQ.Año as [Año], PxQ.Mes as [Mes], IsNull(R.Descripcion,'Varios') as [Rubro], 
			Sum(IsNull(PxQ.CantidadTeorica,0)*IsNull(pond.PrecioVentaUnitario,0)) as [Ingresos], 
			Sum(IsNull(Case When IsNull(#Auxiliar1.Hijos,'')='SI' Then 0 Else PxQ.Importe End,0)) as [Egresos]
	FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
	LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
	LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
	GROUP BY P.IdObra, PxQ.Año, PxQ.Mes, IsNull(R.Descripcion,'Varios')
	ORDER BY P.IdObra, PxQ.Año, PxQ.Mes, [Rubro]
*/

	SELECT PxQ.Año as [Año], PxQ.Mes as [Mes], IsNull(R.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'Varios') as [Rubro], 
			Sum(IsNull(PxQ.CantidadTeorica,0)*IsNull(pond.PrecioVentaUnitario,0)) as [Ingresos], 
			0 as [Egresos]
	FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
	LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
	LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
	LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo
	WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto) and 
			IsNull(PxQ.CantidadTeorica,0)<>0 and IsNull(pond.PrecioVentaUnitario,0)<>0
	GROUP BY P.IdObra, PxQ.Año, PxQ.Mes, IsNull(R.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'Varios')

	UNION ALL
	
	SELECT a91.Año as [Año], a91.Mes as [Mes], a91.Rubro COLLATE SQL_Latin1_General_CP1_CI_AS as [Rubro], 
			0 as [Ingresos], 
			Sum(IsNull(a91.ImporteParaEstatico,0)) as [Egresos]
	FROM #Auxiliar91 a91 
	GROUP BY a91.Año, a91.Mes, a91.Rubro

	ORDER BY [Año], [Mes], [Rubro]
  END
  
IF @Datos='DINAMICO'
  BEGIN
	SET NOCOUNT ON
/*	
	INSERT INTO #Auxiliar4 
	 SELECT PxQ.Año, PxQ.Mes, IsNull(R.Descripcion,'Varios'), 
			0, 
			IsNull(Case When IsNull(#Auxiliar1.Hijos,'')='SI' Then 0 
						Else Case When IsNull(pond1.Cantidad,0)<>0 Then #Auxiliar2.CantidadAvance/pond1.Cantidad*pond.Cantidad*pond.Importe Else 0 End
					End,0)
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
	 LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
	 LEFT OUTER JOIN PresupuestoObrasNodosDatos pond1 ON pond1.IdPresupuestoObrasNodo = P.IdNodoPadre and pond1.CodigoPresupuesto=@CodigoPresupuesto
	 LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
	 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdPresupuestoObrasNodo = P.IdPresupuestoObrasNodo
	 LEFT OUTER JOIN #Auxiliar2 ON #Auxiliar2.IdPresupuestoObrasNodo = P.IdNodoPadre and #Auxiliar2.Año = PxQ.Año and #Auxiliar2.Mes = PxQ.Mes
	 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and (@CodigoPresupuesto=-1 or PxQ.CodigoPresupuesto=@CodigoPresupuesto)
*/

	INSERT INTO #Auxiliar4 
	 SELECT a91.Año, a91.Mes, a91.Rubro COLLATE SQL_Latin1_General_CP1_CI_AS, 
			0, 
			Sum(IsNull(a91.CantidadProporcionalConPadre,0)*IsNull(a91.PrecioUnitarioTeorico,0))
	 FROM #Auxiliar91 a91 
	 GROUP BY a91.Año, a91.Mes, a91.Rubro

	INSERT INTO #Auxiliar4 
	 SELECT PxQ.Año, PxQ.Mes, IsNull(R.Descripcion COLLATE SQL_Latin1_General_CP1_CI_AS,'Varios'), 
			IsNull(PxQ.Certificado,0)*IsNull(pond.PrecioVentaUnitario,0), 
			0
	 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
	 LEFT OUTER JOIN PresupuestoObrasNodos P ON P.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
	 LEFT OUTER JOIN PresupuestoObrasNodosDatos pond ON pond.IdPresupuestoObrasNodo=PxQ.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
	 LEFT OUTER JOIN Obras O ON O.IdObra = P.IdObra
	 LEFT OUTER JOIN Tipos R On R.IdTipo=P.IdPresupuestoObraRubro
	 WHERE (@IdObra=-1 or P.IdObra=@IdObra or IsNull(O.IdObraRelacionada,0)=@IdObra) and PxQ.CodigoPresupuesto=0

	INSERT INTO #Auxiliar5 
	 SELECT Año, Mes, Rubro, Sum(IsNull(Ingresos,0)), Sum(IsNull(Egresos,0))
	 FROM #Auxiliar4
	 GROUP BY Año, Mes, Rubro
	 ORDER BY Año, Mes, Rubro

	SET NOCOUNT OFF

	 SELECT * FROM #Auxiliar5
  END

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5

DROP TABLE #Auxiliar7
DROP TABLE #Auxiliar8
DROP TABLE #Auxiliar91
DROP TABLE #Auxiliar92
DROP TABLE #Auxiliar10