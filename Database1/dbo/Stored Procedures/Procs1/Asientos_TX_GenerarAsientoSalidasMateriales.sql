CREATE PROCEDURE [dbo].[Asientos_TX_GenerarAsientoSalidasMateriales]

@Desde datetime,
@Hasta datetime,
@TiposSalida varchar(1000),
@GenerarAsiento varchar(2)

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleSalidaMateriales INTEGER,
			 IdCuentaCompras INTEGER,
			 IdCuentaComprasActivo INTEGER,
			 IdObra INTEGER,
			 NumeroSalidaMateriales VARCHAR(20),
			 Articulo VARCHAR(300),
			 Costo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdDetalleSalidaMateriales) ON [PRIMARY]

CREATE TABLE #Auxiliar2 
			(
			 IdCuentaCompras INTEGER,
			 IdCuentaComprasActivo INTEGER,
			 IdObra INTEGER,
			 Costo NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdCuentaCompras,IdCuentaComprasActivo,IdObra) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT 
  dsm.IdDetalleSalidaMateriales,
  Rubros.IdCuentaCompras,
  Rubros.IdCuentaComprasActivo,
  SalidasMateriales.IdObra, --dsm.IdObra,
  Substring(Substring('0000',1,4-Len(Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))))+Convert(varchar,IsNull(SalidasMateriales.NumeroSalidaMateriales2,0))+'-'+
	Substring('00000000',1,8-Len(Convert(varchar,SalidasMateriales.NumeroSalidaMateriales)))+Convert(varchar,SalidasMateriales.NumeroSalidaMateriales),1,20),
  Articulos.Descripcion,
  IsNull(dsm.Cantidad,0) * IsNull(Articulos.CostoReposicion,0)
 FROM DetalleSalidasMateriales dsm
 LEFT OUTER JOIN SalidasMateriales ON dsm.IdSalidaMateriales = SalidasMateriales.IdSalidaMateriales
 LEFT OUTER JOIN Articulos ON dsm.IdArticulo = Articulos.IdArticulo
 LEFT OUTER JOIN Rubros ON Articulos.IdRubro = Rubros.IdRubro
 WHERE IsNull(SalidasMateriales.Anulada,'NO')<>'SI' and 
		SalidasMateriales.FechaSalidaMateriales>=@Desde and SalidasMateriales.FechaSalidaMateriales<=@Hasta and 
		(Len(@TiposSalida)=0 or Patindex('%('+IsNull(SalidasMateriales.ClaveTipoSalida,'*')+')%', @TiposSalida)<>0)

INSERT INTO #Auxiliar2 
 SELECT IdCuentaCompras, IdCuentaComprasActivo, IdObra, Sum(IsNull(Costo,0))
 FROM #Auxiliar1
 GROUP BY IdCuentaCompras, IdCuentaComprasActivo, IdObra


-- GENERACION DEL ASIENTO

DECLARE @IdDetalleSalidaMateriales int, @IdCuenta int, @IdCuentaObra int, @CodigoDebeHaber varchar(1), @Importe numeric(18,2), @IdObra int, @Ok varchar(1), 
		@IdCuentaCompras int, @IdCuentaComprasActivo int, @Costo numeric(18,2), @Articulo varchar(300), @NumeroAsiento int, @sql1 nvarchar(4000), 
		@IdAsiento int, @ImporteAsiento numeric(18,2), @Item int, @Item0 int, @NumeroObra varchar(13), @CodigoCuenta int, @CantidadRegistros int, 
		@ImporteControl numeric(18,2), @IdDetalleAsiento int, @ConError int, @NumeroSalidaMateriales varchar(20)

CREATE TABLE #Auxiliar3 (Detalle VARCHAR(500))

SET @CantidadRegistros=IsNull((Select Count(*) From #Auxiliar2),0)
IF @CantidadRegistros=0
  BEGIN
	INSERT INTO #Auxiliar3 (Detalle) VALUES ('No se encontraron movimientos en las fechas informadas') 
	GOTO Final
  END

/*  CURSOR  */
SET @ConError=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdDetalleSalidaMateriales, IdCuentaCompras, IdCuentaComprasActivo, IdObra, NumeroSalidaMateriales, Articulo, Costo FROM #Auxiliar1 ORDER BY Articulo
OPEN Cur
FETCH NEXT FROM Cur INTO @IdDetalleSalidaMateriales, @IdCuentaCompras, @IdCuentaComprasActivo, @IdObra, @NumeroSalidaMateriales, @Articulo, @Costo
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @IdCuentaCompras=0
	  BEGIN
		INSERT INTO #Auxiliar3 (Detalle) VALUES ('El articulo '+@Articulo+' no tiene cuenta de compras [ Salida : '+@NumeroSalidaMateriales+' ]') 
		SET @ConError=1
	  END
	IF @IdCuentaComprasActivo=0
	  BEGIN
		INSERT INTO #Auxiliar3 (Detalle) VALUES ('El articulo '+@Articulo+' no tiene cuenta de compras al activo [ Salida : '+@NumeroSalidaMateriales+' ]') 
		SET @ConError=1
	  END
	IF @Costo=0
	  BEGIN
		INSERT INTO #Auxiliar3 (Detalle) VALUES ('El articulo '+@Articulo+' no tiene costo [ Salida : '+@NumeroSalidaMateriales+' ]') 
		SET @ConError=1
	  END

	FETCH NEXT FROM Cur INTO @IdDetalleSalidaMateriales, @IdCuentaCompras, @IdCuentaComprasActivo, @IdObra, @NumeroSalidaMateriales, @Articulo, @Costo
  END
CLOSE Cur
DEALLOCATE Cur

IF @ConError=1
	GOTO Final

IF @GenerarAsiento='SI'
  BEGIN
	--LEER EL PROXIMO NUMERO DE ASIENTO
	SET @NumeroAsiento=IsNull((Select Top 1 ProximoAsiento From Parametros Where IdParametro=1),1)
	UPDATE Parametros
	SET ProximoAsiento=@NumeroAsiento+1
	WHERE IdParametro=1

	--GENERAR CABECERA DE ASIENTO
	INSERT INTO Asientos
	(NumeroAsiento, FechaAsiento, Concepto, IdIngreso, FechaIngreso) 
	VALUES
	(@NumeroAsiento, @Hasta, 'ASIENTO DE SALIDAS DE MATERIALES', 0, GetDate())
	SET @IdAsiento=@@identity

	/*  CURSOR  */
	SET @Item=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdCuentaCompras, IdCuentaComprasActivo, IdObra, Costo FROM #Auxiliar2 ORDER BY IdCuentaCompras, IdCuentaComprasActivo, IdObra
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdCuentaCompras, @IdCuentaComprasActivo, @IdObra, @Costo
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		SET @Item=@Item+1
		INSERT INTO DetalleAsientos
		(IdAsiento, IdCuenta, Detalle, Debe, Haber, IdObra, IdMoneda, CotizacionMoneda, IdMonedaDestino, CotizacionMonedaDestino, Item)
		VALUES
		(@IdAsiento, @IdCuentaComprasActivo, '', Null, @Costo, Null, 1, 1, 1, 1, @Item)

		SET @Item=@Item+1
		INSERT INTO DetalleAsientos
		(IdAsiento, IdCuenta, Detalle, Debe, Haber, IdObra, IdMoneda, CotizacionMoneda, IdMonedaDestino, CotizacionMonedaDestino, Item)
		VALUES
		(@IdAsiento, @IdCuentaCompras, '', @Costo, Null, @IdObra, 1, 1, 1, 1, @Item)

		FETCH NEXT FROM Cur INTO @IdCuentaCompras, @IdCuentaComprasActivo, @IdObra, @Costo
	  END
	CLOSE Cur
	DEALLOCATE Cur

	INSERT INTO #Auxiliar3 (Detalle) VALUES ('SE HA GENERADO EL ASIENTO NUMERO '+Convert(varchar,@NumeroAsiento)) 
  END
ELSE
  BEGIN
	INSERT INTO #Auxiliar3 (Detalle) VALUES ('Ok') 
  END
  
Final:
SET NOCOUNT OFF

SELECT 0 as [IdAux], * 
FROM #Auxiliar3

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
