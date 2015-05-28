CREATE Procedure [dbo].[Articulos_TX_BD_ProntoMantenimiento]

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdArticulo INTEGER, Descripcion VARCHAR(256))

SET @sql1='Select A.IdArticulo, A.Descripcion From '+@BasePRONTOMANT+'.dbo.Articulos A'

--IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'ProntoMantenimiento')
IF Len(@BasePRONTOMANT)>0
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

SET NOCOUNT OFF

SELECT IdArticulo, Descripcion as [Titulo]
FROM #Auxiliar1
ORDER BY Descripcion

DROP TABLE #Auxiliar1