CREATE Procedure [dbo].[_TempCondicionesCompra_Generar]

AS

DECLARE @IdCondicionCompra int, @Dias int, @CantidadDias1 int, @CantidadDias2 int, @CantidadDias3 int, 
	@CantidadDias4 int, @CantidadDias5 int, @CantidadDias6 int, @CantidadDias7 int, @CantidadDias8 int, 
	@CantidadDias9 int, @CantidadDias10 int, @CantidadDias11 int, @CantidadDias12 int, @Porcentaje numeric(6,2), 
	@Porcentaje1 numeric(6,2), @Porcentaje2 numeric(6,2), @Porcentaje3 numeric(6,2), @Porcentaje4 numeric(6,2), 
	@Porcentaje5 numeric(6,2), @Porcentaje6 numeric(6,2), @Porcentaje7 numeric(6,2), @Porcentaje8 numeric(6,2), 
	@Porcentaje9 numeric(6,2), @Porcentaje10 numeric(6,2), @Porcentaje11 numeric(6,2), @Porcentaje12 numeric(6,2), 
	@Contador int

CREATE TABLE #Auxiliar1 
			(
			 IdCondicionCompra INTEGER,
			 CantidadDias1 INTEGER,
			 CantidadDias2 INTEGER,
			 CantidadDias3 INTEGER,
			 CantidadDias4 INTEGER,
			 CantidadDias5 INTEGER,
			 CantidadDias6 INTEGER,
			 CantidadDias7 INTEGER,
			 CantidadDias8 INTEGER,
			 CantidadDias9 INTEGER,
			 CantidadDias10 INTEGER,
			 CantidadDias11 INTEGER,
			 CantidadDias12 INTEGER,
			 Porcentaje1 NUMERIC(6, 2),
			 Porcentaje2 NUMERIC(6, 2),
			 Porcentaje3 NUMERIC(6, 2),
			 Porcentaje4 NUMERIC(6, 2),
			 Porcentaje5 NUMERIC(6, 2),
			 Porcentaje6 NUMERIC(6, 2),
			 Porcentaje7 NUMERIC(6, 2),
			 Porcentaje8 NUMERIC(6, 2),
			 Porcentaje9 NUMERIC(6, 2),
			 Porcentaje10 NUMERIC(6, 2),
			 Porcentaje11 NUMERIC(6, 2),
			 Porcentaje12 NUMERIC(6, 2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdCondicionCompra) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT IdCondicionCompra, CantidadDias1, CantidadDias2, CantidadDias3, CantidadDias4, CantidadDias5, 
	CantidadDias6, CantidadDias7, CantidadDias8, CantidadDias9, CantidadDias10, CantidadDias11, 
	CantidadDias12, Porcentaje1, Porcentaje2, Porcentaje3, Porcentaje4, Porcentaje5, Porcentaje6, 
	Porcentaje7, Porcentaje8, Porcentaje9, Porcentaje10, Porcentaje11, Porcentaje12
 FROM [Condiciones Compra] 

TRUNCATE TABLE _TempCondicionesCompra

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdCondicionCompra, CantidadDias1, CantidadDias2, CantidadDias3, CantidadDias4, CantidadDias5, 
			CantidadDias6, CantidadDias7, CantidadDias8, CantidadDias9, CantidadDias10, CantidadDias11, 
			CantidadDias12, Porcentaje1, Porcentaje2, Porcentaje3, Porcentaje4, Porcentaje5, Porcentaje6, 
			Porcentaje7, Porcentaje8, Porcentaje9, Porcentaje10, Porcentaje11, Porcentaje12
		FROM #Auxiliar1
		ORDER BY IdCondicionCompra 
OPEN Cur
FETCH NEXT FROM Cur INTO @IdCondicionCompra, @CantidadDias1, @CantidadDias2, @CantidadDias3, @CantidadDias4, @CantidadDias5, 
			@CantidadDias6, @CantidadDias7, @CantidadDias8, @CantidadDias9, @CantidadDias10, @CantidadDias11, 
			@CantidadDias12, @Porcentaje1, @Porcentaje2, @Porcentaje3, @Porcentaje4, @Porcentaje5, @Porcentaje6, 
			@Porcentaje7, @Porcentaje8, @Porcentaje9, @Porcentaje10, @Porcentaje11, @Porcentaje12
WHILE @@FETCH_STATUS = 0
    BEGIN
	IF IsNull(@Porcentaje1,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias1,0), @Porcentaje1)
	IF IsNull(@Porcentaje2,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias2,0), @Porcentaje2)
	IF IsNull(@Porcentaje3,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias3,0), @Porcentaje3)
	IF IsNull(@Porcentaje4,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias4,0), @Porcentaje4)
	IF IsNull(@Porcentaje5,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias5,0), @Porcentaje5)
	IF IsNull(@Porcentaje6,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias6,0), @Porcentaje6)
	IF IsNull(@Porcentaje7,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias7,0), @Porcentaje7)
	IF IsNull(@Porcentaje8,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias8,0), @Porcentaje8)
	IF IsNull(@Porcentaje9,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias9,0), @Porcentaje9)
	IF IsNull(@Porcentaje10,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias10,0), @Porcentaje10)
	IF IsNull(@Porcentaje11,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias11,0), @Porcentaje11)
	IF IsNull(@Porcentaje12,0)<>0
		INSERT INTO _TempCondicionesCompra (IdCondicionCompra, Dias, Porcentaje)
			VALUES (@IdCondicionCompra, IsNull(@CantidadDias12,0), @Porcentaje12)
	FETCH NEXT FROM Cur INTO @IdCondicionCompra, @CantidadDias1, @CantidadDias2, @CantidadDias3, @CantidadDias4, @CantidadDias5, 
				@CantidadDias6, @CantidadDias7, @CantidadDias8, @CantidadDias9, @CantidadDias10, @CantidadDias11, 
				@CantidadDias12, @Porcentaje1, @Porcentaje2, @Porcentaje3, @Porcentaje4, @Porcentaje5, @Porcentaje6, 
				@Porcentaje7, @Porcentaje8, @Porcentaje9, @Porcentaje10, @Porcentaje11, @Porcentaje12
    END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar1