CREATE  Procedure [dbo].[Proveedores_ImportarInformacionImpositiva2]

@Resolucion varchar(50), 
@Archivo varchar(500), 
@FechaLog datetime,
@Ciclo int

AS 

SET NOCOUNT ON

DECLARE @PathImportacionDatos varchar(200), @Campo varchar(500), @Aux varchar(50), @sql1 nvarchar(2000), @Separador varchar(1), @Pos int, @Cuit varchar(13), @IdProveedor int, 
		@IdCliente int, @Porcentaje numeric(6,2), @Fecha1 datetime, @Fecha2 datetime, @GrupoIIBB int, @Archivo1 nvarchar(1000), @IdAux int, @Importe numeric(18,2), 
		@Campo1 varchar(50), @Campo2 varchar(50), @Campo3 varchar(50), @Campo4 varchar(50), @Campo5 varchar(50), @Campo6 varchar(50), @Campo7 varchar(50), @Campo8 varchar(50), 
		@Campo9 varchar(50), @Campo10 varchar(50), @Campo11 varchar(50), @Campo12 varchar(50), @Campo13 varchar(50), @Campo14 varchar(50), @Campo15 varchar(50), 
		@RegistrosAProcesar int

SET @PathImportacionDatos=IsNull((Select Top 1 PathImportacionDatos From Parametros Where IdParametro=1),'C:\')

IF @Ciclo>1 and not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	RETURN
	
IF @Ciclo<=1 and exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[_TempInformacionImpositiva]

IF @Ciclo<=1 and exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[_TempInformacionImpositiva2]

IF @Ciclo<=1 and not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  BEGIN
	CREATE TABLE [dbo].[_TempInformacionImpositiva] (IdRegistro [int] IDENTITY (1, 1) NOT NULL, Campo varchar(1000)) ON [PRIMARY]
	ALTER TABLE [dbo].[_TempInformacionImpositiva] WITH NOCHECK ADD CONSTRAINT [PK_1] PRIMARY KEY  CLUSTERED (IdRegistro) WITH  FILLFACTOR = 90  ON [PRIMARY] 
  END
    
IF @Ciclo<=1 and not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva2]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
  BEGIN
	CREATE TABLE [dbo].[_TempInformacionImpositiva2] (Campo varchar(1000)) ON [PRIMARY]
  END
    
SET @sql1=''
SET @Separador=';'
IF @Ciclo<=1
  BEGIN
	IF @Resolucion='IIBB-7007'
	  BEGIN
		SET @Archivo1=@PathImportacionDatos+@Archivo
		SET @sql1='BULK INSERT _TempInformacionImpositiva2 FROM '+''''+@Archivo1+''''+'
					WITH (DATAFILETYPE = '+''''+'char'+''''+', FIELDTERMINATOR = '+''''+@Separador+''''+', ROWTERMINATOR = '''+CHAR(10)+''')'
	  END
	IF @Resolucion='RG17'
	  BEGIN
		SET @Archivo1='type '+@PathImportacionDatos+@Archivo
		INSERT _TempInformacionImpositiva 
		EXEC MASTER..xp_cmdshell @Archivo1
	  END
	IF @Resolucion='EMBARGO'
	  BEGIN
		UPDATE Proveedores
		SET SujetoEmbargado=Null, SaldoEmbargo=Null, DetalleEmbargo=Null

		SET @Archivo1='type '+@PathImportacionDatos+@Archivo
		INSERT _TempInformacionImpositiva 
		EXEC MASTER..xp_cmdshell @Archivo1
	  END
  END

IF Len(@sql1)>0 
	EXEC sp_executesql @sql1

IF @Resolucion='IIBB-7007'
  BEGIN
	SET @RegistrosAProcesar=100
	IF @Ciclo<=1
		INSERT INTO _TempInformacionImpositiva 
		 SELECT Campo FROM _TempInformacionImpositiva2
		 WHERE Exists(Select Top 1 IdProveedor From Proveedores Where Cuit COLLATE Modern_Spanish_CI_AS =Substring(Campo,30,2)+'-'+Substring(Campo,32,8)+'-'+Substring(Campo,40,1)) or 
				Exists(Select Top 1 IdCliente From Clientes Where Cuit COLLATE Modern_Spanish_CI_AS=Substring(Campo,30,2)+'-'+Substring(Campo,32,8)+'-'+Substring(Campo,40,1))
  END
ELSE
  BEGIN
	SET @RegistrosAProcesar=100
  END

CREATE TABLE #Auxiliar1 (IdAux int IDENTITY (1, 1) NOT NULL, Campo varchar(1000),
						 Campo1 varchar(50), Campo2 varchar(50), Campo3 varchar(50),Campo4 varchar(50), Campo5 varchar(50), 
						 Campo6 varchar(50), Campo7 varchar(50), Campo8 varchar(50), Campo9 varchar(50), Campo10 varchar(50), 
						 Campo11 varchar(50), Campo12 varchar(50), Campo13 varchar(50), Campo14 varchar(50), Campo15 varchar(50))
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdAux) ON [PRIMARY]

INSERT INTO #Auxiliar1 
 SELECT Campo, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null, Null 
 FROM _TempInformacionImpositiva
 WHERE IdRegistro>=((@Ciclo-1)*@RegistrosAProcesar)+1 and IdRegistro<=@Ciclo*@RegistrosAProcesar

/*  CURSOR  */
DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdAux, Campo FROM #Auxiliar1 ORDER BY IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @IdAux, @Campo
WHILE @@FETCH_STATUS = 0
  BEGIN
	-- IIBB-7007
	IF @Resolucion='IIBB-7007'
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
	  END

	-- RG17 / RG2226
	IF @Resolucion='RG17'
	  BEGIN
		UPDATE #Auxiliar1 SET Campo3 = Substring(@Campo,2,11), Campo4 = Ltrim(Rtrim(Substring(@Campo,104,5))), Campo5 = Substring(@Campo,75,10), Campo6 = Substring(@Campo,86,10), Campo7 = Substring(@Campo,110,10) WHERE IdAux=@IdAux
	  END

	-- EMBARGOS
	IF @Resolucion='EMBARGO'
	  BEGIN
		UPDATE #Auxiliar1 SET Campo3 = Substring(@Campo,9,11), Campo4 = Ltrim(Rtrim(Substring(@Campo,20,13))), Campo5 = Substring(@Campo,1,10) WHERE IdAux=@IdAux
	  END

	FETCH NEXT FROM Cur INTO @IdAux, @Campo
  END
CLOSE Cur
DEALLOCATE Cur

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT Campo1, Campo2, Campo3, Campo4, Campo5, Campo6, Campo7, Campo8, Campo9, Campo10, Campo11, Campo12, Campo13, Campo14, Campo15 FROM #Auxiliar1 ORDER BY IdAux
OPEN Cur
FETCH NEXT FROM Cur INTO @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14, @Campo15
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF @Resolucion='IIBB-7007'
	  BEGIN
		SET @Cuit=Substring(@Campo5,1,2)+'-'+Substring(@Campo5,3,8)+'-'+Substring(@Campo5,11,1)

		IF @Campo1='R'
		  BEGIN
			SET @IdProveedor=IsNull((Select Top 1 IdProveedor From Proveedores Where Cuit=@Cuit),0)
			IF @IdProveedor>0
			  BEGIN
				SET @Porcentaje=Convert(numeric(6,2),Replace(@Campo9,',','.'))
				SET @Fecha1=Convert(datetime,Substring(@Campo3,1,2)+'/'+Substring(@Campo3,3,2)+'/'+Substring(@Campo3,5,4),103)
				SET @Fecha2=Convert(datetime,Substring(@Campo4,1,2)+'/'+Substring(@Campo4,3,2)+'/'+Substring(@Campo4,5,4),103)
				SET @GrupoIIBB=Convert(integer,@Campo10)

				-- Esto es si existe mas de un proveedor con ese cuit
				UPDATE Proveedores 
				SET PorcentajeIBDirecto = @Porcentaje, FechaInicioVigenciaIBDirecto = @Fecha1, FechaFinVigenciaIBDirecto = @Fecha2, GrupoIIBB = @GrupoIIBB
				WHERE Cuit=@Cuit --IdProveedor=@IdProveedor

				INSERT INTO [LogImpuestos]
				(FechaProceso, ArchivoProcesado, IdProveedor,  PorcentajeIBDirecto, FechaInicioVigenciaIBDirecto, FechaFinVigenciaIBDirecto, GrupoIIBB)
				VALUES
				(@FechaLog, 'IIBB', @IdProveedor, @Porcentaje, @Fecha1, @Fecha2, @GrupoIIBB)
			  END
		  END

		IF @Campo1='P'
		  BEGIN
			SET @IdCliente=IsNull((Select TOp 1 IdCliente From Clientes Where Cuit=@Cuit),0)
			IF @IdCliente>0
			  BEGIN
				SET @Porcentaje=Convert(numeric(6,2),Replace(@Campo9,',','.'))
				SET @Fecha1=Convert(datetime,Substring(@Campo3,1,2)+'/'+Substring(@Campo3,3,2)+'/'+Substring(@Campo3,5,4),103)
				SET @Fecha2=Convert(datetime,Substring(@Campo4,1,2)+'/'+Substring(@Campo4,3,2)+'/'+Substring(@Campo4,5,4),103)
				SET @GrupoIIBB=Convert(integer,@Campo10)

				-- Esto es si existe mas de un cliente con ese cuit
				UPDATE Clientes 
				SET PorcentajeIBDirecto = @Porcentaje, FechaInicioVigenciaIBDirecto = @Fecha1, FechaFinVigenciaIBDirecto = @Fecha2, GrupoIIBB = @GrupoIIBB
				WHERE Cuit=@Cuit --IdCliente=@IdCliente

				INSERT INTO [LogImpuestos]
				(FechaProceso, ArchivoProcesado, IdCliente,  PorcentajeIBDirecto, FechaInicioVigenciaIBDirecto, FechaFinVigenciaIBDirecto, GrupoIIBB)
				VALUES
				(@FechaLog, 'IIBB', @IdCliente, @Porcentaje, @Fecha1, @Fecha2, @GrupoIIBB)
			  END
		  END
	  END

	IF @Resolucion='RG17'
	  BEGIN
		SET @Cuit=Substring(@Campo3,1,2)+'-'+Substring(@Campo3,3,8)+'-'+Substring(@Campo3,11,1)
		SET @IdProveedor=IsNull((Select Top 1 IdProveedor From Proveedores Where Cuit=@Cuit),0)
		IF @IdProveedor>0
		  BEGIN
			IF IsNull((Select Top 1 Eventual From Proveedores Where IdProveedor=@IdProveedor),'')<>'SI' and IsNull(@Campo7,'')<>'RG2238'
			  BEGIN
				SET @Porcentaje=Convert(numeric(6,2),Replace(@Campo4,',','.'))
				SET @Fecha1=Convert(datetime,@Campo5,103)
				SET @Fecha2=Convert(datetime,@Campo6,103)
	/*
				IF @Porcentaje=100
					UPDATE Proveedores 
					SET IvaExencionRetencion = 'SI', IvaPorcentajeExencion = Null, IvaFechaCaducidadExencion = @Fecha2
					WHERE IdProveedor=@IdProveedor
				ELSE
	*/
					UPDATE Proveedores 
					SET IvaExencionRetencion = 'NO', IvaPorcentajeExencion = @Porcentaje, IvaFechaInicioExencion = @Fecha1, IvaFechaCaducidadExencion = @Fecha2
					WHERE Cuit=@Cuit --IdProveedor=@IdProveedor

				INSERT INTO [LogImpuestos]
				(FechaProceso, ArchivoProcesado, IdProveedor,  IvaExencionRetencion, IvaPorcentajeExencion, IvaFechaCaducidadExencion)
				VALUES
				(@FechaLog, 'RG17', @IdProveedor, Case When @Porcentaje=100 Then 'SI' Else 'NO' End, Case When @Porcentaje=100 Then Null Else @Porcentaje End, @Fecha2)
			  END
		  END
	  END

	IF @Resolucion='EMBARGO'
	  BEGIN
		SET @Cuit=Substring(@Campo3,1,2)+'-'+Substring(@Campo3,3,8)+'-'+Substring(@Campo3,11,1)
		SET @IdProveedor=IsNull((Select Top 1 IdProveedor From Proveedores Where Cuit=@Cuit),0)
		IF @IdProveedor>0
		  BEGIN
			IF IsNull((Select Top 1 Eventual From Proveedores Where IdProveedor=@IdProveedor),'')<>'SI'
			  BEGIN
				SET @Importe=Convert(numeric(18,2),@Campo4) / 100
				SET @Aux=Substring(@Campo5,7,2)+'/'+Substring(@Campo5,5,2)+'/'+Substring(@Campo5,1,4)+' Rentas Bs.As.'

				UPDATE Proveedores 
				SET SujetoEmbargado = 'SI', SaldoEmbargo = @Importe, DetalleEmbargo = @Aux
				WHERE Cuit=@Cuit --IdProveedor=@IdProveedor
			  END
		  END
	  END

	FETCH NEXT FROM Cur INTO @Campo1, @Campo2, @Campo3, @Campo4, @Campo5, @Campo6, @Campo7, @Campo8, @Campo9, @Campo10, @Campo11, @Campo12, @Campo13, @Campo14, @Campo15
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

--select * from #Auxiliar1
DROP TABLE #Auxiliar1

/*
IF @Ciclo*100>=IsNull((Select Count(*) From _TempInformacionImpositiva),0)
	DROP TABLE _TempInformacionImpositiva
*/