CREATE Procedure [dbo].[PresupuestosVentas_ActualizarEstado]

@IdPresupuestoVenta int,
@IdFactura int, 
@IdDevolucion int = Null

AS 

SET NOCOUNT ON
SET ANSI_WARNINGS ON
SET ANSI_NULLS ON

SET @IdDevolucion=IsNull(@IdDevolucion,0)

DECLARE @ConsolidacionDeBDs varchar(2), @NombreServidorWeb varchar(100), @UsuarioServidorWeb varchar(50), @PasswordServidorWeb varchar(50), @BaseDeDatosServidorWeb varchar(50), 
		@sql1 nvarchar(4000), @IdDetallePresupuestoVenta int, @IdPresupuestoVenta1 int, @Registros int, @TipoOperacion varchar(1), @Estado varchar(1)

SET @ConsolidacionDeBDs=IsNull((Select Top 1 Valor From Parametros2 Where Campo='ConsolidacionDeBDs'),'NO')
SET @NombreServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='NombreServidorWeb'),'')
SET @UsuarioServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='UsuarioServidorWeb'),'')
SET @PasswordServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='PasswordServidorWeb'),'')
SET @BaseDeDatosServidorWeb=IsNull((Select Top 1 Valor From Parametros2 Where Campo='BaseDeDatosServidorWeb'),'')


CREATE TABLE #Auxiliar0 (Campo1 VARCHAR(50), Campo2 INTEGER)

CREATE TABLE #Auxiliar1 (IdPresupuestoVenta INTEGER)

IF LEN(@NombreServidorWeb)>0
  BEGIN
	IF @IdFactura>0
	  BEGIN
		SET @sql1='Select dpv.IdPresupuestoVenta 
					From DetalleFacturas df
					Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetallePresupuestosVentas dpv On dpv.IdDetallePresupuestoVenta = df.IdDetallePresupuestoVenta 
					Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas pv On pv.IdPresupuestoVenta = dpv.IdPresupuestoVenta 
					Where IsNull(dpv.IdPresupuestoVenta,0)>0 and df.IdFactura='+Convert(varchar,@IdFactura)
 		INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	  END

	IF @IdDevolucion>0
	  BEGIN
		SET @sql1='Select dpv.IdPresupuestoVenta 
					From DetalleDevoluciones dd
					Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetallePresupuestosVentas dpv On dpv.IdDetallePresupuestoVenta = dd.IdDetallePresupuestoVenta 
					Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas pv On pv.IdPresupuestoVenta = dpv.IdPresupuestoVenta 
					Where IsNull(dpv.IdPresupuestoVenta,0)>0 and dd.IdDevolucion='+Convert(varchar,@IdDevolucion)
 		INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	  END
  END
ELSE
  BEGIN
	IF @IdFactura>0
		INSERT INTO #Auxiliar1 
		 SELECT dpv.IdPresupuestoVenta
		 FROM DetalleFacturas df
		 LEFT OUTER JOIN DetallePresupuestosVentas dpv ON dpv.IdDetallePresupuestoVenta = df.IdDetallePresupuestoVenta
		 LEFT OUTER JOIN PresupuestosVentas ON PresupuestosVentas.IdPresupuestoVenta = dpv.IdPresupuestoVenta
		 WHERE IsNull(dpv.IdPresupuestoVenta,0)>0 and df.IdFactura=@IdFactura

	IF @IdDevolucion>0
		INSERT INTO #Auxiliar1 
		 SELECT dpv.IdPresupuestoVenta
		 FROM DetalleDevoluciones dd
		 LEFT OUTER JOIN DetallePresupuestosVentas dpv ON dpv.IdDetallePresupuestoVenta = dd.IdDetallePresupuestoVenta
		 LEFT OUTER JOIN PresupuestosVentas ON PresupuestosVentas.IdPresupuestoVenta = dpv.IdPresupuestoVenta
		 WHERE IsNull(dpv.IdPresupuestoVenta,0)>0 and dd.IdDevolucion=@IdDevolucion
  END

IF @IdPresupuestoVenta>0
	INSERT INTO #Auxiliar1 
	 SELECT @IdPresupuestoVenta

CREATE TABLE #Auxiliar2 (IdPresupuestoVenta INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar2 ON #Auxiliar2 (IdPresupuestoVenta) ON [PRIMARY]
INSERT INTO #Auxiliar2 
 SELECT #Auxiliar1.IdPresupuestoVenta
 FROM #Auxiliar1
 GROUP BY #Auxiliar1.IdPresupuestoVenta


CREATE TABLE #Auxiliar3 (IdDetallePresupuestoVenta INTEGER, IdPresupuestoVenta INTEGER, Cantidad NUMERIC(18,2), CantidadFacturada NUMERIC(18,2), Estado VARCHAR(1))
CREATE NONCLUSTERED INDEX IX__Auxiliar3 ON #Auxiliar3 (IdPresupuestoVenta) ON [PRIMARY]

IF LEN(@NombreServidorWeb)>0
  BEGIN
	SET @sql1='Select dpv.IdDetallePresupuestoVenta, a1.IdPresupuestoVenta, IsNull(dpv.Cantidad,0), IsNull(dbo.PresupuestosVentas_FacturadoPorIdDetalle(dpv.IdDetallePresupuestoVenta),0), IsNull(dpv.Estado,'+''''+''+''''+') 
				From #Auxiliar1 a1
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetallePresupuestosVentas dpv On dpv.IdPresupuestoVenta = a1.IdPresupuestoVenta 
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas pv On pv.IdPresupuestoVenta = a1.IdPresupuestoVenta 
				Where IsNull(pv.TipoOperacion,'+''''+'P'+''''+')='+''''+'P'+''''+' '
	INSERT INTO #Auxiliar3 EXEC sp_executesql @sql1
  END
ELSE
	INSERT INTO #Auxiliar3 
	 SELECT dpv.IdDetallePresupuestoVenta, a1.IdPresupuestoVenta, IsNull(dpv.Cantidad,0), IsNull(dbo.PresupuestosVentas_FacturadoPorIdDetalle(dpv.IdDetallePresupuestoVenta),0), IsNull(dpv.Estado,'')
	 FROM #Auxiliar1 a1
	 LEFT OUTER JOIN DetallePresupuestosVentas dpv ON dpv.IdPresupuestoVenta = a1.IdPresupuestoVenta
	 LEFT OUTER JOIN PresupuestosVentas pv ON pv.IdPresupuestoVenta = a1.IdPresupuestoVenta
	 WHERE IsNull(pv.TipoOperacion,'P')='P'


CREATE TABLE #Auxiliar4 (IdDetallePresupuestoVenta INTEGER, IdPresupuestoVenta INTEGER, IdDetalleDevolucion INTEGER)
CREATE NONCLUSTERED INDEX IX__Auxiliar4 ON #Auxiliar4 (IdPresupuestoVenta) ON [PRIMARY]

IF LEN(@NombreServidorWeb)>0
  BEGIN
	SET @sql1='Select dpv.IdDetallePresupuestoVenta, a1.IdPresupuestoVenta, IsNull((Select Top 1 dd.IdDetalleDevolucion From DetalleDevoluciones dd Where dd.IdDetallePresupuestoVenta=dpv.IdDetallePresupuestoVenta),0)
				From #Auxiliar1 a1
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.DetallePresupuestosVentas dpv On dpv.IdPresupuestoVenta = a1.IdPresupuestoVenta 
				Left Outer Join OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas pv On pv.IdPresupuestoVenta = a1.IdPresupuestoVenta 
				Where IsNull(pv.TipoOperacion,'+''''+'P'+''''+')='+''''+'D'+''''+' '
	INSERT INTO #Auxiliar4 EXEC sp_executesql @sql1
  END
ELSE
	INSERT INTO #Auxiliar4 
	 SELECT dpv.IdDetallePresupuestoVenta, a1.IdPresupuestoVenta, IsNull((Select Top 1 dd.IdDetalleDevolucion From DetalleDevoluciones dd Where dd.IdDetallePresupuestoVenta=dpv.IdDetallePresupuestoVenta),0)
	 FROM #Auxiliar1 a1 
	 LEFT OUTER JOIN DetallePresupuestosVentas dpv ON dpv.IdPresupuestoVenta = a1.IdPresupuestoVenta
	 LEFT OUTER JOIN PresupuestosVentas pv ON pv.IdPresupuestoVenta = a1.IdPresupuestoVenta
	 WHERE IsNull(pv.TipoOperacion,'P')='D'


DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR SELECT IdPresupuestoVenta FROM #Auxiliar2 ORDER BY IdPresupuestoVenta
OPEN Cur
FETCH NEXT FROM Cur INTO @IdPresupuestoVenta1
WHILE @@FETCH_STATUS = 0
  BEGIN
	IF LEN(@NombreServidorWeb)>0
	  BEGIN
		SET @sql1='Select Top 1 TipoOperacion, Null 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
				Where IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
		INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
		SET @TipoOperacion=IsNull((Select Top 1 Campo1 From #Auxiliar0),'P')

		SET @sql1='Select Top 1 Estado, Null 
				From OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
				Where IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
		INSERT INTO #Auxiliar0 EXEC sp_executesql @sql1
		SET @Estado=IsNull((Select Top 1 Campo1 From #Auxiliar0),'')
	  END
	ELSE
	  BEGIN
		SET @TipoOperacion=IsNull((Select Top 1 TipoOperacion From PresupuestosVentas Where IdPresupuestoVenta=@IdPresupuestoVenta1),'P')
		SET @Estado=IsNull((Select Top 1 Estado From PresupuestosVentas Where IdPresupuestoVenta=@IdPresupuestoVenta1),'')
	  END

	IF @TipoOperacion='P' and @Estado<>'A'
	  BEGIN
		SET @Registros=IsNull((Select Count(*) From #Auxiliar3 Where IdPresupuestoVenta=@IdPresupuestoVenta1 and Cantidad>CantidadFacturada and Estado<>'C'),0)
		IF @Registros=0
			IF LEN(@NombreServidorWeb)>0
			  BEGIN
				SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
							SET Estado='+''''+'C'+''''+' 
							WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
				EXEC sp_executesql @sql1
			  END
			ELSE
				UPDATE PresupuestosVentas
				SET Estado='C'
				WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
		ELSE
			IF IsNull((Select Count(*) From #Auxiliar3 Where IdPresupuestoVenta=@IdPresupuestoVenta1 and CantidadFacturada>0),0)>0
				IF LEN(@NombreServidorWeb)>0
				  BEGIN
					SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
								SET Estado='+''''+'P'+''''+' 
								WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
					EXEC sp_executesql @sql1
				  END
				ELSE
					UPDATE PresupuestosVentas
					SET Estado='P'
					WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
			ELSE
				IF LEN(@NombreServidorWeb)>0
				  BEGIN
					SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
								SET Estado=Null  
								WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
					EXEC sp_executesql @sql1
				  END
				ELSE
					UPDATE PresupuestosVentas
					SET Estado=Null
					WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
	  END
	ELSE
	  BEGIN
		IF @Estado<>'A'
		  BEGIN
			SET @Registros=IsNull((Select Count(*) From #Auxiliar4 Where IdPresupuestoVenta=@IdPresupuestoVenta1),0)
			IF @Registros>0
			   BEGIN
				SET @Registros=IsNull((Select Count(*) From #Auxiliar4 Where IdPresupuestoVenta=@IdPresupuestoVenta1 and IdDetalleDevolucion=0),-1)
				IF @Registros=0
					IF LEN(@NombreServidorWeb)>0
					  BEGIN
						SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
									SET Estado='+''''+'C'+''''+' 
									WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
						EXEC sp_executesql @sql1
					  END
					ELSE
						UPDATE PresupuestosVentas
						SET Estado='C'
						WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
				ELSE
					IF IsNull((Select Count(*) From #Auxiliar4 Where IdPresupuestoVenta=@IdPresupuestoVenta1 and IdDetalleDevolucion>0),0)>0
						IF LEN(@NombreServidorWeb)>0
						  BEGIN
							SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
										SET Estado='+''''+'P'+''''+' 
										WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
							EXEC sp_executesql @sql1
						  END
						ELSE
							UPDATE PresupuestosVentas
							SET Estado='P'
							WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
					ELSE
						IF LEN(@NombreServidorWeb)>0
						  BEGIN
							SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
										SET Estado=Null  
										WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
							EXEC sp_executesql @sql1
						  END
						ELSE
							UPDATE PresupuestosVentas
							SET Estado=Null
							WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
			   END
			ELSE
				IF LEN(@NombreServidorWeb)>0
				  BEGIN
					SET @sql1='UPDATE OPENDATASOURCE('+''''+'SQLOLEDB'+''''+','+''''+'Data Source='+@NombreServidorWeb+';User ID='+@UsuarioServidorWeb+';Password='+@PasswordServidorWeb+''+''''+').'+@BaseDeDatosServidorWeb+'.dbo.PresupuestosVentas 
								SET Estado=Null  
								WHERE IdPresupuestoVenta='+Convert(varchar,@IdPresupuestoVenta1)+' '
					EXEC sp_executesql @sql1
				  END
				ELSE
					UPDATE PresupuestosVentas
					SET Estado=Null
					WHERE IdPresupuestoVenta=@IdPresupuestoVenta1
		  END
	  END
	FETCH NEXT FROM Cur INTO @IdPresupuestoVenta1
  END
CLOSE Cur
DEALLOCATE Cur

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3
DROP TABLE #Auxiliar4

SET NOCOUNT OFF