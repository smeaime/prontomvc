CREATE Procedure [dbo].[RubrosContables_TX_ParaCombo]

AS 

SELECT 
 IdRubroContable,
 Descripcion as Titulo
FROM RubrosContables 
WHERE Codigo>=1000
ORDER by Descripcion