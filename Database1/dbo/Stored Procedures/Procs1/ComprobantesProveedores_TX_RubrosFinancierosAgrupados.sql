CREATE Procedure [dbo].[ComprobantesProveedores_TX_RubrosFinancierosAgrupados]

@IdComprobantes varchar(8000)

AS

SET NOCOUNT ON

DECLARE @TotalGeneral numeric(18,2)

CREATE TABLE #Auxiliar1 
			(
			 IdRubroContable INTEGER,
			 Importe NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  dcp.IdRubroContable,
  Sum(IsNull(dcp.ImporteIVA1,0) + IsNull(dcp.ImporteIVA2,0) + IsNull(dcp.ImporteIVA3,0) + IsNull(dcp.ImporteIVA4,0) + IsNull(dcp.ImporteIVA5,0) + IsNull(dcp.ImporteIVA6,0) + 
	IsNull(dcp.ImporteIVA7,0) + IsNull(dcp.ImporteIVA8,0) + IsNull(dcp.ImporteIVA9,0) + IsNull(dcp.ImporteIVA10,0) + IsNull(dcp.Importe,0))
 FROM DetalleComprobantesProveedores dcp
 WHERE Patindex('%('+Convert(varchar,dcp.IdComprobanteProveedor)+')%', @IdComprobantes)<>0 and dcp.IdRubroContable is not null
 GROUP BY dcp.IdRubroContable

SET @TotalGeneral=IsNull((Select Sum(Importe) From #Auxiliar1),0)

SET NOCOUNT OFF

SELECT 
 #Auxiliar1.IdRubroContable,
 #Auxiliar1.Importe as [Importe],
 @TotalGeneral as [TotalGeneral]
FROM #Auxiliar1
ORDER BY #Auxiliar1.IdRubroContable

DROP TABLE #Auxiliar1