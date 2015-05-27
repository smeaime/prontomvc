CREATE Procedure [dbo].[PresupuestoObrasNodos_ActualizarCostosPorEtapa]

@Etapa varchar(200),
@Mes int,
@Año int,
@Importe numeric(18,4),
@IdObra int, 
@CodigoPresupuesto int = Null

AS

SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)

SET NOCOUNT ON

DECLARE @IdPresupuestoObrasNodo int, @IdPresupuestoObrasNodosPxQxPresupuesto int

CREATE TABLE #Auxiliar1 (IdPresupuestoObrasNodo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPresupuestoObrasNodo) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdPresupuestoObrasNodo
 FROM PresupuestoObrasNodos
 WHERE IdObra=@IdObra and Upper(Descripcion)=Upper(@Etapa)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo FROM #Auxiliar1 ORDER BY IdPresupuestoObrasNodo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @IdPresupuestoObrasNodosPxQxPresupuesto=IsNull((Select IdPresupuestoObrasNodosPxQxPresupuesto From PresupuestoObrasNodosPxQxPresupuesto 
														Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto and Año=@Año and Mes=@Mes),0)
	IF @IdPresupuestoObrasNodosPxQxPresupuesto=0
		INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
		(IdPresupuestoObrasNodo, Mes, Año, Importe, CodigoPresupuesto)
		VALUES
		(@IdPresupuestoObrasNodo, @Mes, @Año, @Importe, @CodigoPresupuesto)
	ELSE 
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET Importe=@Importe
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto
	
	FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo
  END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1

SET NOCOUNT OFF
