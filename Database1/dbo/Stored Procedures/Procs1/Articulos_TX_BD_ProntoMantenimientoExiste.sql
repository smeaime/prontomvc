
CREATE Procedure [dbo].[Articulos_TX_BD_ProntoMantenimientoExiste]

AS 

SET NOCOUNT ON
DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)
SET @BasePRONTOMANT=IsNull((Select Top 1 P.BasePRONTOMantenimiento 
				From Parametros P Where P.IdParametro=1),'')
SET @sql1='Select name From master.dbo.sysdatabases Where name = N'+''''+@BasePRONTOMANT+''''
CREATE TABLE #Auxiliar1 (Descripcion VARCHAR(256))
INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
SET NOCOUNT OFF
SELECT * FROM #Auxiliar1
DROP TABLE #Auxiliar1
