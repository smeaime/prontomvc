CREATE Procedure [dbo].[PresupuestoObrasNodos_CrearPresupuesto]

@IdObra int, 
@CodigoPresupuestoNuevo int, 
@CodigoPresupuestoOrigen int = Null,
@Fecha datetime, 
@Detalle varchar(200)

AS 

SET NOCOUNT ON

INSERT INTO PresupuestoObrasNodosPresupuestos
(IdObra, NumeroPresupuesto, Fecha, Detalle)
VALUES
(@IdObra, @CodigoPresupuestoNuevo, @Fecha, @Detalle)

DECLARE @IdPresupuestoObrasNodo int

SET @CodigoPresupuestoOrigen=IsNull(@CodigoPresupuestoOrigen,-1)

IF @CodigoPresupuestoOrigen=-1
    BEGIN
	SET @IdPresupuestoObrasNodo=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where IdObra=@IdObra),0)
	INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
	(IdPresupuestoObrasNodo, CodigoPresupuesto, Importe, Cantidad, Mes, Año)
	VALUES
	(@IdPresupuestoObrasNodo, @CodigoPresupuestoNuevo, 0, 0, Month(@Fecha), Year(@Fecha))
    END
ELSE
    BEGIN
	CREATE TABLE #Auxiliar1 
				(
				 IdPresupuestoObrasNodo INTEGER,
				 CodigoPresupuesto INTEGER,
				 Importe NUMERIC(18,2),
				 Cantidad NUMERIC(18,2),
				 Mes INTEGER,
				 Año INTEGER
				)
	INSERT INTO #Auxiliar1 
	 SELECT pxq.IdPresupuestoObrasNodo, pxq.CodigoPresupuesto, pxq.Importe, pxq.Cantidad, pxq.Mes, pxq.Año
	 FROM PresupuestoObrasNodosPxQxPresupuesto pxq
	 LEFT OUTER JOIN PresupuestoObrasNodos pon ON pon.IdPresupuestoObrasNodo=pxq.IdPresupuestoObrasNodo
	 WHERE pxq.CodigoPresupuesto=@CodigoPresupuestoOrigen and pon.IdObra=@IdObra

	UPDATE #Auxiliar1
	SET CodigoPresupuesto=@CodigoPresupuestoNuevo

	SET @IdPresupuestoObrasNodo=IsNull((Select Top 1 IdPresupuestoObrasNodo From PresupuestoObrasNodos Where IdObra=@IdObra),0)
	INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
	(IdPresupuestoObrasNodo, CodigoPresupuesto, Importe, Cantidad, Mes, Año)
	SELECT *
	FROM #Auxiliar1
	DROP TABLE #Auxiliar1
    END

SET NOCOUNT OFF