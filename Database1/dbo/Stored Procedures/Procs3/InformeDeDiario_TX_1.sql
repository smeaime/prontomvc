































CREATE Procedure [dbo].[InformeDeDiario_TX_1]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar1 (
			 IdDetalleAsiento INTEGER,
			 FechaAsiento DATETIME,
			 NumeroAsiento INTEGER,
			 Orden INTEGER,
			 Concepto VARCHAR(50),
			 CodigoCuenta INTEGER,
			 Cuenta VARCHAR(50),
			 Debe NUMERIC(18,2),
			 Haber NUMERIC(18,2),
			 DetalleItem VARCHAR(50)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  da.IdDetalleAsiento,
  Asientos.FechaAsiento,
  Asientos.NumeroAsiento,
  1,
  Case 	When Asientos.Concepto is not null 
		Then Asientos.Concepto
	When Asientos.IdCuentaSubdiario is not null 
		Then (Select Top 1 Titulos.Titulo From Titulos
			Where Titulos.IdTitulo=Asientos.IdCuentaSubdiario)
	Else Null
  End,
  Cuentas.Codigo,
  Cuentas.Descripcion,
  da.Debe,
  da.Haber,
  da.Detalle
  FROM DetalleAsientos da
  LEFT OUTER JOIN Asientos ON Asientos.IdAsiento=da.IdAsiento
  LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=da.IdCuenta
  WHERE Asientos.FechaAsiento between @FechaDesde and @FechaHasta 

DELETE FROM #Auxiliar1
WHERE (Debe is null or Debe=0) and (Haber is null or Haber=0)

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='00001111111133'
set @vector_T='00005555555500'

SELECT 
 #Auxiliar1.IdDetalleAsiento as [IdDetalleAsiento],
 #Auxiliar1.FechaAsiento as [K_Fecha],
 #Auxiliar1.NumeroAsiento as [K_Asiento],
 #Auxiliar1.Orden as [K_Orden],
 #Auxiliar1.FechaAsiento as [Fecha],
 #Auxiliar1.NumeroAsiento as [Asiento],
 #Auxiliar1.Concepto as [Concepto],
 #Auxiliar1.CodigoCuenta as [Cuenta],
 #Auxiliar1.Cuenta as [Descripcion],
 #Auxiliar1.Debe as [Debe],
 #Auxiliar1.Haber as [Haber],
 #Auxiliar1.DetalleItem as [Detalle item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

UNION ALL 

SELECT 
 0 as [IdDetalleAsiento],
 #Auxiliar1.FechaAsiento as [K_Fecha],
 #Auxiliar1.NumeroAsiento as [K_Asiento],
 2 as [K_Orden],
 Null as [Fecha],
 Null as [Asiento],
 Null as [Concepto],
 Null as [Cuenta],
 SPACE(30)+'TOTALES CONTROL' as [Descripcion],
 SUM(#Auxiliar1.Debe) as [Debe],
 SUM(#Auxiliar1.Haber) as [Haber],
 Null as [Detalle item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.FechaAsiento,#Auxiliar1.NumeroAsiento

UNION ALL 

SELECT 
 0 as [IdDetalleAsiento],
 #Auxiliar1.FechaAsiento as [K_Fecha],
 #Auxiliar1.NumeroAsiento as [K_Asiento],
 3 as [K_Orden],
 Null as [Fecha],
 Null as [Asiento],
 Null as [Concepto],
 Null as [Cuenta],
 Null as [Descripcion],
 Null as [Debe],
 Null as [Haber],
 Null as [Detalle item],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.FechaAsiento,#Auxiliar1.NumeroAsiento

ORDER BY [K_Asiento],[K_Orden]

DROP TABLE #Auxiliar1































