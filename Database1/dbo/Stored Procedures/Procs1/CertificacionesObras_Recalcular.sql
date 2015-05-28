CREATE Procedure [dbo].[CertificacionesObras_Recalcular]

@NumeroProyecto int

AS

SET NOCOUNT ON

DECLARE @Profundidad int, @Profundidad1 int, @PrimeraVuelta bit, 
	@IdCertificacionObras int, @IdNodoPadre int, @Depth int, @Lineage varchar(255), @UnidadAvance varchar(1), @Cantidad numeric(18,2), 
	@Importe numeric(18,4), @Corte varchar(255), @UltimoIdNodoPadre int, @ImporteCalculo numeric(18,4), 
	@IdCertificacionObrasPxQ int, @Mes int, @Año int, @Cantidad1 numeric(18,2), @Importe1 numeric(18,4), @CantidadAvance numeric(18,2), 
	@ImporteAvance numeric(18,4)

SET @Profundidad1=IsNull((Select Top 1 Max(IsNull(Depth,0)) From CertificacionesObras Where NumeroProyecto=@NumeroProyecto),0)
SET @PrimeraVuelta=0

UPDATE CertificacionesObras
SET Importe=0
WHERE CertificacionesObras.NumeroProyecto=@NumeroProyecto and 
	Exists(Select Top 1 CO.IdCertificacionObras From CertificacionesObras CO
		Where CO.NumeroProyecto=@NumeroProyecto and Patindex('%/'+Convert(varchar,CertificacionesObras.IdCertificacionObras)+'/%', CO.Lineage)<>0)

CREATE TABLE #Auxiliar1 
			(
			 IdCertificacionObras INTEGER,
			 IdNodoPadre INTEGER,
			 Depth INTEGER,
			 Lineage VARCHAR(255),
			 UnidadAvance VARCHAR(1),
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (Depth Desc, Lineage, IdCertificacionObras) ON [PRIMARY]

CREATE TABLE #Auxiliar2 
			(
			 Mes INTEGER,
			 Año INTEGER,
			 Cantidad NUMERIC(18,2),
			 Importe NUMERIC(18,4),
			 CantidadAvance NUMERIC(18,2),
			 ImporteAvance NUMERIC(18,4)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (Mes, Año) ON [PRIMARY]

--CALCULAR PRESUPUESTOS TOTALES
SET @Profundidad=@Profundidad1
WHILE @Profundidad >= 0
   BEGIN
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT CO.IdCertificacionObras, CO.IdNodoPadre, CO.Depth, CO.Lineage, CO.UnidadAvance, CO.Cantidad, CO.Importe
	 FROM CertificacionesObras CO
	 WHERE CO.NumeroProyecto=@NumeroProyecto and 
		(Not Exists(Select Top 1 CO1.IdCertificacionObras From CertificacionesObras CO1
				Where CO1.NumeroProyecto=@NumeroProyecto and Patindex('%/'+Convert(varchar,CO.IdCertificacionObras)+'/%', CO1.Lineage)<>0) or @PrimeraVuelta=1)
	 ORDER BY CO.Depth Desc, CO.Lineage, CO.IdCertificacionObras
	
	/*  CURSOR  */
	SET @Corte=''
	SET @UltimoIdNodoPadre=0
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdCertificacionObras, IdNodoPadre, Depth, Lineage, UnidadAvance, Cantidad, Importe
			FROM #Auxiliar1
			ORDER BY Depth Desc, Lineage, IdCertificacionObras
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @UnidadAvance, @Cantidad, @Importe
	WHILE @@FETCH_STATUS = 0
	   BEGIN
		IF @Corte<>@Lineage
		   BEGIN
			IF @Corte<>''
			   BEGIN
				UPDATE CertificacionesObras
				SET Importe = Round(@ImporteCalculo / Cantidad,4)
				WHERE IdCertificacionObras=@UltimoIdNodoPadre and IsNull(Cantidad,0)<>0
			   END
			SET @UltimoIdNodoPadre=@IdNodoPadre
			SET @ImporteCalculo=0
			SET @Corte=@Lineage
		   END
		SET @ImporteCalculo=@ImporteCalculo + (IsNull(@Cantidad,0)*IsNull(@Importe,0))
		FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @UnidadAvance, @Cantidad, @Importe
	   END
	   IF @Corte<>''
	      BEGIN
		UPDATE CertificacionesObras
		SET Importe = Round(@ImporteCalculo / Cantidad,4)
		WHERE IdCertificacionObras=@UltimoIdNodoPadre and IsNull(Cantidad,0)<>0
	      END
	CLOSE Cur
	DEALLOCATE Cur

	SET @Profundidad=@Profundidad-1
	SET @PrimeraVuelta=1
   END

--CALCULAR LOS PRESUPUESTOS Y AVANCES EN BASE A LOS NIVELES INFERIORES
SET @Profundidad=@Profundidad1
WHILE @Profundidad >= 0
   BEGIN
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 
	 SELECT CO.IdCertificacionObras, CO.IdNodoPadre, CO.Depth, CO.Lineage, CO.UnidadAvance, CO.Cantidad, CO.Importe
	 FROM CertificacionesObras CO
	 WHERE CO.NumeroProyecto=@NumeroProyecto and CO.Depth=@Profundidad
	 ORDER BY CO.IdCertificacionObras
--select @Profundidad as [Profundidad],* from #Auxiliar1

	/*  CURSOR  */
	DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
		FOR	SELECT IdCertificacionObras, IdNodoPadre, Depth, Lineage, UnidadAvance, Cantidad, Importe
			FROM #Auxiliar1
			ORDER BY IdCertificacionObras
	OPEN Cur
	FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @UnidadAvance, @Cantidad, @Importe
	WHILE @@FETCH_STATUS = 0
	   BEGIN
--select @IdCertificacionObras as [IdCertificacionObras]
		IF Exists(Select Top 1 IdCertificacionObras From CertificacionesObras Where IdNodoPadre=@IdCertificacionObras)
		   BEGIN
			UPDATE CertificacionesObrasPxQ
			SET Importe=Null, Cantidad=Null, ImporteAvance=Null, CantidadAvance=Null
			WHERE IdCertificacionObras=@IdCertificacionObras

			TRUNCATE TABLE #Auxiliar2
			INSERT INTO #Auxiliar2 
			 SELECT Det.Mes, Det.Año, Sum(IsNull(Det.Cantidad,0)), Sum(IsNull(Det.Importe,0)), 
				Sum(IsNull(Det.CantidadAvance,0)), Sum(IsNull(Det.ImporteAvance,0))
			 FROM CertificacionesObrasPxQ Det
			 LEFT OUTER JOIN CertificacionesObras co ON co.IdCertificacionObras=Det.IdCertificacionObras
			 WHERE IsNull(co.IdNodoPadre,0)=@IdCertificacionObras
			 GROUP BY Det.Mes, Det.Año
--select @IdCertificacionObras as [IdCertificacionObras], * from #Auxiliar2
			DECLARE Cur1 CURSOR LOCAL FORWARD_ONLY 
				FOR	SELECT Mes, Año, Cantidad, Importe, CantidadAvance, ImporteAvance
					FROM #Auxiliar2
					ORDER BY Mes, Año
			OPEN Cur1
			FETCH NEXT FROM Cur1 INTO @Mes, @Año, @Cantidad1, @Importe1, @CantidadAvance, @ImporteAvance
			WHILE @@FETCH_STATUS = 0
			   BEGIN
				SET @IdCertificacionObrasPxQ=IsNull((Select Top 1 IdCertificacionObrasPxQ From CertificacionesObrasPxQ
									Where IdCertificacionObras=@IdCertificacionObras and Mes=@Mes and Año=@Año),0)
				IF IsNull(@UnidadAvance,'')='%'
				   BEGIN
					SET @ImporteCalculo=(IsNull(@Cantidad,0)*IsNull(@Importe,0))
--select @IdCertificacionObras as [IdCertificacionObras], @Mes, @Año, @Cantidad1, @Importe1, @CantidadAvance, @ImporteAvance, @ImporteCalculo
					SET @Cantidad1=0
					SET @CantidadAvance=0
					IF @ImporteCalculo<>0
					   BEGIN
						SET @Cantidad1=(@Importe1/@ImporteCalculo*100)
						SET @CantidadAvance=(@ImporteAvance/@ImporteCalculo*100)
					   END
				   END
				IF @IdCertificacionObrasPxQ=0
				   BEGIN
					INSERT INTO [CertificacionesObrasPxQ]
					(IdCertificacionObras, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance)
					VALUES
					(@IdCertificacionObras, @Mes, @Año, 
					 Case When @Importe1>0 Then @Importe1 Else Null End, 
					 Case When @Cantidad1>0 Then @Cantidad1 Else Null End,  
					 Case When @ImporteAvance>0 Then @ImporteAvance Else Null End, 
					 Case When @CantidadAvance>0 Then @CantidadAvance Else Null End)
				   END
				ELSE
				   BEGIN
					UPDATE CertificacionesObrasPxQ
					SET Importe=Case When @Importe1>=0 Then @Importe1 Else Importe End,
						Cantidad=Case When @Cantidad1>=0 Then @Cantidad1 Else Cantidad End,
						ImporteAvance=Case When @ImporteAvance>=0 Then @ImporteAvance Else ImporteAvance End,
						CantidadAvance=Case When @CantidadAvance>=0 Then @CantidadAvance Else CantidadAvance End
					WHERE IdCertificacionObrasPxQ=@IdCertificacionObrasPxQ
				   END
				FETCH NEXT FROM Cur1 INTO @Mes, @Año, @Cantidad1, @Importe1, @CantidadAvance, @ImporteAvance
			   END
			CLOSE Cur1
			DEALLOCATE Cur1
		   END
		ELSE
		   BEGIN
			IF IsNull(@UnidadAvance,'')='%'
			   BEGIN
				UPDATE CertificacionesObrasPxQ
				SET Importe=Cantidad/100*(@Cantidad*@Importe), ImporteAvance=CantidadAvance/100*(@Cantidad*@Importe)
				WHERE IdCertificacionObras=@IdCertificacionObras
			   END
			ELSE
			   BEGIN
				UPDATE CertificacionesObrasPxQ
				SET Importe=Cantidad*(@Cantidad*@Importe), ImporteAvance=CantidadAvance*(@Cantidad*@Importe)
				WHERE IdCertificacionObras=@IdCertificacionObras
			   END
		   END
		FETCH NEXT FROM Cur INTO @IdCertificacionObras, @IdNodoPadre, @Depth, @Lineage, @UnidadAvance, @Cantidad, @Importe
	   END
	CLOSE Cur
	DEALLOCATE Cur

	SET @Profundidad=@Profundidad-1
	SET @PrimeraVuelta=1
   END

SET NOCOUNT OFF

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
