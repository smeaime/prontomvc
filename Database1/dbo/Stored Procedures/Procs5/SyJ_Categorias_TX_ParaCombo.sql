CREATE Procedure [dbo].[SyJ_Categorias_TX_ParaCombo]

AS 

SET NOCOUNT ON

DECLARE @sql1 nvarchar(2000), @BasePRONTOSyJ varchar(50)

SET @BasePRONTOSyJ=IsNull((Select Top 1 BasePRONTOSyJAsociada From Parametros Where IdParametro=1),'')

CREATE TABLE #Auxiliar1 (IdSubrubro INTEGER, Descripcion VARCHAR(256))

SET @sql1='Select C.IdCategoriaPresupuestoObra, C.Descripcion From '+@BasePRONTOSyJ+'.dbo.CategoriasPresupuestoObra C'
IF Len(@BasePRONTOSyJ)>0
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1

SET NOCOUNT OFF

SELECT IdSubrubro, Descripcion as [Titulo]
FROM #Auxiliar1
ORDER by Descripcion

DROP TABLE #Auxiliar1