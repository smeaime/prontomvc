





CREATE Procedure [dbo].[RubrosContables_TX_ParaGastosPorObra]
AS 
Select 
 IdRubroContable,
 Codigo,
 Descripcion as [Rubro],
 Nivel
FROM RubrosContables 
WHERE Financiero is null or Financiero<>'SI'
ORDER by Descripcion





