CREATE  Procedure [dbo].[NotasDebito_TX_Renumerar]

@IdsNotasDebito varchar(4000),
@NumeroInicial int

AS 

SET NOCOUNT ON

DECLARE @IdNotaDebito int, @TipoABC varchar(1), @PuntoVenta int, @Numero int, @NuevoNumero int, @RegistrosConError int, @PuntoVentaAProcesar int

CREATE TABLE #Auxiliar1 
			(
			 IdNotaDebito INTEGER,
			 TipoABC VARCHAR(1),
			 PuntoVenta INTEGER,
			 Numero INTEGER,
			 NuevoNumero INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdNotaDebito) ON [PRIMARY]

CREATE TABLE #Auxiliar9 
			(
			 Resultado VARCHAR(150)
			)

INSERT INTO #Auxiliar1
 SELECT IdNotaDebito, TipoABC, PuntoVenta, NumeroNotaDebito, 0
 FROM NotasDebito 
 WHERE Patindex('%('+Convert(varchar,IdNotaDebito)+')%', @IdsNotasDebito)<>0

SET @NuevoNumero=@NumeroInicial
SET @PuntoVentaAProcesar=0

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNotaDebito, TipoABC, PuntoVenta, Numero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, Numero
OPEN Cur
FETCH NEXT FROM Cur INTO @IdNotaDebito, @TipoABC, @PuntoVenta, @Numero
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @PuntoVentaAProcesar=0
		SET @PuntoVentaAProcesar=@PuntoVenta

	UPDATE #Auxiliar1
	SET NuevoNumero=@NuevoNumero
	WHERE IdNotaDebito=@IdNotaDebito
	
	IF Exists(Select Top 1 IdNotaDebito From NotasDebito Where TipoABC=@TipoABC and PuntoVenta=@PuntoVenta and NumeroNotaDebito=@NuevoNumero and IdNotaDebito<>@IdNotaDebito)
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La nota de debito original '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' no puede renumerarse a la '+@TipoABC+' '+
		 Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@NuevoNumero)))+Convert(varchar,@NuevoNumero)+' porque ya existe.'
		 )
		
	IF Len(IsNull((Select Top 1 CAE From NotasDebito Where IdNotaDebito=@IdNotaDebito),''))>0
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('La nota de debito '+@TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(@PuntoVenta,0))))+Convert(varchar,IsNull(@PuntoVenta,0))+'-'+
		 Substring('00000000',1,8-Len(Convert(varchar,@Numero)))+Convert(varchar,@Numero)+' tiene CAE y no puede formar parte de la renumeracion.'
		 )
		
	IF @PuntoVentaAProcesar<>@PuntoVenta and @PuntoVentaAProcesar<>-1
	  BEGIN
		INSERT INTO #Auxiliar9
		(Resultado) 
		VALUES 
		('En el grupo de notas de debito elegidas para renumeracion hay puntos de venta distintos' )
		SET @PuntoVentaAProcesar=-1
	  END

	SET @NuevoNumero=@NuevoNumero+1

	FETCH NEXT FROM Cur INTO @IdNotaDebito, @TipoABC, @PuntoVenta, @Numero
  END
CLOSE Cur
DEALLOCATE Cur

SET @RegistrosConError=IsNull((Select Count(*) From #Auxiliar9),0)

IF @RegistrosConError=0
  BEGIN
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdNotaDebito, TipoABC, PuntoVenta, Numero, NuevoNumero FROM #Auxiliar1 ORDER BY TipoABC, PuntoVenta, NuevoNumero
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdNotaDebito, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	WHILE @@FETCH_STATUS = 0
	  BEGIN
		UPDATE NotasDebito
		SET NumeroNotaDebito=@NuevoNumero
		WHERE IdNotaDebito=@IdNotaDebito
		
		UPDATE CuentasCorrientesDeudores
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComp=3 and IdComprobante=@IdNotaDebito
		
		UPDATE Subdiarios
		SET NumeroComprobante=@NuevoNumero
		WHERE IdTipoComprobante=3 and IdComprobante=@IdNotaDebito

		FETCH NEXT FROM Cur INTO @IdNotaDebito, @TipoABC, @PuntoVenta, @Numero, @NuevoNumero
	  END
	CLOSE Cur
	DEALLOCATE Cur
  END

SET NOCOUNT OFF

SELECT 0 as [Id],* FROM #Auxiliar9

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar9
