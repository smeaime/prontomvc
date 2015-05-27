CREATE PROCEDURE [dbo].[OrdenesPago_ReversionContablePorAnulacion]

@IdComprobante int,
@IdTipoComprobante int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
				IdSubdiario int, 
				IdCuentaSubdiario int, 
				IdCuenta int,
				IdTipoComprobante int,
				NumeroComprobante int,
				FechaComprobante datetime,
				Detalle varchar(100),
				IdComprobante int,
				IdMoneda int,
				CotizacionMoneda numeric(18,4),
				Debe numeric(18,2),
				Haber numeric(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdSubdiario) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdSubdiario, IdCuentaSubdiario, IdCuenta, IdTipoComprobante, NumeroComprobante, FechaComprobante, Detalle, IdComprobante, IdMoneda, CotizacionMoneda, Debe, Haber
 FROM Subdiarios
 WHERE IdTipoComprobante=@IdTipoComprobante And IdComprobante=@IdComprobante

DECLARE @IdSubdiario int, @IdCuentaSubdiario int, @IdCuenta int, @IdTipoComprobante1 int, @NumeroComprobante int, @FechaComprobante datetime, @Detalle varchar(100), 
		@IdComprobante1 int, @IdMoneda int, @CotizacionMoneda numeric(18,4), @Debe numeric(18,2), @Haber numeric(18,2), @Fecha datetime

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
	SELECT IdSubdiario, IdCuentaSubdiario, IdCuenta, IdTipoComprobante, NumeroComprobante, FechaComprobante, Detalle, IdComprobante, IdMoneda, CotizacionMoneda, Debe, Haber FROM #Auxiliar1 ORDER BY IdSubdiario
OPEN Cur
FETCH NEXT FROM Cur INTO @IdSubdiario, @IdCuentaSubdiario, @IdCuenta, @IdTipoComprobante1, @NumeroComprobante, @FechaComprobante, @Detalle, @IdComprobante1, @IdMoneda, @CotizacionMoneda, @Debe, @Haber
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @Fecha=Convert(datetime,Convert(varchar,Day(GetDate()))+'/'+Convert(varchar,Month(GetDate()))+'/'+Convert(varchar,Year(GetDate())),103)
	INSERT INTO Subdiarios
	(IdCuentaSubdiario, IdCuenta, IdTipoComprobante, NumeroComprobante, FechaComprobante, Detalle, IdComprobante, IdMoneda, CotizacionMoneda, Debe, Haber)
	VALUES
	(@IdCuentaSubdiario, @IdCuenta, @IdTipoComprobante1, @NumeroComprobante, @Fecha, @Detalle, @IdComprobante1, @IdMoneda, @CotizacionMoneda, @Haber, @Debe)

	FETCH NEXT FROM Cur INTO @IdSubdiario, @IdCuentaSubdiario, @IdCuenta, @IdTipoComprobante1, @NumeroComprobante, @FechaComprobante, @Detalle, @IdComprobante1, @IdMoneda, @CotizacionMoneda, @Debe, @Haber
  END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1

SET NOCOUNT OFF
