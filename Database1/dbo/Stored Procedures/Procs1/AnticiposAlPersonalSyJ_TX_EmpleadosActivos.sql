




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_TX_EmpleadosActivos]

@IdEmpleado int, 
@Legajo int

AS 

SET NOCOUNT ON

Declare @BasePRONTOSyJAsociada varchar(50), @sql1 nvarchar(1000)
Set @BasePRONTOSyJAsociada=IsNull((Select Top 1 Parametros.BasePRONTOSyJAsociada 
					From Parametros Where Parametros.IdParametro=1),'')

CREATE TABLE #Auxiliar1 
			(
			 IdEmpleado INTEGER,
			 Legajo INTEGER,
			 Apellidos VARCHAR(50),
			 Nombres VARCHAR(50)
			)
IF LEN(@BasePRONTOSyJAsociada)>0
   BEGIN
	SET @sql1='Select Emp.IdEmpleado, Emp.Legajo, Emp.Apellidos, Emp.Nombres 
			From '+@BasePRONTOSyJAsociada+'.dbo.Empleados Emp 
			Where Emp.FechaEgreso is null and 
				('+Convert(varchar,@Legajo)+'=-1 or 
				 Emp.Legajo='+Convert(varchar,@Legajo)+') and 
				('+Convert(varchar,@IdEmpleado)+'=-1 or 
				 Emp.IdEmpleado='+Convert(varchar,@IdEmpleado)+')'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END

SET NOCOUNT OFF

SELECT 
 IdEmpleado,
 Substring(Apellidos+', '+Nombres,1,50)+' [ '+Convert(varchar,Legajo)+' ]' as [Titulo],
 Legajo
FROM #Auxiliar1 
ORDER BY Apellidos, Nombres, Legajo

DROP TABLE #Auxiliar1




