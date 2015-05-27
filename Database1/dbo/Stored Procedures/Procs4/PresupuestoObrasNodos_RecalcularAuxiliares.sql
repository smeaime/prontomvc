CREATE Procedure [dbo].[PresupuestoObrasNodos_RecalcularAuxiliares]

@CodigoPresupuesto int

AS

SET NOCOUNT ON

-- PROCESAR TODOS LOS TEORICOS ASIGNADOS A AUXILIARES.
DECLARE @IdNodoAuxiliar int, @Mes int, @Año int, @IdPresupuestoObrasNodosPxQxPresupuesto int, @Porcentaje numeric(18,8), @IdPresupuestoObrasNodo1 int, @CantidadTeorica numeric(18,8)

CREATE TABLE #Auxiliar10 (IdNodoAuxiliar INTEGER, Mes INTEGER, Año INTEGER, CantidadTeorica NUMERIC(18,8), Porcentaje NUMERIC(18,8))
CREATE NONCLUSTERED INDEX IX__Auxiliar10 ON #Auxiliar10 (IdNodoAuxiliar,Mes,Año) ON [PRIMARY]
INSERT INTO #Auxiliar10 
 SELECT pon.IdNodoAuxiliar, PxQ.Mes, PxQ.Año, Sum(IsNull(PxQ.CantidadTeorica,0)), 0
 FROM PresupuestoObrasNodosPxQxPresupuesto PxQ
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo = PxQ.IdPresupuestoObrasNodo
 WHERE IsNull(pon.IdNodoAuxiliar,0)>0 and PxQ.CodigoPresupuesto=@CodigoPresupuesto
 GROUP BY pon.IdNodoAuxiliar, PxQ.Mes, PxQ.Año

CREATE TABLE #Auxiliar11 (IdNodoAuxiliar INTEGER,CantidadTeorica NUMERIC(18,8))
CREATE NONCLUSTERED INDEX IX__Auxiliar11 ON #Auxiliar11 (IdNodoAuxiliar) ON [PRIMARY]
INSERT INTO #Auxiliar11 
 SELECT IdNodoAuxiliar, Sum(IsNull(CantidadTeorica,0))
 FROM #Auxiliar10
 GROUP BY IdNodoAuxiliar

CREATE TABLE #Auxiliar13 (IdPresupuestoObrasNodosPxQxPresupuesto INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar13 ON #Auxiliar13 (IdPresupuestoObrasNodosPxQxPresupuesto) ON [PRIMARY]

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNodoAuxiliar, CantidadTeorica FROM #Auxiliar11 ORDER BY IdNodoAuxiliar
OPEN Cur
FETCH NEXT FROM Cur INTO @IdNodoAuxiliar, @CantidadTeorica
WHILE @@FETCH_STATUS = 0
   BEGIN
	UPDATE PresupuestoObrasNodosDatos
	SET Cantidad=@CantidadTeorica
	WHERE IdPresupuestoObrasNodo=@IdNodoAuxiliar and CodigoPresupuesto=@CodigoPresupuesto

	IF @CantidadTeorica<>0
		UPDATE #Auxiliar10
		SET Porcentaje=CantidadTeorica/@CantidadTeorica*100
		WHERE IdNodoAuxiliar=@IdNodoAuxiliar

	TRUNCATE TABLE #Auxiliar13
	INSERT INTO #Auxiliar13 
	 SELECT IdPresupuestoObrasNodosPxQxPresupuesto
	 FROM PresupuestoObrasNodosPxQxPresupuesto
	 LEFT OUTER JOIN PresupuestoObrasNodos ON PresupuestoObrasNodos.IdPresupuestoObrasNodo=PresupuestoObrasNodosPxQxPresupuesto.IdPresupuestoObrasNodo
	 WHERE PresupuestoObrasNodosPxQxPresupuesto.IdPresupuestoObrasNodo=@IdNodoAuxiliar or Patindex('%/'+Convert(varchar,@IdNodoAuxiliar)+'/%',IsNull(PresupuestoObrasNodos.Lineage,''))>0
	
	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET Cantidad=Null
	WHERE IdPresupuestoObrasNodosPxQxPresupuesto In (Select IdPresupuestoObrasNodosPxQxPresupuesto From #Auxiliar13)

	FETCH NEXT FROM Cur INTO @IdNodoAuxiliar, @CantidadTeorica
   END
CLOSE Cur
DEALLOCATE Cur

CREATE TABLE #Auxiliar12 (IdNodoAuxiliar INTEGER, Mes INTEGER, Año INTEGER, Porcentaje NUMERIC(18,8), IdPresupuestoObrasNodo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar12 ON #Auxiliar12 (IdNodoAuxiliar,Mes,Año,IdPresupuestoObrasNodo) ON [PRIMARY]
INSERT INTO #Auxiliar12 
 SELECT #Auxiliar10.IdNodoAuxiliar, #Auxiliar10.Mes, #Auxiliar10.Año, #Auxiliar10.Porcentaje, pon.IdPresupuestoObrasNodo
 FROM #Auxiliar10
 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=#Auxiliar10.IdNodoAuxiliar or Patindex('%/'+Convert(varchar,#Auxiliar10.IdNodoAuxiliar)+'/%',pon.Lineage)>0
 WHERE #Auxiliar10.Porcentaje<>0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNodoAuxiliar, Mes, Año, Porcentaje, IdPresupuestoObrasNodo FROM #Auxiliar12 ORDER BY IdNodoAuxiliar, Mes, Año, IdPresupuestoObrasNodo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdNodoAuxiliar, @Mes, @Año, @Porcentaje, @IdPresupuestoObrasNodo1
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuesto From PresupuestoObrasNodosPxQxPresupuesto
								Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo1 and Mes=@Mes and Año=@Año),0)
	IF @IdPresupuestoObrasNodosPxQxPresupuesto>0
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET Cantidad=@Porcentaje
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto
	ELSE
		INSERT INTO [PresupuestoObrasNodosPxQxPresupuesto]
		(IdPresupuestoObrasNodo, Mes, Año, Cantidad, CodigoPresupuesto)
		VALUES
		(@IdPresupuestoObrasNodo1, @Mes, @Año, Case When @Porcentaje>0 Then @Porcentaje Else Null End, @CodigoPresupuesto)

	FETCH NEXT FROM Cur INTO @IdNodoAuxiliar, @Mes, @Año, @Porcentaje, @IdPresupuestoObrasNodo1
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar10
DROP TABLE #Auxiliar11
DROP TABLE #Auxiliar12
DROP TABLE #Auxiliar13

SET NOCOUNT OFF