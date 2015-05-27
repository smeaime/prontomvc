CREATE Procedure [dbo].[PresupuestoObrasNodos_Recalcular]

@IdPresupuestoObrasNodo int,
@CodigoPresupuesto int,
@ProcesarAuxiliares int = Null

AS

SET NOCOUNT ON

SET @ProcesarAuxiliares=IsNull(@ProcesarAuxiliares,1)

DECLARE @Lineage varchar(255), @L varchar(255), @NumeroItem int, @Nodo int, @ImporteCalculo numeric(18,2), @IdNodoPadre int, @IdPresupuestoObrasNodoMayorDepth int, 
		@UnidadAvance varchar(1), @PrecioUnitario numeric(18,8), @Cantidad numeric(18,8), @CantidadPadre numeric(18,8), @Incidencia numeric(18,8), @Hijos int, 
		@CantidadTeorica numeric(18,8), @Importe numeric(18,4)

-- PROCESAR TODOS LOS TEORICOS ASIGNADOS A AUXILIARES.
IF @ProcesarAuxiliares=1
	EXEC PresupuestoObrasNodos_RecalcularAuxiliares @CodigoPresupuesto

-- RECALCULO DE LOS ITEMS DEL PRESUPUESTO DE LA OBRA
SET @IdPresupuestoObrasNodoMayorDepth=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos
												Where Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodo)+'/%',Lineage)>0 
												Order By Depth Desc),@IdPresupuestoObrasNodo)
SET @Lineage=IsNull((Select Top 1 Lineage From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodoMayorDepth),'')

CREATE TABLE #Auxiliar1 (Nodo INTEGER, NumeroItem INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Nodo) ON [PRIMARY]

CREATE TABLE #Auxiliar2 (Año INTEGER, Mes INTEGER, Importe NUMERIC(18,4))

SET @IdNodoPadre=IsNull((Select Top 1 IdNodoPadre From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),0)
SET @Cantidad=IsNull((Select Top 1 IsNull(Cantidad,0) From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)
SET @CantidadPadre=IsNull((Select Top 1 IsNull(Cantidad,0) From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdNodoPadre and CodigoPresupuesto=@CodigoPresupuesto),0)
SET @PrecioUnitario=IsNull((Select Top 1 IsNull(Importe,0) From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)
SET @Incidencia=IsNull((Select Top 1 Incidencia From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto),0)
SET @UnidadAvance=IsNull((Select Top 1 UnidadAvance From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo),'')
SET @Hijos=IsNull((Select Count(*) From PresupuestoObrasNodos Where IdNodoPadre=@IdPresupuestoObrasNodo),0)

IF @Hijos=0
  BEGIN
	-- Las cantidades teoricas por mes de un nodo que no tiene hijos surgen del porcentaje del mes por la cantidad del nodo padre por la incidencia del hijo.
	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET CantidadTeorica=Case When @UnidadAvance='%' Then Cantidad/100*@CantidadPadre*@Incidencia Else Cantidad End 
	WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and @CodigoPresupuesto=CodigoPresupuesto

	-- La cantidad total de un hijo esta dado por la suma de las cantidades teoricas de cada mes.
	SET @CantidadTeorica=IsNull((Select Sum(IsNull(CantidadTeorica,0)) From PresupuestoObrasNodosPxQxPresupuesto 
									Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and @CodigoPresupuesto=CodigoPresupuesto),0)

	UPDATE PresupuestoObrasNodosDatos
	SET Cantidad=@CantidadTeorica
	WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and @CodigoPresupuesto=CodigoPresupuesto
  END
ELSE
  BEGIN
	-- Si el nodo es padre, la cantidad teorica por mes es igual a la cantidad total por el porcentaje del mes.
	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET CantidadTeorica=Case When @UnidadAvance='%' Then @Cantidad*Cantidad/100 Else Cantidad End 
	WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and @CodigoPresupuesto=CodigoPresupuesto
  END

-- Armo una tabla auxiliar con todos los padres del nodo que estoy modificando (sin incluirlo).
SET @NumeroItem=0
WHILE Len(@Lineage)>1
  BEGIN
	SET @Lineage=Substring(@Lineage,2,Len(@Lineage)-1)
	SET @L=Substring(@Lineage,1,Patindex('%/%', @Lineage)-1)
	SET @Lineage=Substring(@Lineage,Patindex('%/%', @Lineage),Len(@Lineage))
	SET @NumeroItem=@NumeroItem+1
	INSERT INTO #Auxiliar1 (Nodo, NumeroItem) VALUES (Convert(int,@L), @NumeroItem)
  END

-- Recorro los nodos padres en orden desde el inmediato superior hasta el nodo principal.
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Nodo FROM #Auxiliar1 ORDER BY NumeroItem Desc, Nodo
OPEN Cur
FETCH NEXT FROM Cur INTO @Nodo
WHILE @@FETCH_STATUS = 0
  BEGIN
	-- Sumo los costos de los nodos hijos (cada costo es igual a precio por inicidencia) esta sumatoria de costos hijos es el precio unitario del padre.
	SET @PrecioUnitario=IsNull((Select Sum(IsNull(pond.Costo,0)) From PresupuestoObrasNodos pon 
								Left Outer Join PresupuestoObrasNodosDatos pond On pond.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
								Where pon.IdNodoPadre=@Nodo),0)

	-- Si la suma de los costos es cero es porque los hijos del nodo actual son a su vez padres, en ese case el precio unitario del padre de padres es la suna de los importes totales.
	IF @PrecioUnitario=0
		SET @PrecioUnitario=IsNull((Select Sum(IsNull(pond.Cantidad,0)*IsNull(pond.Importe,0)) From PresupuestoObrasNodos pon 
									Left Outer Join PresupuestoObrasNodosDatos pond On pond.IdPresupuestoObrasNodo=pon.IdPresupuestoObrasNodo and pond.CodigoPresupuesto=@CodigoPresupuesto
									Where pon.IdNodoPadre=@Nodo),0)
	
	SET @Cantidad=IsNull((Select Top 1 IsNull(Cantidad,0) From PresupuestoObrasNodosDatos Where IdPresupuestoObrasNodo=@Nodo and CodigoPresupuesto=@CodigoPresupuesto),0)
	SET @UnidadAvance=IsNull((Select Top 1 UnidadAvance From PresupuestoObrasNodos Where IdPresupuestoObrasNodo=@Nodo),'')

	-- Grabo el precio unitario del padre, campo Importe.
	UPDATE PresupuestoObrasNodosDatos
	SET Importe=@PrecioUnitario
	WHERE IdPresupuestoObrasNodo=@Nodo and CodigoPresupuesto=@CodigoPresupuesto

	-- Las cantidades teoricas por mes surge de distribuir la cantidad total por los respectivos porcentajes si la unidad de avance es porcentual.
	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET CantidadTeorica=Case When @UnidadAvance='%' Then @Cantidad*Cantidad/100 Else Cantidad End 
	WHERE IdPresupuestoObrasNodo=@Nodo and @CodigoPresupuesto=CodigoPresupuesto

	-- Los precios unitarios teoricos por mes de los padres surgen de sumar los importes totales de los hijos dividido la cantidad teorica del mes del padre
	TRUNCATE TABLE #Auxiliar2
	INSERT INTO #Auxiliar2
	 SELECT ponp.Año, ponp.Mes, Sum(ponp.CantidadTeorica*ponp.Importe)
	 FROM PresupuestoObrasNodosPxQxPresupuesto ponp
	 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=ponp.IdPresupuestoObrasNodo
	 WHERE pon.IdNodoPadre=@Nodo and ponp.CodigoPresupuesto=@CodigoPresupuesto
	 GROUP BY ponp.Año, ponp.Mes
--select @Nodo,* from #Auxiliar2 order by Año,mes

	UPDATE PresupuestoObrasNodosPxQxPresupuesto
	SET Importe=Case When CantidadTeorica<>0 Then IsNull((Select a2.Importe From #Auxiliar2 a2 Where a2.Año=PresupuestoObrasNodosPxQxPresupuesto.Año And a2.Mes=PresupuestoObrasNodosPxQxPresupuesto.Mes),0) / CantidadTeorica Else 0 End
	WHERE IdPresupuestoObrasNodo=@Nodo and @CodigoPresupuesto=CodigoPresupuesto

	FETCH NEXT FROM Cur INTO @Nodo
  END
CLOSE Cur
DEALLOCATE Cur

/*
-- En cualquier caso el importe teorico de cada mes es igual a la cantidad teorica del mes por el precio unitario.
UPDATE PresupuestoObrasNodosPxQxPresupuesto
SET Importe=CantidadTeorica*@PrecioUnitario
WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and @CodigoPresupuesto=CodigoPresupuesto
*/

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

SET NOCOUNT OFF
