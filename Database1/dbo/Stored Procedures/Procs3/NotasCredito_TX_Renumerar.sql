CREATE  Procedure [dbo].[NotasCredito_TX_Renumerar]

@IdsNotasCredito varchar(4000),
@NumeroInicial int

AS 

SET NOCOUNT ON

DECLARE @IdNotaCredito int, @TipoABC varchar(1), @PuntoVenta int, @Numero int, @NuevoNumero int, @RegistrosConError int, @PuntoVentaAProcesar int

CREATE TABLE #Auxiliar1 
			(
			 IdNotaCredito INTEGER,
			 TipoABC VARCHAR(1),
			 PuntoVenta INTEGER,
			 Numero INTEGER,
			 NuevoNumero INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdNotaCredito) ON [PRIMARY]

CREATE TABLE #Auxiliar9 
			(
			 Resultado VARCHAR(150)
			)

INSERT INTO #Auxiliar1
 SELECT IdNotaCredito, TipoABC, PuntoVenta, NumeroNotaCredito, 0
 FROM NotasCredito 
 WHERE Patindex('%('+Convert(varchar,IdNotaCredito)+')%', @IdsNotasCredito)<>0

SET @NuevoNumero=@NumeroInicial
SET @PuntoVentaAProcesar=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNotaCredito, TipoABC, PuntoVenta, Numero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, Numero
OPEN Cur
FETCH NEXT FROM Cur INTO @IdNotaCredito, @TipoABC, @PuntoVenta, @Numero
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @PuntoVentaAProcesar=0
		SET @PuntoVentaAProcesar=@PuntoVenta

	UPDATE #Auxiliar1
	SET NuevoNumero=@NuevoNumero
	WHERE IdNotaCredito=@IdNotaCredito
	
	IF Exists(Select Top 1 IdNotaCredito From NotasCredito Where TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroNotaCredito=@NuevoNumero and IdNotaCredito<>@IdNotaCredito)
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La nota de credito original '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' no puede renumerarse a la '+@TipoABC+' '+
		 Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@NuevoNumero)))+Convert(varchar,@NuevoNumero)+' porque ya existe.'
		 )
		
	IF Len(IsNull((Select Top 1 CAE From NotasCredito Where IdNotaCredito=@IdNotaCredito),''))>0
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La nota de credito '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' tiene CAE y no puede formar parte de la renumeracion.'
		 )
		
	IF @PuntoVentaAProcesar<>@PuntoVenta and @PuntoVentaAProcesar<>-1
	  BEGIN
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('En el grupo de notas de credito elegidas para renumeracion hay puntos de venta distintos' )
		SET @PuntoVentaAProcesar=-1
	  END

	SET @NuevoNumero=@NuevoNumero+1

	FETCH NEXT FROM Cur INTO @IdNotaCredito, @TipoABC, @PuntoVenta, @Numero
  END
CLOSE Cur
DEALLOCATE Cur

SET @RegistrosConError=IsNull((Select Count(*) From #Auxiliar9),0)

IF @RegistrosConError=0
  BEGIN
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNotaCredito, TipoABC, PuntoVenta, Numero, NuevoNumero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, NuevoNumero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdNotaCredito, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		UPDATE NotasCredito
		SET NumeroNotaCredito=@NuevoNumero
		WHERE IdNotaCredito=@IdNotaCredito
		
		UPDATE CuentasCorrientesDeudores
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComp=4 and IdComprobante=@IdNotaCredito
		
		UPDATE Subdiarios
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComprobante=4 and IdComprobante=@IdNotaCredito

		FETCH NEXT FROM Cur INTO @IdNotaCredito, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

SET NOCOUNT OFF

SELECT 0 as [Id],* FROM #Auxiliar9

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar9
