
CREATE Procedure [dbo].[Subcontratos_Recalcular]

@NumeroSubcontrato int

AS

SET NOCOUNT ON

DECLARE @Profundidad int, @PrimeraVuelta bit, @IdSubcontrato int, @IdNodoPadre int, @Depth int, @Lineage varchar(255), @Cantidad numeric(18,2), @Importe numeric(18,2), 
	@Corte varchar(255), @UltimoIdNodoPadre int, @ImporteCalculo numeric(18,2)

SET @Profundidad=IsNull((Select Top 1 Max(IsNull(Depth,0)) From Subcontratos Where NumeroSubcontrato=@NumeroSubcontrato),0)
SET @PrimeraVuelta=0

UPDATE Subcontratos
SET Importe=0
WHERE Subcontratos.NumeroSubcontrato=@NumeroSubcontrato and 
	Exists(Select Top 1 CO.IdSubcontrato From Subcontratos CO
		Where CO.NumeroSubcontrato=@NumeroSubcontrato and Patindex('%/'+Convert(varchar,Subcontratos.IdSubcontrato)+'/%', CO.Lineage)<>0)

CREATE TABLE #Auxiliar1 
			(
			 IdSubcontrato INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Depth Desc, Lineage, IdSubcontrato) ON [PRIMARY]

WHILE @Profundidad >= 0
   BEGIN
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT CO.IdSubcontrato, CO.IdNodoPadre, CO.Depth, CO.Lineage, CO.Cantidad, CO.Importe
	 FROM Subcontratos CO
	 WHERE CO.NumeroSubcontrato=@NumeroSubcontrato and 
		(Not Exists(Select Top 1 CO1.IdSubcontrato From Subcontratos CO1
				Where CO1.NumeroSubcontrato=@NumeroSubcontrato and Patindex('%/'+Convert(varchar,CO.IdSubcontrato)+'/%', CO1.Lineage)<>0) or @PrimeraVuelta=1)
	 ORDER BY CO.Depth Desc, CO.Lineage, CO.IdSubcontrato
	
	/*  CURSOR  */
	SET @Corte=''
	SET @UltimoIdNodoPadre=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdSubcontrato, IdNodoPadre, Depth, Lineage, Cantidad, Importe
			FROM #Auxiliar1
			ORDER BY Depth Desc, Lineage, IdSubcontrato
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdSubcontrato, @IdNodoPadre, @Depth, @Lineage, @Cantidad, @Importe
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		IF @Corte<>@Lineage
		   BEGIN
			IF @Corte<>''
			   BEGIN
				UPDATE Subcontratos
				SET Importe = Round(@ImporteCalculo / Cantidad,2)
				WHERE IdSubcontrato=@UltimoIdNodoPadre and IsNull(Cantidad,0)<>0
			   END
			SET @UltimoIdNodoPadre=@IdNodoPadre
			SET @ImporteCalculo=0
			SET @Corte=@Lineage
		   END
		SET @ImporteCalculo=@ImporteCalculo + (IsNull(@Cantidad,0)*IsNull(@Importe,0))
		FETCH NEXT FROM Cur INTO @IdSubcontrato, @IdNodoPadre, @Depth, @Lineage, @Cantidad, @Importe
	   END
	   IF @Corte<>''
	      BEGIN
		UPDATE Subcontratos
		SET Importe = Round(@ImporteCalculo / Cantidad,2)
		WHERE IdSubcontrato=@UltimoIdNodoPadre and IsNull(Cantidad,0)<>0
	      END
	CLOSE Cur
	DEALLOCATE Cur

	SET @Profundidad=@Profundidad-1
	SET @PrimeraVuelta=1
   END

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
