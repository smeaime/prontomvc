












CREATE PROCEDURE [dbo].[Bancos_TX_MonedasParaPosicionFinanciera]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0	(
			 IdMoneda INTEGER
			)
INSERT INTO #Auxiliar0 

 SELECT DISTINCT
  CuentasBancarias.IdMoneda
 FROM CuentasBancarias 

UNION ALL 

 SELECT DISTINCT
  Cajas.IdMoneda
 FROM Cajas 

UNION ALL 

 SELECT DISTINCT
  PlazosFijos.IdMoneda
 FROM PlazosFijos 

SET NOCOUNT OFF

SELECT 
 #Auxiliar0.IdMoneda,
 Monedas.Nombre as [Moneda]
FROM #Auxiliar0
LEFT OUTER JOIN Monedas ON #Auxiliar0.IdMoneda=Monedas.IdMoneda
GROUP BY #Auxiliar0.IdMoneda,Monedas.Nombre

DROP TABLE #Auxiliar0












