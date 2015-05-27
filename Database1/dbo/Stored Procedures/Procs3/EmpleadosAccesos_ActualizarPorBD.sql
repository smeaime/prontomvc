CREATE Procedure [dbo].[EmpleadosAccesos_ActualizarPorBD]

@BDBase as varchar(50),
@BD as varchar(50),
@IdEmpleadoAcceso int,
@IdEmpleado int,
@Nodo varchar(50),
@Acceso bit,
@Nivel int,
@FechaDesdeParaModificacion datetime,
@FechaInicialHabilitacion datetime,
@FechaFinalHabilitacion datetime,
@CantidadAccesos int,
@IdUsuarioModifico int

AS

SET NOCOUNT ON

DECLARE @sql1 nvarchar(1000), @UsuarioNT varchar(50), @UsuarioNTUsuarioModifico varchar(50)

CREATE TABLE #Auxiliar (IdAux INTEGER)

CREATE TABLE #Auxiliar1 (Aux VARCHAR(50))

SET @sql1='Select Top 1 emp.UsuarioNT From ['+@BDBase+'].dbo.Empleados emp Where emp.IdEmpleado='+Convert(varchar,@IdUsuarioModifico)
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
SET @UsuarioNTUsuarioModifico=IsNull((Select Top 1 Aux From #Auxiliar1),'')

IF @BDBase<>@BD
    BEGIN
	SET @sql1='Select Top 1 emp.UsuarioNT From ['+@BDBase+'].dbo.Empleados emp Where emp.IdEmpleado='+Convert(varchar,@IdEmpleado)
	TRUNCATE TABLE #Auxiliar1
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	SET @UsuarioNT=IsNull((Select Top 1 Aux From #Auxiliar1),'')

	SET @sql1='Select Top 1 emp.IdEmpleado From ['+@BD+'].dbo.Empleados emp Where emp.UsuarioNT='+''''+@UsuarioNT+''''
	TRUNCATE TABLE #Auxiliar
	INSERT INTO #Auxiliar EXEC sp_executesql @sql1
	SET @IdEmpleado=IsNull((Select Top 1 IdAux From #Auxiliar),0)

	SET @sql1='Select Top 1 emp.IdEmpleadoAcceso From ['+@BD+'].dbo.EmpleadosAccesos emp Where emp.IdEmpleado='+Convert(varchar,@IdEmpleado)+' and emp.Nodo='+''''+@Nodo+''''
	TRUNCATE TABLE #Auxiliar
	INSERT INTO #Auxiliar EXEC sp_executesql @sql1
	SET @IdEmpleadoAcceso=IsNull((Select Top 1 IdAux From #Auxiliar),0)

	SET @IdUsuarioModifico=0
    END

IF @IdEmpleado<>0
	IF @IdEmpleadoAcceso<=0
	    BEGIN
		SET @sql1='Insert Into ['+@BD+'].dbo.EmpleadosAccesos 
				(IdEmpleado, Nodo, Acceso, Nivel, FechaDesdeParaModificacion, FechaInicialHabilitacion, FechaFinalHabilitacion, CantidadAccesos, FechaUltimaModificacion, IdUsuarioModifico, UsuarioNTUsuarioModifico)
				Values 
				('+Convert(varchar,@IdEmpleado)+', 
				 '''+@Nodo+''', 
				 '+Convert(varchar,@Acceso)+', 
				 '+Convert(varchar,@Nivel)+', 
				 '+Case When @FechaDesdeParaModificacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaDesdeParaModificacion,103)+''',103)' End+', 
				 '+Case When @FechaInicialHabilitacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaInicialHabilitacion,103)+''',103)' End+', 
				 '+Case When @FechaFinalHabilitacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaFinalHabilitacion,103)+''',103)' End+', 
				 '+Case When @CantidadAccesos is null Then 'Null' Else Convert(varchar,@CantidadAccesos) End+', GetDate(), '+Convert(varchar,@IdUsuarioModifico)+', '''+@UsuarioNTUsuarioModifico+''')
				Select @@identity'
		TRUNCATE TABLE #Auxiliar
		INSERT INTO #Auxiliar EXEC sp_executesql @sql1
		SET @IdEmpleadoAcceso=IsNull((Select Top 1 IdAux From #Auxiliar),0)
	    END
	ELSE
	    BEGIN
		SET @sql1='Update ['+@BD+'].dbo.EmpleadosAccesos 
				Set IdEmpleado='+Convert(varchar,@IdEmpleado)+', 
				Nodo='''+@Nodo+''', 
				Acceso='+Convert(varchar,@Acceso)+', 
				Nivel='+Convert(varchar,@Nivel)+', 
				FechaDesdeParaModificacion='+Case When @FechaDesdeParaModificacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaDesdeParaModificacion,103)+''',103)' End+', 
				FechaInicialHabilitacion='+Case When @FechaInicialHabilitacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaInicialHabilitacion,103)+''',103)' End+', 
				FechaFinalHabilitacion='+Case When @FechaFinalHabilitacion is null Then 'Null' Else 'Convert(datetime,'''+Convert(varchar,@FechaFinalHabilitacion,103)+''',103)' End+', 
				CantidadAccesos='+Case When @CantidadAccesos is null Then 'Null' Else Convert(varchar,@CantidadAccesos) End+', 
				FechaUltimaModificacion=GetDate(), 
				IdUsuarioModifico='+Convert(varchar,@IdUsuarioModifico)+', 
				UsuarioNTUsuarioModifico='''+@UsuarioNTUsuarioModifico+'''
			Where IdEmpleadoAcceso='+Convert(varchar,@IdEmpleadoAcceso)
		EXEC sp_executesql @sql1
	    END

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1

SET NOCOUNT OFF

--RETURN(@IdEmpleadoAcceso)