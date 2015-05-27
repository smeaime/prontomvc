
CREATE PROCEDURE [dbo].[Asientos_TX_GenerarAsientoSueldos]

@Fecha datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdEmpleado INTEGER,
			 IdObra INTEGER,
			 Porcentaje NUMERIC(18,4)
			)
INSERT INTO #Auxiliar1 
 SELECT hh.IdEmpleado, hh.IdObra, hh.Porcentaje
 FROM _TempDistribucionHoras hh

-- GENERACION DEL ASIENTO

DECLARE @IdEmpleado int, @IdCuenta int, @IdCuentaObra int, @CodigoDebeHaber varchar(1), @Importe numeric(18,2), @IdObra int, @Ok varchar(1), 
	@Porcentaje numeric(18,4), @NumeroAsiento int, @sql1 nvarchar(4000), @IdAsiento int, @ImporteAsiento numeric(18,2), @Item int, @Item0 int, 
	@Empleado varchar(100), @NumeroObra varchar(13), @CodigoCuenta int, @CantidadRegistros int, @ImporteControl numeric(18,2), @IdDetalleAsiento int

CREATE TABLE #Auxiliar3 (Detalle VARCHAR(200))

CREATE TABLE #Auxiliar4 
			(
			 IdObra INTEGER,
			 Porcentaje NUMERIC(18,4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdObra) ON [PRIMARY]

CREATE TABLE #Auxiliar5 
			(
			 IdEmpleado INTEGER,
			 IdCuenta INTEGER,
			 CodigoDebeHaber VARCHAR(1),
			 Importe NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar5 ON #Auxiliar5 (IdEmpleado,IdCuenta,CodigoDebeHaber) ON [PRIMARY]
INSERT INTO #Auxiliar5 
 SELECT ai.IdEmpleado, ai.IdCuenta, ai.CodigoDebeHaber, Sum(IsNull(ai.Importe,0))
 FROM _TempAsientoSueldos ai
 GROUP BY ai.IdEmpleado, ai.IdCuenta, ai.CodigoDebeHaber

SET @CantidadRegistros=IsNull((Select Count(*) From #Auxiliar5),0)
IF @CantidadRegistros=0
   BEGIN
	INSERT INTO #Auxiliar3 (Detalle) VALUES ('No se encontraron asientos importados en las fechas informadas') 
	GOTO Final
   END

--LEER EL PROXIMO NUMERO DE ASIENTO
SET @NumeroAsiento=IsNull((Select Top 1 ProximoAsiento From Parametros Where IdParametro=1),1)
UPDATE Parametros
SET ProximoAsiento=@NumeroAsiento+1
WHERE IdParametro=1

--GENERAR CABECERA DE ASIENTO
INSERT INTO Asientos
(NumeroAsiento, FechaAsiento, Concepto, IdIngreso, FechaIngreso) 
VALUES
(@NumeroAsiento, @Fecha, 'ASIENTO DE SUELDOS', 0, GetDate())
SET @IdAsiento=@@identity

SET @Item=0

/*  CURSOR  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdEmpleado, IdCuenta, CodigoDebeHaber, Importe FROM #Auxiliar5 ORDER BY IdEmpleado, IdCuenta, CodigoDebeHaber
OPEN Cur
FETCH NEXT FROM Cur INTO @IdEmpleado, @IdCuenta, @CodigoDebeHaber, @Importe
WHILE @@FETCH_STATUS = 0
   BEGIN
	TRUNCATE TABLE #Auxiliar4
	INSERT INTO #Auxiliar4 
	 SELECT IdObra, Porcentaje
	 FROM #Auxiliar1
	 WHERE IdEmpleado=@IdEmpleado

	SET @Empleado=IsNull((Select Top 1 Apellido+', '+Nombre From _TempAsientoSueldos Where IdEmpleado=@IdEmpleado),'')

	SET @CantidadRegistros=IsNull((Select Count(*) From #Auxiliar4),0)
	IF @CantidadRegistros=0
	   BEGIN
		INSERT INTO #Auxiliar3 (Detalle) VALUES ('No se encontro distribucion por obra para el empleado '+@Empleado+' y existe un asiento importado') 
		GOTO Proximo
	   END

	SET @Item0=@Item

	DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY FOR SELECT IdObra, Porcentaje FROM #Auxiliar4 ORDER BY IdObra
	OPEN Cur1
	FETCH NEXT FROM Cur1 INTO @IdObra, @Porcentaje
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		IF @CodigoDebeHaber='D'
		   BEGIN
			SET @IdCuentaObra=IsNull((Select Top 1 IdCuenta From Cuentas Where IdObra=@IdObra and 
							IsNull((Select Top 1 CuentasGastos.IdCuentaMadre From CuentasGastos 
								Where CuentasGastos.IdCuentaGasto=Cuentas.IdCuentaGasto),0)=@IdCuenta),0)
		   END
		ELSE
		   BEGIN
			SET @IdCuentaObra=@IdCuenta
		   END

		SET @ImporteAsiento=Round(@Importe*@Porcentaje/100,2)
		SET @Item=@Item+1
		SET @Ok='S'

		IF @IdCuentaObra=0
		   BEGIN
			SET @NumeroObra=IsNull((Select Top 1 NumeroObra From Obras Where IdObra=@IdObra),'')
			SET @CodigoCuenta=IsNull((Select Top 1 Codigo From Cuentas Where IdCuenta=@IdCuenta),0)
			INSERT INTO #Auxiliar3 (Detalle) VALUES ('No se encontro la cuenta para la obra '+@NumeroObra+' ('+Convert(varchar,@IdObra)+'), '+
								 'cuenta madre '+Convert(varchar,@CodigoCuenta)+' ('+Convert(varchar,@IdCuenta)+')') 
			SET @Ok='N'
		   END

		IF @Ok='S'
			INSERT INTO DetalleAsientos
			(IdAsiento, IdCuenta, Detalle, Debe, Haber, IdObra, IdMoneda, CotizacionMoneda, IdMonedaDestino, CotizacionMonedaDestino, Item)
			VALUES
			(@IdAsiento, @IdCuentaObra, Substring(@Empleado,1,50), Case When @CodigoDebeHaber='D' Then @ImporteAsiento Else Null End, 
			 Case When @CodigoDebeHaber='D' Then Null Else @ImporteAsiento End, @IdObra, 1, 1, 1, 1, @Item)

		FETCH NEXT FROM Cur1 INTO @IdObra, @Porcentaje
	   END
	CLOSE Cur1
	DEALLOCATE Cur1

	SET @ImporteControl=IsNull((Select Sum(IsNull(Debe,Haber)) From DetalleAsientos Where IdAsiento=@IdAsiento and Item>@Item0 and Item<=@Item),0)
	IF @ImporteControl<>@Importe
	   BEGIN
		SET @IdDetalleAsiento=IsNull((Select Top 1 IdDetalleAsiento From DetalleAsientos Where IdAsiento=@IdAsiento and Item>@Item0 and Item<=@Item),0)
		IF @CodigoDebeHaber='D' and @IdDetalleAsiento>0
			UPDATE DetalleAsientos
			SET Debe=Debe+(@Importe-@ImporteControl)
			WHERE IdDetalleAsiento=@IdDetalleAsiento
		IF @CodigoDebeHaber='H' and @IdDetalleAsiento>0
			UPDATE DetalleAsientos
			SET Haber=Haber+(@Importe-@ImporteControl)
			WHERE IdDetalleAsiento=@IdDetalleAsiento
	   END

	Proximo:
	FETCH NEXT FROM Cur INTO @IdEmpleado, @IdCuenta, @CodigoDebeHaber, @Importe
   END
CLOSE Cur
DEALLOCATE Cur

INSERT INTO #Auxiliar3 (Detalle) VALUES ('SE HA GENERADO EL ASIENTO NUMERO '+Convert(varchar,@NumeroAsiento)) 

Final:
SET NOCOUNT OFF

SELECT 0 as [IdAux], * FROM #Auxiliar3

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4
DROP TABLE #Auxiliar5
