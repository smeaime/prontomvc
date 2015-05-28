




CREATE Procedure [dbo].[AnticiposAlPersonalSyJ_TX_Conceptos]

AS 

SET NOCOUNT ON

Declare @BasePRONTOSyJAsociada varchar(50), @sql1 nvarchar(1000)
Set @BasePRONTOSyJAsociada=IsNull((Select Top 1 Parametros.BasePRONTOSyJAsociada 
					From Parametros Where Parametros.IdParametro=1),'')

CREATE TABLE #Auxiliar1 
			(
			 IdConcepto INTEGER,
			 Concepto VARCHAR(50)
			)
IF LEN(@BasePRONTOSyJAsociada)>0
   BEGIN
	SET @sql1=	'Select C.IdConcepto, C.Nombre 
			 From '+@BasePRONTOSyJAsociada+'.dbo.Conceptos C 
			 Where C.ClaveConceptoCantidad is null  
			Union all
			Select C.IdConcepto, C.NombreCantidad 
			 From '+@BasePRONTOSyJAsociada+'.dbo.Conceptos C 
			 Where C.ClaveConceptoCantidad is not null'
	INSERT INTO #Auxiliar1 EXEC sp_executesql @sql1
   END

SET NOCOUNT OFF

SELECT 
 IdConcepto,
 Concepto as [Titulo]
FROM #Auxiliar1 
ORDER BY Concepto

DROP TABLE #Auxiliar1




