




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_TransferirAnticiposAlSyJ]

@IdParametroLiquidacion int

AS 

SET NOCOUNT ON

Declare @BasePRONTOSyJAsociada varchar(50), @IdConceptoAnticiposSyJ int, @sql1 nvarchar(1000)
Set @BasePRONTOSyJAsociada=IsNull((Select Top 1 Parametros.BasePRONTOSyJAsociada 
					From Parametros Where Parametros.IdParametro=1),'')
Set @IdConceptoAnticiposSyJ=IsNull((Select Top 1 Parametros.IdConceptoAnticiposSyJ 
					From Parametros Where Parametros.IdParametro=1),0)

CREATE TABLE #Auxiliar0	(Identificador INTEGER)

CREATE TABLE #Auxiliar1 
			(
			 IdAnticipoAlPersonalSyJ INTEGER,
			 IdEmpleado INTEGER,
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT IdAnticipoAlPersonalSyJ, IdEmpleado, IsNull(Importe,0)
 FROM AnticiposAlPersonalSyJ
 WHERE (IdParametroLiquidacion is null or 
	IsNull(IdParametroLiquidacion,0)=@IdParametroLiquidacion) and 
	IsNull(Importe,0)>0

CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdEmpleado,IdAnticipoAlPersonalSyJ) ON [PRIMARY]

/*  CURSOR  */
DECLARE @IdAnticipoAlPersonalSyJ int, @IdEmpleado int, @Corte int, 
	@Importe numeric(18,2), @TotalImporte numeric(18,2), @IdLiquidacion int
SET @Corte=0
SET @TotalImporte=0
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdAnticipoAlPersonalSyJ, IdEmpleado, Importe
		FROM #Auxiliar1
		ORDER BY IdEmpleado
OPEN Cur
FETCH NEXT FROM Cur INTO @IdAnticipoAlPersonalSyJ, @IdEmpleado, @Importe
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF @Corte<>@IdEmpleado
	   BEGIN
		IF @Corte<>0
		   BEGIN
			SET @sql1='Select IdLiquidacion 
				   From '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
				   Where IdParametroLiquidacion='+Convert(varchar,@IdParametroLiquidacion)+' and 
					 IdEmpleado='+Convert(varchar,@IdEmpleado)+' and 
					 IdConcepto='+Convert(varchar,@IdConceptoAnticiposSyJ)
			TRUNCATE TABLE #Auxiliar0
			INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
			SET @IdLiquidacion=IsNull((Select Top 1 #Auxiliar0.Identificador From #Auxiliar0),0)
			IF @IdLiquidacion=0
			   BEGIN
				SET @sql1='Insert Into '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
						(IdParametroLiquidacion, IdEmpleado, IdConcepto, Importe)
						Values 
						('+Convert(varchar,@IdParametroLiquidacion)+', 
						 '+Convert(varchar,@IdEmpleado)+', 
						 '+Convert(varchar,@IdConceptoAnticiposSyJ)+', 
						 '+Convert(varchar,@TotalImporte)+') 
					   Select @@identity'
				TRUNCATE TABLE #Auxiliar0
				INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
				SET @IdLiquidacion=IsNull((Select Top 1 #Auxiliar0.Identificador From #Auxiliar0),0)
				UPDATE AnticiposAlPersonalSyJ
				SET IdParametroLiquidacion=@IdParametroLiquidacion
				WHERE IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ
			   END
			ELSE
			   BEGIN
				SET @sql1='Update '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
					   Set Importe='+Convert(varchar,@TotalImporte)+' 
					   Where IdLiquidacion='+Convert(varchar,@IdLiquidacion)
				EXEC sp_executesql @sql1
				UPDATE AnticiposAlPersonalSyJ
				SET IdParametroLiquidacion=@IdParametroLiquidacion
				WHERE IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ
			   END
		   END
		SET @TotalImporte=0
		SET @Corte=@IdEmpleado
	   END
	SET @TotalImporte=@TotalImporte + @Importe
	FETCH NEXT FROM Cur INTO @IdAnticipoAlPersonalSyJ, @IdEmpleado, @Importe
   END
IF @Corte<>0
   BEGIN
	SET @sql1='Select IdLiquidacion 
		   From '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
		   Where IdParametroLiquidacion='+Convert(varchar,@IdParametroLiquidacion)+' and 
			 IdEmpleado='+Convert(varchar,@IdEmpleado)+' and 
			 IdConcepto='+Convert(varchar,@IdConceptoAnticiposSyJ)
	TRUNCATE TABLE #Auxiliar0
	INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
	SET @IdLiquidacion=IsNull((Select Top 1 #Auxiliar0.Identificador From #Auxiliar0),0)
	IF @IdLiquidacion=0
	   BEGIN
		SET @sql1='Insert Into '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
				(IdParametroLiquidacion, IdEmpleado, IdConcepto, Importe)
				Values 
				('+Convert(varchar,@IdParametroLiquidacion)+', 
				 '+Convert(varchar,@IdEmpleado)+', 
				 '+Convert(varchar,@IdConceptoAnticiposSyJ)+', 
				 '+Convert(varchar,@TotalImporte)+') 
			   Select @@identity'
		TRUNCATE TABLE #Auxiliar0
		INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
		SET @IdLiquidacion=IsNull((Select Top 1 #Auxiliar0.Identificador From #Auxiliar0),0)
		UPDATE AnticiposAlPersonalSyJ
		SET IdParametroLiquidacion=@IdParametroLiquidacion
		WHERE IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ
	   END
	ELSE
	   BEGIN
		SET @sql1='Update '+@BasePRONTOSyJAsociada+'.dbo.Liquidaciones 
			   Set Importe='+Convert(varchar,@TotalImporte)+' 
			   Where IdLiquidacion='+Convert(varchar,@IdLiquidacion)
		EXEC sp_executesql @sql1
		UPDATE AnticiposAlPersonalSyJ
		SET IdParametroLiquidacion=@IdParametroLiquidacion
		WHERE IdAnticipoAlPersonalSyJ=@IdAnticipoAlPersonalSyJ
	   END
   END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1

SET NOCOUNT OFF




