




CREATE PROCEDURE [dbo].[Subdiarios_TX_AgrupadosPorMesAño]

@FechaDesde datetime,
@FechaHasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 
			(
			 IdSubdiario INTEGER,
			 Titulo VARCHAR(100),
			 Fecha DATETIME,
			 Debe NUMERIC(18, 2),
			 Haber NUMERIC(18, 2),
			 Diferencia NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  Subdiarios.IdSubdiario,
  Titulos.Titulo,
  Subdiarios.FechaComprobante,
  IsNull(Subdiarios.Debe,0),
  IsNull(Subdiarios.Haber,0),
  0
 FROM Subdiarios
 LEFT OUTER JOIN Titulos ON Subdiarios.IdCuentaSubdiario=Titulos.IdTitulo
 WHERE Subdiarios.FechaComprobante>=@FechaDesde and Subdiarios.FechaComprobante<=DATEADD(n,1439,@FechaHasta)

UPDATE #Auxiliar0
SET Fecha=DATEADD(d,-1,CONVERT(DATETIME,'01/'+CONVERT(VARCHAR,MONTH(DATEADD(m,1,Fecha)))+'/'+CONVERT(VARCHAR,YEAR(DATEADD(m,1,Fecha))))),
    Diferencia=Debe-Haber

SET NOCOUNT OFF

SELECT 
 Min(#Auxiliar0.IdSubdiario) as [Id],
 #Auxiliar0.Fecha as [Fecha],
 #Auxiliar0.Titulo as [Subdiario],
 Sum(#Auxiliar0.Debe) as [Total debe],
 Sum(#Auxiliar0.Haber) as [Total haber],
 Sum(#Auxiliar0.Diferencia) as [Diferencia]
FROM #Auxiliar0
GROUP BY #Auxiliar0.Fecha,#Auxiliar0.Titulo

DROP TABLE #Auxiliar0




