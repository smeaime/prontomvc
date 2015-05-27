CREATE  Procedure [dbo].[Proveedores_ImportarInformacionImpositiva]

@Resolucion varchar(50), 
@Archivo varchar(500), 
@FechaLog datetime

AS 

SET NOCOUNT ON

-- RG 830

DECLARE @PathImportacionDatos varchar(200), @Campo varchar(500), @Aux varchar(50), @sql1 nvarchar(2000), @Separador varchar(1), @Pos int, 
		@Cuit varchar(13), @IdProveedor int, @IGCondicion int, @FechaLimiteExentoGanancias datetime, 
		@Campo1 varchar(50), @Campo2 varchar(50), @Campo3 varchar(50), @Campo4 varchar(50), @Campo5 varchar(50), 
		@Campo6 varchar(50), @Campo7 varchar(50), @Campo8 varchar(50), @Campo9 varchar(50), @Campo10 varchar(50), 
		@Campo11 varchar(50), @Campo12 varchar(50), @Campo13 varchar(50), @Campo14 varchar(50), @Campo15 varchar(50)

SET @PathImportacionDatos=IsNull((Select Top 1 PathImportacionDatos From Parametros Where IdParametro=1),'C:\')

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[_TempInformacionImpositiva]

IF not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	CREATE TABLE [dbo].[_TempInformacionImpositiva] (Campo varchar(1000)) ON [PRIMARY]
    
SET @Separador=';'
SET @sql1='BULK INSERT _TempInformacionImpositiva FROM '+''''+@PathImportacionDatos+@Archivo+''''+'
			WITH (DATAFILETYPE = '+''''+'char'+''''+', FIELDTERMINATOR = '+''''+';'+''''+', ROWTERMINATOR = '''+CHAR(10)+''')'
EXEC sp_executesql @sql1

CREATE TABLE #Auxiliar1 (IdAux int IDENTITY (1, 1) NOT NULL, Campo varchar(1000),
						 Campo1 varchar(50), Campo2 varchar(50), Campo3 varchar(50),Campo4 varchar(50), Campo5 varchar(50), 
						 Campo6 varchar(50), Campo7 varchar(50), Campo8 varchar(50), Campo9 varchar(50), Campo10 varchar(50), 
						 Campo11 varchar(50), Campo12 varchar(50), Campo13 varchar(50), Campo14 varchar(50), Campo15 varchar(50))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdAux) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT Campo, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null 
 FROM _TempInformacionImpositiva

/*  CURSOR  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Campo FROM #Auxiliar1 ORDER BY IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @Campo
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @Pos=1
	WHILE @Pos>0
	  BEGIN
		IF PATINDEX('%'+@Separador+'%', @Campo)>0
			SET @Aux=Substring(@Campo,1,PATINDEX('%'+@Separador+'%', @Campo)-1)
		ELSE
			SET @Aux=Rtrim(@Campo)

		SET @Aux=Replace(@Aux,Char(13),'')

		IF @Pos=1 UPDATE #Auxiliar1 SET Campo1 = @Aux WHERE CURRENT OF Cur
		IF @Pos=2 UPDATE #Auxiliar1 SET Campo2 = @Aux WHERE CURRENT OF Cur
		IF @Pos=3 UPDATE #Auxiliar1 SET Campo3 = @Aux WHERE CURRENT OF Cur
		IF @Pos=4 UPDATE #Auxiliar1 SET Campo4 = @Aux WHERE CURRENT OF Cur
		IF @Pos=5 UPDATE #Auxiliar1 SET Campo5 = @Aux WHERE CURRENT OF Cur
		IF @Pos=6 UPDATE #Auxiliar1 SET Campo6 = @Aux WHERE CURRENT OF Cur
		IF @Pos=7 UPDATE #Auxiliar1 SET Campo7 = @Aux WHERE CURRENT OF Cur
		IF @Pos=8 UPDATE #Auxiliar1 SET Campo8 = @Aux WHERE CURRENT OF Cur
		IF @Pos=9 UPDATE #Auxiliar1 SET Campo9 = @Aux WHERE CURRENT OF Cur
		IF @Pos=10 UPDATE #Auxiliar1 SET Campo10 = @Aux WHERE CURRENT OF Cur
		IF @Pos=11 UPDATE #Auxiliar1 SET Campo11 = @Aux WHERE CURRENT OF Cur
		IF @Pos=12 UPDATE #Auxiliar1 SET Campo12 = @Aux WHERE CURRENT OF Cur
		IF @Pos=13 UPDATE #Auxiliar1 SET Campo13 = @Aux WHERE CURRENT OF Cur
		IF @Pos=14 UPDATE #Auxiliar1 SET Campo14 = @Aux WHERE CURRENT OF Cur
		IF @Pos=15 UPDATE #Auxiliar1 SET Campo15 = @Aux WHERE CURRENT OF Cur

		IF PATINDEX('%'+@Separador+'%', @Campo)>0
			SET @Campo=Substring(@Campo,PATINDEX('%'+@Separador+'%', @Campo)+1,1000)
		ELSE
			BREAK
		SET @Pos=@Pos+1
	  END
	FETCH NEXT FROM Cur INTO @Campo
  END
CLOSE Cur
DEALLOCATE Cur

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
	SELECT Campo1, Campo2, Campo3, Campo4, Campo5, Campo6, Campo7, Campo8, Campo9, Campo10, Campo11, Campo12, Campo13, Campo14, Campo15
	FROM #Auxiliar1 ORDER BY IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14, @Campo15
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @Cuit=Substring(@Campo2,1,2)+'-'+Substring(@Campo2,3,8)+'-'+Substring(@Campo2,11,1)
	SET @IdProveedor=IsNull((Select TOp 1 IdProveedor From Proveedores Where Cuit=@Cuit),0)
	IF @IdProveedor>0
	  BEGIN
		IF Convert(int,@Campo4)=100
		  BEGIN
			SET @IGCondicion=1
			SET @FechaLimiteExentoGanancias=Convert(datetime,Substring(@Campo10,1,10),103)
		  END
		ELSE
		  BEGIN
			SET @IGCondicion=2
			SET @FechaLimiteExentoGanancias=Null
		  END

		UPDATE Proveedores SET IGCondicion=@IGCondicion, FechaLimiteExentoGanancias=@FechaLimiteExentoGanancias
		WHERE Cuit=@Cuit

		INSERT INTO [LogImpuestos]
		(FechaProceso, ArchivoProcesado, IdProveedor, IGCondicion, FechaLimiteExentoGanancias)
		VALUES
		(@FechaLog, @Resolucion, @IdProveedor, @IGCondicion, @FechaLimiteExentoGanancias)
	  END

	FETCH NEXT FROM Cur INTO @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14, @Campo15
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

DROP TABLE #Auxiliar1

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[_TempInformacionImpositiva]