
CREATE Procedure [dbo].[Subcontratos_TX_Ordenado]

@NumeroSubcontrato int,
@NumeroCertificado int, 
@TipoPartida int = Null

AS

SET NOCOUNT ON

SET @TipoPartida=IsNull(@TipoPartida,-1)

DECLARE @Profundidad int, @Nivel int, @Nivel1 int, @Pos int, @Orden varchar(50), @Orden1 varchar(50), @IdAux int, 
	@IdSubcontrato int, @IdNodoPadre int, @Depth int, @Lineage varchar(255), @Cantidad numeric(18,2), 
	@Importe numeric(18,2), @Descripcion varchar(255), @IdUnidad int, @IdNodoHijo int

SET @Profundidad=IsNull((Select Top 1 Max(IsNull(Depth,0)) From Subcontratos Where NumeroSubcontrato=@NumeroSubcontrato),0)
SET @Nivel=0

CREATE TABLE #Auxiliar1 
			(
			 IdSubcontrato INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 Descripcion VARCHAR(255),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,2),
			 IdUnidad INTEGER,
			 IdNodoHijo INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdNodoPadre, IdSubcontrato) ON [PRIMARY]
INSERT INTO #Auxiliar1 
 SELECT s.IdSubcontrato, s.IdNodoPadre, s.Depth, s.Lineage, s.Descripcion, s.Cantidad, s.Importe, s.IdUnidad, 
	(Select Top 1 s1.IdSubcontrato From Subcontratos s1
		Where s1.NumeroSubcontrato=@NumeroSubcontrato and Patindex('%/'+Convert(varchar,s.IdSubcontrato)+'/%', s1.Lineage)<>0)
 FROM Subcontratos s
 WHERE s.NumeroSubcontrato=@NumeroSubcontrato and (@TipoPartida=-1 or s.TipoPartida=@TipoPartida)

CREATE TABLE #Auxiliar2 
			(
			 IdSubcontrato INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 Descripcion VARCHAR(255),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,2),
			 IdUnidad INTEGER,
			 IdNodoHijo INTEGER,
			 Orden VARCHAR(50)
			)

WHILE @Nivel<=@Profundidad
    BEGIN
	SET @Pos=1
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdSubcontrato, IdNodoPadre, Depth, Lineage, Descripcion, Cantidad, Importe, IdUnidad, IdNodoHijo
			FROM #Auxiliar1
			WHERE Depth=@Nivel
			ORDER BY IdNodoPadre, IdSubcontrato
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdSubcontrato, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo
	WHILE @@FETCH_STATUS = 0
	    BEGIN
		SET @Orden1=Substring('000',1,3-Len(Convert(varchar,@Pos)))+Convert(varchar,@Pos)
		SET @IdAux=IsNull((Select Top 1 IdSubcontrato From Subcontratos Where IdSubcontrato=@IdNodoPadre),0)
		IF @IdAux=0 -- Nivel=0
		    BEGIN
			SET @Nivel1=@Nivel
			SET @Orden=@Orden1
			WHILE @Nivel1<=@Profundidad
			    BEGIN
				SET @Orden=@Orden+' 000'
				SET @Nivel1=@Nivel1+1
			    END
		    END
		ELSE
		    BEGIN
			SET @Orden=IsNull((Select Top 1 Orden From #Auxiliar2 Where IdSubcontrato=@IdAux),'')
			SET @Orden=Substring(@Orden,1,(@Nivel*4))+@Orden1+' '+Substring(@Orden,((@Nivel+1)*4)+1,50)
		    END

		INSERT INTO #Auxiliar2 
		 (IdSubcontrato, IdNodoPadre, Depth, Lineage, Descripcion, Cantidad, Importe, IdUnidad, IdNodoHijo, Orden)
		VALUES
		 (@IdSubcontrato, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo, @Orden)

		SET @Pos=@Pos+1
		FETCH NEXT FROM Cur INTO @IdSubcontrato, @IdNodoPadre, @Depth, @Lineage, @Descripcion, @Cantidad, @Importe, @IdUnidad, @IdNodoHijo
	    END
	CLOSE Cur
	DEALLOCATE Cur
	SET @Nivel=@Nivel+1
    END

UPDATE #Auxiliar2
SET Cantidad=Null, Importe=Null
WHERE IdNodoHijo is not Null

SET NOCOUNT OFF

SELECT #Auxiliar2.*, Unidades.Abreviatura as [Unidad], Subcontratos.Item as [Item], 
	(Select Top 1 PxQ.CantidadAvance From SubcontratosPxQ PxQ 
	 Where PxQ.IdSubcontrato=#Auxiliar2.IdSubcontrato and PxQ.NumeroCertificado=@NumeroCertificado) as [CantidadMes],
	(Select Top 1 PxQ.ImporteTotal From SubcontratosPxQ PxQ 
	 Where PxQ.IdSubcontrato=#Auxiliar2.IdSubcontrato and PxQ.NumeroCertificado=@NumeroCertificado) as [ImportedMes],
	(Select Sum(IsNull(PxQ.CantidadAvance,0)) From SubcontratosPxQ PxQ 
	 Where PxQ.IdSubcontrato=#Auxiliar2.IdSubcontrato and PxQ.NumeroCertificado<@NumeroCertificado) as [CantidadAcumuladaAnterior],
	(Select Sum(IsNull(PxQ.ImporteTotal,0)) From SubcontratosPxQ PxQ 
	 Where PxQ.IdSubcontrato=#Auxiliar2.IdSubcontrato and PxQ.NumeroCertificado<@NumeroCertificado) as [ImporteAcumuladoAnterior]
FROM #Auxiliar2
LEFT OUTER JOIN Subcontratos ON Subcontratos.IdSubcontrato=#Auxiliar2.IdSubcontrato
LEFT OUTER JOIN Unidades ON Unidades.IdUnidad=#Auxiliar2.IdUnidad
ORDER BY #Auxiliar2.Orden

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
