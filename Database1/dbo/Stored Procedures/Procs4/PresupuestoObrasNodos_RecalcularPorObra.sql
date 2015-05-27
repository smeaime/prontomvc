CREATE Procedure [dbo].[PresupuestoObrasNodos_RecalcularPorObra]

@IdObra int = Null,
@IdPresupuestoObrasNodoPadre int = Null,
@CodigoPresupuesto int = Null

AS

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)
SET @IdPresupuestoObrasNodoPadre=IsNull(@IdPresupuestoObrasNodoPadre,-1)
SET @CodigoPresupuesto=IsNull(@CodigoPresupuesto,0)

DECLARE @IdPresupuestoObrasNodo int, @Depth int, @Item varchar(20)

EXEC PresupuestoObrasNodos_RecalcularAuxiliares @CodigoPresupuesto

CREATE TABLE #Auxiliar99 (IdPresupuestoObrasNodo INTEGER, Depth INTEGER, Item VARCHAR(20))
CREATE NONCLUSTERED INDEX IX__Auxiliar99 ON #Auxiliar99 (IdPresupuestoObrasNodo) ON [PRIMARY]

INSERT INTO #Auxiliar99 
 SELECT IdPresupuestoObrasNodo, Depth, Item
 FROM PresupuestoObrasNodos 
 WHERE (@IdObra=-1 or IdObra=@IdObra) and 
	(@IdPresupuestoObrasNodoPadre=-1 or Patindex('%/'+Convert(varchar,@IdPresupuestoObrasNodoPadre)+'/%',Lineage)>0)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo, Depth, Item FROM #Auxiliar99 ORDER BY Depth Desc, IdPresupuestoObrasNodo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Depth, @Item
WHILE @@FETCH_STATUS = 0
   BEGIN
	--PRINT 'IdPresupuestoObrasNodo : '+Convert(varchar,@IdPresupuestoObrasNodo)+' Depth : '+Convert(varchar,@Depth)+' Item : '+@Item
	EXEC PresupuestoObrasNodos_Recalcular @IdPresupuestoObrasNodo, @CodigoPresupuesto, 0
	FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo, @Depth, @Item
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar99

SET NOCOUNT OFF