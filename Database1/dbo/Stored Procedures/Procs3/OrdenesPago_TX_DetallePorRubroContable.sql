




CREATE PROCEDURE [dbo].[OrdenesPago_TX_DetallePorRubroContable]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar1
			(
			 IdOrdenPago INTEGER,
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  DetOP.IdOrdenPago,
  DetOP.IdRubroContable,
  DetOP.Importe
 FROM DetalleOrdenesPagoRubrosContables DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 WHERE op.FechaOrdenPago between @Desde and @hasta and 
	(op.Confirmado is null or op.Confirmado<>'NO')

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00000111633'
Set @vector_T='00000234400'

SELECT
 1 as [K_Tipo],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Numero], 
 RubrosContables.Descripcion as [Rubro contable],
 Null as [Numero], 
 Null as [Fecha Pago], 
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 2 as [K_Tipo],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 op.FechaOrdenPago as [K_Fecha], 
 op.NumeroOrdenPago as [K_Numero], 
 Null as [Rubro contable],
 op.NumeroOrdenPago as [Numero], 
 op.FechaOrdenPago as [Fecha Pago], 
 #Auxiliar1.Importe as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=#Auxiliar1.IdOrdenPago
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable

UNION ALL

SELECT
 3 as [K_Tipo],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Numero], 
 '   TOTAL RUBRO' as [Rubro contable],
 Null as [Numero], 
 Null as [Fecha Pago], 
 SUM(#Auxiliar1.Importe) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 4 as [K_Tipo],
 #Auxiliar1.IdRubroContable as [K_IdRubro],
 RubrosContables.Descripcion as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Numero], 
 Null as [Rubro contable],
 Null as [Numero], 
 Null as [Fecha Pago], 
 Null as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 
LEFT OUTER JOIN RubrosContables ON RubrosContables.IdRubroContable=#Auxiliar1.IdRubroContable
GROUP BY #Auxiliar1.IdRubroContable,RubrosContables.Descripcion

UNION ALL

SELECT
 5 as [K_Tipo],
 999999 as [K_IdRubro],
 'zzzz' as [K_Rubro],
 Null as [K_Fecha], 
 Null as [K_Numero], 
 'TOTAL GENERAL' as [Rubro contable],
 Null as [Numero], 
 Null as [Fecha Pago], 
 SUM(#Auxiliar1.Importe) as [Importe],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1 

ORDER BY [K_Rubro],[K_IdRubro],[K_Tipo],[K_Fecha],[K_Numero]

DROP TABLE #Auxiliar1






