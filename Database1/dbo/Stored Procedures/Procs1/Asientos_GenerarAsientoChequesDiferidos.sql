CREATE PROCEDURE [dbo].[Asientos_GenerarAsientoChequesDiferidos]

AS

SET NOCOUNT ON

DECLARE @ActivarCircuitoChequesDiferidos varchar(2), @FechaUltimoCierreEjercicio datetime

SET @ActivarCircuitoChequesDiferidos=ISNULL((Select ActivarCircuitoChequesDiferidos From Parametros Where IdParametro=1),'NO')
SET @FechaUltimoCierreEjercicio=ISNULL((Select FechaUltimoCierreEjercicio From Parametros Where IdParametro=1),Convert(datetime,'01/01/1900'))

CREATE TABLE #Auxiliar0 (IdValor INTEGER, IdCuenta INTEGER, IdCuentaParaChequesDiferidos INTEGER, NumeroOrdenPago INTEGER, FechaOrdenPago DATETIME, IdMoneda INTEGER, 
						 CotizacionMoneda NUMERIC(18,4), NumeroValor NUMERIC(18,0), FechaValor DATETIME, NumeroInterno INTEGER, Importe NUMERIC(18,2))
CREATE NONCLUSTERED INDEX IX__Auxiliar0 ON #Auxiliar0 (FechaValor, IdValor) ON [PRIMARY]

INSERT INTO #Auxiliar0 
 SELECT Valores.IdValor, Bancos.IdCuenta, IsNull(Bancos.IdCuentaParaChequesDiferidos,0), OrdenesPago.NumeroOrdenPago, OrdenesPago.FechaOrdenPago, 
		OrdenesPago.IdMoneda, OrdenesPago.CotizacionMoneda, Valores.NumeroValor, Valores.FechaValor, Valores.NumeroInterno, Valores.Importe
 FROM Valores
 LEFT OUTER JOIN DetalleOrdenesPagoValores dopv ON Valores.IdDetalleOrdenPagoValores=dopv.IdDetalleOrdenPagoValores
 LEFT OUTER JOIN OrdenesPago ON dopv.IdOrdenPago=OrdenesPago.IdOrdenPago
 LEFT OUTER JOIN BancoChequeras ON dopv.IdBancoChequera=BancoChequeras.IdBancoChequera
 LEFT OUTER JOIN Bancos ON Valores.IdBanco=Bancos.IdBanco
 WHERE @ActivarCircuitoChequesDiferidos='SI' and 
		Valores.IdDetalleOrdenPagoValores is not null and 
		IsNull(BancoChequeras.ChequeraPagoDiferido,'NO')='SI' and 
		Valores.IdTipoComprobante=17 and 
		Valores.IdTipoValor=6 and 
		IsNull(Valores.RegistroContableChequeDiferido,'NO')='NO' and 
		Valores.FechaValor>@FechaUltimoCierreEjercicio and 
		Valores.FechaValor<=GetDate() and 
		IsNull(Valores.Anulado,'NO')<>'SI'
	
IF IsNull((SELECT COUNT(*) FROM #Auxiliar0),0)>0
  BEGIN

	BEGIN TRAN

	DECLARE @ProximoAsiento int, @IdAsiento int, @FechaCorte datetime, @IdValor int, @IdCuenta int, @IdCuentaParaChequesDiferidos int, @NumeroOrdenPago int, 
			@FechaOrdenPago datetime, @NumeroValor numeric(18,0), @FechaValor datetime, @NumeroInterno int, @IdMoneda int, @CotizacionMoneda numeric(18,4), 
			@Importe numeric(18,2), @Item int, @Detalle varchar(100)

	SET @FechaCorte=0

	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdValor, IdCuenta, IdCuentaParaChequesDiferidos, NumeroOrdenPago, FechaOrdenPago, IdMoneda, CotizacionMoneda, NumeroValor, FechaValor, NumeroInterno, Importe 
			FROM #Auxiliar0 
			ORDER BY FechaValor, IdValor
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdValor, @IdCuenta, @IdCuentaParaChequesDiferidos, @NumeroOrdenPago, @FechaOrdenPago, @IdMoneda, @CotizacionMoneda, @NumeroValor, 
							 @FechaValor, @NumeroInterno, @Importe
	SET @Item=1
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		IF @IdCuentaParaChequesDiferidos<>0
		  BEGIN
			IF @FechaCorte<>@FechaValor
			  BEGIN
				SET @ProximoAsiento=ISNULL((Select ProximoAsiento From Parametros Where IdParametro=1),1)

				INSERT INTO Asientos (NumeroAsiento, FechaAsiento, Concepto, IdIngreso, FechaIngreso)
				VALUES (@ProximoAsiento,@FechaValor, 'Cheques de pago diferido', 0, GetDate())
				SET @IdAsiento=@@identity

				UPDATE Parametros SET ProximoAsiento=@ProximoAsiento+1 WHERE IdParametro=1

				SET @FechaCorte=@FechaValor
			  END

			SET @Detalle='Cheque: '+Convert(varchar,IsNull(@NumeroValor,0))+' '+Convert(varchar,@FechaValor,103)+' - '+
							'OP: '+Convert(varchar,IsNull(@NumeroOrdenPago,0))+' del '+Convert(varchar,@FechaOrdenPago,103)

			INSERT INTO DetalleAsientos
			(IdAsiento, IdCuenta, Detalle, Debe, Haber, IdMoneda, CotizacionMoneda,
			 IdMonedaDestino, CotizacionMonedaDestino, ImporteEnMonedaDestino, 
			 Item, IdValor)
			VALUES 
			(@IdAsiento, @IdCuentaParaChequesDiferidos, Substring(@Detalle,1,50), @Importe*@CotizacionMoneda, 
			 Null, @IdMoneda, @CotizacionMoneda, @IdMoneda, @CotizacionMoneda, @Importe, 
			 @Item, @IdValor)
			SET @Item=@Item+1

			INSERT INTO DetalleAsientos
			(IdAsiento, IdCuenta, Detalle, Debe, Haber, IdMoneda, CotizacionMoneda,
			 IdMonedaDestino, CotizacionMonedaDestino, ImporteEnMonedaDestino, 
			 Item, IdValor)
			VALUES 
			(@IdAsiento, @IdCuenta, Substring(@Detalle,1,50), Null, @Importe*@CotizacionMoneda, 
			 @IdMoneda, @CotizacionMoneda, @IdMoneda, @CotizacionMoneda, @Importe, 
			 @Item, @IdValor)
			SET @Item=@Item+1

			UPDATE Valores SET RegistroContableChequeDiferido='SI' WHERE IdValor=@IdValor
		  END
		FETCH NEXT FROM Cur INTO @IdValor, @IdCuenta, @IdCuentaParaChequesDiferidos, @NumeroOrdenPago, @FechaOrdenPago, @IdMoneda, @CotizacionMoneda, @NumeroValor, 
								 @FechaValor, @NumeroInterno, @Importe
	  END
	CLOSE Cur
	DEALLOCATE Cur

	IF @@ERROR <> 0 GOTO AbortTransaction

	COMMIT TRAN
	GOTO EndTransaction

	AbortTransaction:
	ROLLBACK TRAN
  END

EndTransaction:
DROP TABLE #Auxiliar0

SET NOCOUNT OFF