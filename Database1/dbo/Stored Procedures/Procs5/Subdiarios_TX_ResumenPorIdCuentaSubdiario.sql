



CREATE PROCEDURE [dbo].[Subdiarios_TX_ResumenPorIdCuentaSubdiario]

@Mes int,
@Anio int,
@IdCuentaSubdiario int

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 
			(
			 IdCuenta INTEGER,
			 Debe NUMERIC(18,2),
			 Haber NUMERIC(18,2),
			 Orden INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Subdiarios.IdCuenta,
  CASE 	WHEN IsNull(Subdiarios.Debe,0)>=0 and IsNull(Subdiarios.Haber,0)>=0 
	 THEN IsNull(Subdiarios.Debe,0)
	WHEN IsNull(Subdiarios.Debe,0)>=0 and IsNull(Subdiarios.Haber,0)<0 
	 THEN IsNull(Subdiarios.Debe,0)+(IsNull(Subdiarios.Haber,0)*-1)
	 ELSE 0
  END,
  CASE 	WHEN IsNull(Subdiarios.Haber,0)>=0 and IsNull(Subdiarios.Debe,0)>=0 
	 THEN IsNull(Subdiarios.Haber,0)
	WHEN IsNull(Subdiarios.Haber,0)>=0 and IsNull(Subdiarios.Debe,0)<0 
	 THEN IsNull(Subdiarios.Haber,0)+(IsNull(Subdiarios.Debe,0)*-1)
	 ELSE 0
  END,
  0
 FROM Subdiarios
 WHERE MONTH(Subdiarios.FechaComprobante)=@Mes and YEAR(Subdiarios.FechaComprobante)=@Anio and 
	Subdiarios.IdCuentaSubdiario=@IdCuentaSubdiario

 UPDATE #Auxiliar1
 SET Orden=1
 WHERE Debe<>0 and Haber=0

 UPDATE #Auxiliar1
 SET Orden=2
 WHERE Debe=0 and Haber<>0

 UPDATE #Auxiliar1
 SET Orden=3
 WHERE Debe<>0 and Haber<>0

SET NOCOUNT OFF

SELECT 
 Cuentas.Codigo as [Codigo],
 Cuentas.Descripcion as [Cuenta],
 #Auxiliar1.Orden,
 SUM(#Auxiliar1.Debe) as [Debe],
 SUM(#Auxiliar1.Haber) as [Haber]
FROM #Auxiliar1
LEFT OUTER JOIN Cuentas ON #Auxiliar1.IdCuenta=Cuentas.IdCuenta
GROUP BY Cuentas.Codigo, Cuentas.Descripcion, #Auxiliar1.Orden
ORDER BY Orden, Cuentas.Codigo

DROP TABLE #Auxiliar1




