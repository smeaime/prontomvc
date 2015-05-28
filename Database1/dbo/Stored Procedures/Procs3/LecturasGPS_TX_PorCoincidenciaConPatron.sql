CREATE PROCEDURE [dbo].[LecturasGPS_TX_PorCoincidenciaConPatron]

@Latitud1 numeric(18,8), 
@Longitud1 numeric(18,8), 
@Altura1 numeric(18,8), 
@Latitud2 numeric(18,8), 
@Longitud2 numeric(18,8), 
@Altura2 numeric(18,8), 
@Tolerancia numeric(18,8)

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdPatronGPS INTEGER, 
			 IdDetallePatronGPSInicial INTEGER, 
			 DistanciaAlPuntoInicial NUMERIC(18,8), 
			 NumeroRegistroInicial INTEGER, 
			 IdDetallePatronGPSFinal INTEGER, 
			 DistanciaAlPuntoFinal NUMERIC(18,8),
			 NumeroRegistroFinal INTEGER, 
			 SumaDiferenciaDistancias NUMERIC(18,8), 
			 DistanciaSegunPatron NUMERIC(18,8)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdPatronGPS) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT IdPatronGPS, Null, Null, Null, Null, Null, Null, Null, Null
 FROM PatronesGPS
 WHERE IsNull(Activa,'')<>'NO'

DECLARE @IdPatronGPS int, @IdDetallePatronGPS int, @IdDetallePatronGPS1 int, @IdDetallePatronGPS2 int, 
	@degtorad numeric(18,8), @radtodeg numeric(18,8), @Distancia numeric(18,8), @Distancia1 numeric(18,8), @Distancia2 numeric(18,8), 
	@Latitud numeric(18,8), @Longitud numeric(18,8), @Altura numeric(18,8), 
	@NumeroRegistro1 int, @NumeroRegistro2 int, @DistanciaKmSuma numeric(18,8)

SET @degtorad=0.01745329
SET @radtodeg=57.29577951

/*  CURSOR  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdPatronGPS
		FROM #Auxiliar1
		ORDER BY IdPatronGPS
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPatronGPS
WHILE @@FETCH_STATUS = 0
    BEGIN
	-- DETERMINACION DEL PUNTO INICIAL SOBRE LAS TRAYECTORIAS PATRON POSIBLES
	SET @IdDetallePatronGPS1=IsNull((Select Top 1 IdDetallePatronGPS From DetallePatronesGPS
					 Where IdPatronGPS=@IdPatronGPS and Latitud<=@Latitud1
					 Order By IdPatronGPS, Latitud Desc),0)
	SET @Latitud=IsNull((Select Top 1 Latitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS1),0)
	SET @Longitud=IsNull((Select Top 1 Longitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS1),0)
	SET @Distancia1=Acos((Sin(@Latitud*@degtorad)*Sin(@Latitud1*@degtorad))+
				(Cos(@Latitud*@degtorad)*Cos(@Latitud1*@degtorad)*Cos((@Longitud-@Longitud1)*@degtorad))) * @radtodeg * 111.302

	SET @IdDetallePatronGPS2=IsNull((Select Top 1 IdDetallePatronGPS From DetallePatronesGPS
					 Where IdPatronGPS=@IdPatronGPS and Longitud<=@Longitud1
					 Order By IdPatronGPS, Longitud Desc),0)
	SET @Latitud=IsNull((Select Top 1 Latitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS2),0)
	SET @Longitud=IsNull((Select Top 1 Longitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS2),0)
	SET @Distancia2=Acos((Sin(@Latitud*@degtorad)*Sin(@Latitud1*@degtorad))+
				(Cos(@Latitud*@degtorad)*Cos(@Latitud1*@degtorad)*Cos((@Longitud-@Longitud1)*@degtorad))) * @radtodeg * 111.302
	IF @Distancia1<=@Distancia2
	    BEGIN
		SET @Distancia=@Distancia1
		SET @IdDetallePatronGPS=@IdDetallePatronGPS1
	    END
	ELSE
	    BEGIN
		SET @Distancia=@Distancia2
		SET @IdDetallePatronGPS=@IdDetallePatronGPS2
	    END

	SET @NumeroRegistro1=IsNull((Select Top 1 NumeroRegistro From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS),0)

	UPDATE #Auxiliar1
	SET IdDetallePatronGPSInicial=@IdDetallePatronGPS, DistanciaAlPuntoInicial=@Distancia
	WHERE CURRENT OF Cur

	-- DETERMINACION DEL PUNTO FINAL SOBRE LAS TRAYECTORIAS PATRON POSIBLES
	SET @IdDetallePatronGPS1=IsNull((Select Top 1 IdDetallePatronGPS From DetallePatronesGPS
					 Where IdPatronGPS=@IdPatronGPS and Latitud<=@Latitud2
					 Order By IdPatronGPS, Latitud Desc),0)
	SET @Latitud=IsNull((Select Top 1 Latitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS1),0)
	SET @Longitud=IsNull((Select Top 1 Longitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS1),0)
	SET @Distancia1=Acos((Sin(@Latitud*@degtorad)*Sin(@Latitud2*@degtorad))+
				(Cos(@Latitud*@degtorad)*Cos(@Latitud2*@degtorad)*Cos((@Longitud-@Longitud2)*@degtorad))) * @radtodeg * 111.302

	SET @IdDetallePatronGPS2=IsNull((Select Top 1 IdDetallePatronGPS From DetallePatronesGPS
					 Where IdPatronGPS=@IdPatronGPS and Longitud<=@Longitud2
					 Order By IdPatronGPS, Longitud Desc),0)
	SET @Latitud=IsNull((Select Top 1 Latitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS2),0)
	SET @Longitud=IsNull((Select Top 1 Longitud From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS2),0)
	SET @Distancia2=Acos((Sin(@Latitud*@degtorad)*Sin(@Latitud2*@degtorad))+
				(Cos(@Latitud*@degtorad)*Cos(@Latitud2*@degtorad)*Cos((@Longitud-@Longitud2)*@degtorad))) * @radtodeg * 111.302

	IF @Distancia1<=@Distancia2
	    BEGIN
		SET @Distancia=@Distancia1
		SET @IdDetallePatronGPS=@IdDetallePatronGPS1
	    END
	ELSE
	    BEGIN
		SET @Distancia=@Distancia2
		SET @IdDetallePatronGPS=@IdDetallePatronGPS2
	    END

	SET @NumeroRegistro2=IsNull((Select Top 1 NumeroRegistro From DetallePatronesGPS Where IdDetallePatronGPS=@IdDetallePatronGPS),0)

	UPDATE #Auxiliar1
	SET IdDetallePatronGPSFinal=@IdDetallePatronGPS, DistanciaAlPuntoFinal=@Distancia
	WHERE CURRENT OF Cur

	UPDATE #Auxiliar1
	SET NumeroRegistroInicial=@NumeroRegistro1, NumeroRegistroFinal=@NumeroRegistro2, 
		SumaDiferenciaDistancias=IsNull(DistanciaAlPuntoInicial,0)+IsNull(DistanciaAlPuntoFinal,0)
	WHERE CURRENT OF Cur

	--DETERMINAR RECORRIDO EN KM SUMANDO LAS DISTANCIAS DE LOS TRAMOS ENTRE LOS PUNTOS INICIAL Y FINAL ENCONTRADOS
	IF @NumeroRegistro1<=@NumeroRegistro2
		SET @DistanciaKmSuma=(Select Sum(IsNull(DistanciaKm,0)) 
					From DetallePatronesGPS 
					Where IdPatronGPS=@IdPatronGPS and NumeroRegistro between @NumeroRegistro1 and @NumeroRegistro2)
	ELSE
		SET @DistanciaKmSuma=(Select Sum(IsNull(DistanciaKm,0)) 
					From DetallePatronesGPS 
					Where IdPatronGPS=@IdPatronGPS and NumeroRegistro between @NumeroRegistro2 and @NumeroRegistro1)

	UPDATE #Auxiliar1
	SET DistanciaSegunPatron=@DistanciaKmSuma
	WHERE CURRENT OF Cur

	FETCH NEXT FROM Cur INTO @IdPatronGPS
    END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT * 
FROM #Auxiliar1
WHERE @Tolerancia=0 or SumaDiferenciaDistancias<=@Tolerancia
ORDER BY SumaDiferenciaDistancias 

DROP TABLE #Auxiliar1