




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_TT]

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
CREATE TABLE #Auxiliar2 
			(
			 IdParametroLiquidacion INTEGER,
			 Descripcion VARCHAR(50)
			)
IF LEN(@BasePRONTOSyJAsociada)>0
   BEGIN
	SET @sql1='Select Emp.IdEmpleado, Emp.Legajo, Emp.Apellidos, Emp.Nombres 
			From '+@BasePRONTOSyJAsociada+'.dbo.Empleados Emp'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
	SET @sql1='Select PL.IdParametroLiquidacion, PL.Descripcion 
			 From '+@BasePRONTOSyJAsociada+'.dbo.ParametrosLiquidaciones PL 
			 Order By PL.FechaLiquidacion Desc'
	INSERT INTO #Auxiliar2 EXEC sp_executesql @sql1
   END

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='011111133'
Set @vector_T='022412200'

SELECT
 AP.IdAnticipoAlPersonalSyJ,
 #Auxiliar1.Legajo as [Legajo],
 Substring(#Auxiliar1.Apellidos+', '+#Auxiliar1.Nombres,1,50) as [Nombre],
 AP.Fecha as [Fecha],
 AP.Importe as [Importe],
 AP.Detalle as [Detalle],
 #Auxiliar2.Descripcion as [Descontado en liquidacion],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM AnticiposAlPersonalSyJ AP
LEFT OUTER JOIN #Auxiliar1 ON AP.IdEmpleado = #Auxiliar1.IdEmpleado
LEFT OUTER JOIN #Auxiliar2 ON AP.IdParametroLiquidacion = #Auxiliar2.IdParametroLiquidacion
ORDER BY #Auxiliar1.Legajo, AP.Fecha

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2




