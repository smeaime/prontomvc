CREATE Procedure [dbo].[PresupuestoObrasNodos_RegistrarCargaResumida]

@IdentificadorSesion int,
@IdObra int,
@CodigoPresupuestoReal int = Null

AS

SET NOCOUNT ON

SET @CodigoPresupuestoReal=IsNull(@CodigoPresupuestoReal,0)

DECLARE @Id_TempPresupuestoObrasNodosPxQxPresupuesto INTEGER, @IdPresupuestoObrasNodosPxQxPresupuesto INTEGER, @IdPresupuestoObrasNodo INTEGER, @CodigoPresupuesto INTEGER, 
		@Importe NUMERIC(18, 4), @Cantidad NUMERIC(18, 8), @ImporteDesnormalizado NUMERIC(18, 2), @Mes INTEGER, @Año INTEGER, @ImporteAvance NUMERIC(18, 4), 
		@CantidadAvance NUMERIC(18, 8), @CantidadTeorica NUMERIC(18, 8), @Certificado NUMERIC(18, 4), @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia INTEGER, 
		@IdPresupuestoObrasNodosPxQxPresupuestoPorDia INTEGER, @Dia INTEGER, @TotalCantidadTeorica NUMERIC(18,4), @IdPresupuestoObrasNodosPxQxPresupuesto2 INTEGER

CREATE TABLE #Auxiliar1 
			(
			 Id_TempPresupuestoObrasNodosPxQxPresupuesto INTEGER,
			 IdPresupuestoObrasNodosPxQxPresupuesto INTEGER,
			 IdPresupuestoObrasNodo INTEGER,
			 CodigoPresupuesto INTEGER,
			 Importe NUMERIC(18, 4),
			 Cantidad NUMERIC(18, 8),
			 ImporteDesnormalizado NUMERIC(18, 2),
			 Mes INTEGER,
			 Año INTEGER,
			 ImporteAvance NUMERIC(18, 4),
			 CantidadAvance NUMERIC(18, 8),
			 CantidadTeorica NUMERIC(18, 8),
			 Certificado NUMERIC(18, 4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Id_TempPresupuestoObrasNodosPxQxPresupuesto) ON [PRIMARY]

INSERT INTO #Auxiliar1
 SELECT Id_TempPresupuestoObrasNodosPxQxPresupuesto, IdPresupuestoObrasNodosPxQxPresupuesto, IdPresupuestoObrasNodo, CodigoPresupuesto, Importe, Cantidad, 
		ImporteDesnormalizado, Mes, Año, ImporteAvance, CantidadAvance, CantidadTeorica, Certificado
 FROM _TempPresupuestoObrasNodosPxQxPresupuesto
 WHERE IdentificadorSesion=@IdentificadorSesion

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
	SELECT Id_TempPresupuestoObrasNodosPxQxPresupuesto, IdPresupuestoObrasNodosPxQxPresupuesto, IdPresupuestoObrasNodo, CodigoPresupuesto, Importe, Cantidad, 
			ImporteDesnormalizado, Mes, Año, ImporteAvance, CantidadAvance, CantidadTeorica, Certificado 
	FROM #Auxiliar1 
	ORDER BY Id_TempPresupuestoObrasNodosPxQxPresupuesto
OPEN Cur
FETCH NEXT FROM Cur INTO @Id_TempPresupuestoObrasNodosPxQxPresupuesto, @IdPresupuestoObrasNodosPxQxPresupuesto, @IdPresupuestoObrasNodo, @CodigoPresupuesto, 
						 @Importe, @Cantidad, @ImporteDesnormalizado, @Mes, @Año, @ImporteAvance, @CantidadAvance, @CantidadTeorica, @Certificado 
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @IdPresupuestoObrasNodosPxQxPresupuesto<=0
		INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
		(IdPresupuestoObrasNodo, CodigoPresupuesto, Importe, Cantidad, ImporteDesnormalizado, Mes, Año, ImporteAvance, CantidadAvance, Certificado)
		VALUES
		(@IdPresupuestoObrasNodo, 0, @Importe, @Cantidad, @ImporteDesnormalizado, @Mes, @Año, @ImporteAvance, @CantidadAvance, @Certificado)
	ELSE
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET Importe=@Importe, Cantidad=@Cantidad, ImporteDesnormalizado=@ImporteDesnormalizado, ImporteAvance=@ImporteAvance, 
			CantidadAvance=@CantidadAvance, Certificado=@Certificado
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto

	SET @IdPresupuestoObrasNodosPxQxPresupuesto2=IsNull((Select Top 1 IdPresupuestoObrasNodosPxQxPresupuesto From PresupuestoObrasNodosPxQxPresupuesto
														 Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuestoReal and Mes=@Mes and Año=@Año),0)
	IF @IdPresupuestoObrasNodosPxQxPresupuesto2<=0
		INSERT INTO PresupuestoObrasNodosPxQxPresupuesto
		(IdPresupuestoObrasNodo, CodigoPresupuesto, Mes, Año, CantidadTeorica)
		VALUES
		(@IdPresupuestoObrasNodo, @CodigoPresupuestoReal, @Mes, @Año, @CantidadTeorica)
	ELSE
		UPDATE PresupuestoObrasNodosPxQxPresupuesto
		SET CantidadTeorica=@CantidadTeorica
		WHERE IdPresupuestoObrasNodosPxQxPresupuesto=@IdPresupuestoObrasNodosPxQxPresupuesto2

	SET @TotalCantidadTeorica=IsNull((Select Sum(IsNull(CantidadTeorica,0)) From PresupuestoObrasNodosPxQxPresupuesto 
										Where IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuestoReal),0)

	UPDATE PresupuestoObrasNodosDatos
	SET Cantidad=@TotalCantidadTeorica
	WHERE IdPresupuestoObrasNodo=@IdPresupuestoObrasNodo and CodigoPresupuesto=@CodigoPresupuestoReal

	FETCH NEXT FROM Cur INTO @Id_TempPresupuestoObrasNodosPxQxPresupuesto, @IdPresupuestoObrasNodosPxQxPresupuesto, @IdPresupuestoObrasNodo, @CodigoPresupuesto, 
							 @Importe, @Cantidad, @ImporteDesnormalizado, @Mes, @Año, @ImporteAvance, @CantidadAvance, @CantidadTeorica, @Certificado 
  END
CLOSE Cur
DEALLOCATE Cur


CREATE TABLE #Auxiliar2 
			(
			 Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia INTEGER,
			 IdPresupuestoObrasNodosPxQxPresupuestoPorDia INTEGER,
			 IdPresupuestoObrasNodo INTEGER,
			 CodigoPresupuesto INTEGER,
			 Dia INTEGER,
			 Mes INTEGER,
			 Año INTEGER,
			 CantidadAvance NUMERIC(18, 8)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia) ON [PRIMARY]

INSERT INTO #Auxiliar2
 SELECT Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia, IdPresupuestoObrasNodosPxQxPresupuestoPorDia, IdPresupuestoObrasNodo, CodigoPresupuesto, Dia, Mes, Año, CantidadAvance
 FROM _TempPresupuestoObrasNodosPxQxPresupuestoPorDia
 WHERE IdentificadorSesion=@IdentificadorSesion

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
	SELECT Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia, IdPresupuestoObrasNodosPxQxPresupuestoPorDia, IdPresupuestoObrasNodo, CodigoPresupuesto, Dia, Mes, Año, CantidadAvance
	FROM #Auxiliar2 
	ORDER BY Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia
OPEN Cur
FETCH NEXT FROM Cur INTO @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia, @IdPresupuestoObrasNodosPxQxPresupuestoPorDia, @IdPresupuestoObrasNodo, @CodigoPresupuesto, @Dia, @Mes, @Año, @CantidadAvance
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @IdPresupuestoObrasNodosPxQxPresupuestoPorDia<=0
		INSERT INTO PresupuestoObrasNodosPxQxPresupuestoPorDia
		(IdPresupuestoObrasNodo, CodigoPresupuesto, Dia, Mes, Año, CantidadAvance)
		VALUES
		(@IdPresupuestoObrasNodo, 0, @Dia, @Mes, @Año, @CantidadAvance)
	ELSE
		UPDATE PresupuestoObrasNodosPxQxPresupuestoPorDia
		SET CantidadAvance=@CantidadAvance
		WHERE IdPresupuestoObrasNodosPxQxPresupuestoPorDia=@IdPresupuestoObrasNodosPxQxPresupuestoPorDia

	FETCH NEXT FROM Cur INTO @Id_TempPresupuestoObrasNodosPxQxPresupuestoPorDia, @IdPresupuestoObrasNodosPxQxPresupuestoPorDia, @IdPresupuestoObrasNodo, @CodigoPresupuesto, @Dia, @Mes, @Año, @CantidadAvance
  END
CLOSE Cur
DEALLOCATE Cur


DELETE _TempPresupuestoObrasNodosPxQxPresupuesto WHERE IdentificadorSesion=@IdentificadorSesion
DELETE _TempPresupuestoObrasNodosPxQxPresupuestoPorDia WHERE IdentificadorSesion=@IdentificadorSesion

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2

EXEC PresupuestoObrasNodos_RecalcularPorObra @IdObra

SET NOCOUNT OFF