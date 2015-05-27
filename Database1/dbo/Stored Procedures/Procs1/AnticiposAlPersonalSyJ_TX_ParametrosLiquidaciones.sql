




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_TX_ParametrosLiquidaciones]

AS 

SET NOCOUNT ON

Declare @BasePRONTOSyJAsociada varchar(50), @sql1 nvarchar(1000)
Set @BasePRONTOSyJAsociada=IsNull((Select Top 1 Parametros.BasePRONTOSyJAsociada 
					From Parametros Where Parametros.IdParametro=1),'')

CREATE TABLE #Auxiliar1 
			(
			 IdParametroLiquidacion INTEGER,
			 Descripcion VARCHAR(50),
			 FechaLiquidacion DATETIME
			)
IF LEN(@BasePRONTOSyJAsociada)>0
   BEGIN
	SET @sql1=	'Select PL.IdParametroLiquidacion, PL.Descripcion, PL.FechaLiquidacion 
			 From '+@BasePRONTOSyJAsociada+'.dbo.ParametrosLiquidaciones PL 
			 Order By PL.FechaLiquidacion Desc'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END

SET NOCOUNT OFF

SELECT 
 IdParametroLiquidacion,
 Descripcion as [Titulo]
FROM #Auxiliar1 
ORDER BY FechaLiquidacion DESC

DROP TABLE #Auxiliar1




