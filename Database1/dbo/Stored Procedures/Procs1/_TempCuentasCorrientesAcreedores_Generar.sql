
CREATE Procedure [dbo].[_TempCuentasCorrientesAcreedores_Generar]

@FechaHasta datetime

AS

SET NOCOUNT ON

DECLARE @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, 
	@IdProveedor1 int, @IdProveedor2 int, @IdProveedorAnt int, @Saldo1 numeric(18,2), 
	@Saldo2 numeric(18,2), @ImporteTotal1 numeric(18,2), @ImporteTotal2 numeric(18,2), 
	@Fecha datetime, @SaldoAAplicar numeric(18,2), @SaldoAplicado numeric(18,2), 
	@Diferencia numeric(18,2), @IdAux int

/*   CALCULAR SALDOS DE CUENTA CORRIENTE A LA FECHA INDICADA CON APERTURA POR CONDICIONES DE COMPRA   */
CREATE TABLE #Auxiliar1 
			(
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 Fecha DATETIME,
			 IdTipoComp INTEGER,
			 IdComprobante INTEGER,
			 NumeroComprobante INTEGER,
			 IdImputacion INTEGER,
			 ImporteTotal NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdImputacion, Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante,
  CtaCte.NumeroComprobante,
  IsNull(CtaCte.IdImputacion,0),
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 WHERE TiposComprobante.Coeficiente=1 and CtaCte.Fecha<=@FechaHasta 

CREATE TABLE #Auxiliar2 
			(
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 Fecha DATETIME,
			 IdTipoComp INTEGER,
			 IdComprobante INTEGER,
			 NumeroComprobante INTEGER,
			 IdImputacion INTEGER,
			 ImporteTotal NUMERIC(18, 2),
			 Saldo NUMERIC(18, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdImputacion, Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  CtaCte.IdTipoComp,
  CtaCte.IdComprobante,
  CtaCte.NumeroComprobante,
  IsNull(CtaCte.IdImputacion,0),
  CtaCte.ImporteTotal,
  CtaCte.ImporteTotal
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 WHERE TiposComprobante.Coeficiente=-1 and CtaCte.Fecha<=@FechaHasta 

/*  CURSORES  */
DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdCtaCte, IdProveedor, IdImputacion, ImporteTotal, Saldo
		FROM #Auxiliar2
		WHERE Saldo<>0 and IdImputacion<>0
		ORDER BY IdImputacion, Fecha 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteTotal1, @Saldo1
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoAAplicar=@Saldo1
	SET @IdImputacionAnt=@IdImputacion1
	SET @IdProveedorAnt=@IdProveedor1

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY 
		FOR
			SELECT IdCtaCte, IdProveedor, IdImputacion, ImporteTotal, Saldo
			FROM #Auxiliar1
			WHERE Saldo<>0 and IdImputacion=@IdImputacionAnt and IdProveedor=@IdProveedorAnt
			ORDER BY IdImputacion, Fecha 
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteTotal2, @Saldo2
	WHILE @@FETCH_STATUS = 0 and not @SaldoAAplicar=0
	   BEGIN
		IF @SaldoAAplicar>=@Saldo2
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@Saldo2
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@Saldo2-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		UPDATE #Auxiliar1
		SET Saldo = @SaldoAplicado
		WHERE CURRENT OF CtaCte2

		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @ImporteTotal2, @Saldo2
	   END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	BEGIN
		UPDATE #Auxiliar2
		SET Saldo = @SaldoAAplicar
		WHERE CURRENT OF CtaCte1
	END
	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @ImporteTotal1, @Saldo1
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

UPDATE #Auxiliar1
SET ImporteTotal = ImporteTotal * -1, Saldo = Saldo * -1

INSERT INTO #Auxiliar1 
 SELECT * FROM #Auxiliar2

TRUNCATE TABLE _TempCuentasCorrientesAcreedores
INSERT INTO _TempCuentasCorrientesAcreedores 
 SELECT * FROM #Auxiliar1

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
