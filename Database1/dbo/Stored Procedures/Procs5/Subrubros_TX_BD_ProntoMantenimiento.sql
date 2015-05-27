
CREATE Procedure [dbo].[Subrubros_TX_BD_ProntoMantenimiento]

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(2000), @BasePRONTOMANT varchar(50)

SET @BasePRONTOMANT=IsNull((Select Top 1 BasePRONTOMantenimiento From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdSubrubro INTEGER, Descripcion VARCHAR(256))

SET @sql1='Select S.IdSubrubro, S.Descripcion From '+@BasePRONTOMANT+'.dbo.Subrubros S'
IF Len(@BasePRONTOMANT)>0
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

SET NOCOUNT OFF

SELECT IdSubrubro, Descripcion as [Titulo]
FROM #Auxiliar1
ORDER by Descripcion

DROP TABLE #Auxiliar1
