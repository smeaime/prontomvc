CREATE Procedure [dbo].[CtasCtesA_CalcularSaldosPorTransaccion]

AS 

CREATE TABLE #Auxiliar1 
			(
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_IdImputacion INTEGER,
			 A_Importe NUMERIC(15, 2),
			 A_ImporteDolar NUMERIC(15, 2),
			 A_ImporteEuro NUMERIC(15, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (A_IdImputacion, A_Fecha) ON [PRIMARY]
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar1 (A_IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  IsNull(CtaCte.IdImputacion,0),
  IsNull(CtaCte.ImporteTotal,0),
  IsNull(CtaCte.ImporteTotalDolar,0),
  IsNull(CtaCte.ImporteTotalEuro,0)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON CtaCte.IdTipoComp=TiposComprobante.IdTipoComprobante
 WHERE TiposComprobante.Coeficiente=1 

CREATE TABLE #Auxiliar2 
			(
			 A_IdCtaCte INTEGER,
			 A_IdProveedor INTEGER,
			 A_Fecha DATETIME,
			 A_IdImputacion INTEGER,
			 A_Importe NUMERIC(15, 2),
			 A_ImporteDolar NUMERIC(15, 2),
			 A_ImporteEuro NUMERIC(15, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (A_IdImputacion, A_Fecha) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  CtaCte.Fecha,
  IsNull(CtaCte.IdImputacion,0),
  IsNull(CtaCte.ImporteTotal,0),
  IsNull(CtaCte.ImporteTotalDolar,0),
  IsNull(CtaCte.ImporteTotalEuro,0)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=CtaCte.IdTipoComp WHERE tc.Coeficiente=-1 


DECLARE @IdCtaCte1 int, @IdCtaCte2 int, @IdImputacion1 int, @IdImputacion2 int, @IdImputacionAnt int, @IdProveedor1 int, @IdProveedor2 int, @IdProveedorAnt int, 
	@Importe1 numeric(18,2), @Importe2 numeric(18,2), @ImporteDolar1 numeric(18,2), @ImporteDolar2 numeric(18,2), @ImporteEuro1 numeric(18,2), @ImporteEuro2 numeric(18,2), 
	@SaldoAAplicar numeric(18,2), @SaldoAAplicarDolar numeric(18,2), @SaldoAAplicarEuro numeric(18,2), 
	@SaldoAplicado numeric(18,2), @SaldoAplicadoDolar numeric(18,2), @SaldoAplicadoEuro numeric(18,2)

/*  CURSORES  */
DECLARE CtaCte1 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_Importe, A_ImporteDolar, A_ImporteEuro FROM #Auxiliar2 ORDER BY A_IdImputacion, A_Fecha 
OPEN CtaCte1
FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @Importe1, @ImporteDolar1, @ImporteEuro1
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @IdProveedorAnt=@IdProveedor1
	SET @IdImputacionAnt=@IdImputacion1
	SET @SaldoAAplicar=@Importe1
	SET @SaldoAAplicarDolar=@ImporteDolar1
	SET @SaldoAAplicarEuro=@ImporteEuro1

	DECLARE CtaCte2 CURSOR LOCAL FORWARD_ONLY FOR SELECT A_IdCtaCte, A_IdProveedor, A_IdImputacion, A_Importe, A_ImporteDolar, A_ImporteEuro FROM #Auxiliar1
			WHERE A_IdProveedor=@IdProveedorAnt and A_IdImputacion=@IdImputacionAnt
			ORDER BY A_IdImputacion, A_Fecha 
	OPEN CtaCte2
	FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @Importe2, @ImporteDolar2, @ImporteEuro2
	WHILE @@FETCH_STATUS = 0 
	   BEGIN
		IF @SaldoAAplicar>=@Importe2
		   BEGIN
			SET @SaldoAAplicar=@SaldoAAplicar-@Importe2
			SET @SaldoAplicado=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicado=@Importe2-@SaldoAAplicar
			SET @SaldoAAplicar=0
		   END

		IF @SaldoAAplicarDolar>=@ImporteDolar2
		   BEGIN
			SET @SaldoAAplicarDolar=@SaldoAAplicarDolar-@ImporteDolar2
			SET @SaldoAplicadoDolar=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicadoDolar=@ImporteDolar2-@SaldoAAplicarDolar
			SET @SaldoAAplicarDolar=0
		   END

		IF @SaldoAAplicarEuro>=@ImporteEuro2
		   BEGIN
			SET @SaldoAAplicarEuro=@SaldoAAplicarEuro-@ImporteEuro2
			SET @SaldoAplicadoEuro=0
		   END
		ELSE
		   BEGIN
			SET @SaldoAplicadoEuro=@ImporteEuro2-@SaldoAAplicarEuro
			SET @SaldoAAplicarEuro=0
		   END

		UPDATE #Auxiliar1
		SET A_Importe = @SaldoAplicado, A_ImporteDolar = @SaldoAplicadoDolar, A_ImporteEuro = @SaldoAplicadoEuro
		WHERE A_IdCtaCte = @IdCtaCte2

		UPDATE CuentasCorrientesAcreedores
		SET Saldo = @SaldoAplicado, SaldoDolar = @SaldoAplicadoDolar, SaldoEuro = @SaldoAplicadoEuro
		WHERE IdCtaCte = @IdCtaCte2

		FETCH NEXT FROM CtaCte2	INTO @IdCtaCte2, @IdProveedor2, @IdImputacion2, @Importe2, @ImporteDolar2, @ImporteEuro2
	   END
	CLOSE CtaCte2
	DEALLOCATE CtaCte2

	UPDATE CuentasCorrientesAcreedores
	SET Saldo = @SaldoAAplicar, SaldoDolar = @SaldoAAplicarDolar, SaldoEuro = @SaldoAAplicarEuro
	WHERE IdCtaCte = @IdCtaCte1

	FETCH NEXT FROM CtaCte1	INTO @IdCtaCte1, @IdProveedor1, @IdImputacion1, @Importe1, @ImporteDolar1, @ImporteEuro1
   END
CLOSE CtaCte1
DEALLOCATE CtaCte1

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2