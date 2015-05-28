CREATE Procedure [dbo].[PresupuestoObrasNodos_EliminarPresupuestoPorIdObraCodigoPresupuesto]

@IdObra int,
@CodigoPresupuesto int

AS

SET NOCOUNT ON

DECLARE @IdPresupuestoObrasNodo int, @CantidadRegistros int, @Ok varchar(2)

CREATE TABLE #Auxiliar99 (IdPresupuestoObrasNodo INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar99 ON #Auxiliar99 (IdPresupuestoObrasNodo) ON [PRIMARY]

INSERT INTO #Auxiliar99 
 SELECT IdPresupuestoObrasNodo
 FROM PresupuestoObrasNodos 
 WHERE IdObra=@IdObra

SET @Ok='SI'

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoObrasNodo FROM #Auxiliar99 ORDER BY IdPresupuestoObrasNodo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @CantidadRegistros=IsNull((Select Count(*) From PresupuestoObrasNodosConsumos ponc Where ponc.IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and (IsNull(ponc.Importe,0)<>0 or IsNull(ponc.Cantidad,0)<>0)),0)
--	IF @CantidadRegistros=0
	  BEGIN
		DELETE PresupuestoObrasNodosConsumos WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo
		DELETE PresupuestoObrasNodosPxQxPresupuesto WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
		DELETE PresupuestoObrasNodosPxQxPresupuestoPorDia WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
		DELETE PresupuestoObrasNodosDatos WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuesto
		DELETE PresupuestoObrasNodos WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo
	  END
/*
	ELSE
	  BEGIN
		SET @Ok='NO'
	  END
*/
	FETCH NEXT FROM Cur INTO @IdPresupuestoObrasNodo
  END
CLOSE Cur
DEALLOCATE Cur

IF @Ok='SI'
	DELETE PresupuestoObrasNodosPresupuestos WHERE IdObra=@IdObra and NumeroPresupuesto=@CodigoPresupuesto

SET NOCOUNT OFF

SELECT @Ok as [Ok]

DROP TABLE #Auxiliar99