CREATE Procedure [dbo].[CtasCtesA_TX_PendientesDeImputacion]

@FechaDesde datetime,
@FechaHasta datetime

AS 

SET NOCOUNT ON

EXEC CtasCtesA_CalcularSaldosPorTransaccion

CREATE TABLE #Auxiliar0 (
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 SaldoDeudor NUMERIC(12,2),
			 SaldoAcreedor NUMERIC(12,2)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  Case When TiposComprobante.Coeficiente=1
	Then CtaCte.Saldo*-1
	Else 0
  End,
  Case When TiposComprobante.Coeficiente=-1
	Then CtaCte.Saldo
	Else 0
  End
  FROM CuentasCorrientesAcreedores CtaCte
  LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
  WHERE CtaCte.Saldo<>0

CREATE TABLE #Auxiliar1 (
			 IdProveedor INTEGER,
			 SaldoDeudor NUMERIC(12,2),
			 SaldoAcreedor NUMERIC(12,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  #Auxiliar0.IdProveedor,
  Sum(#Auxiliar0.SaldoDeudor),
  Sum(#Auxiliar0.SaldoAcreedor)
  FROM #Auxiliar0
  GROUP BY #Auxiliar0.IdProveedor

DELETE FROM #Auxiliar1
WHERE SaldoDeudor=0 or SaldoAcreedor=0

CREATE TABLE #Auxiliar2 (
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 Codigo VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Comprobante VARCHAR(15),
			 Fecha DATETIME,
			 Saldo NUMERIC(12,2)
			)
INSERT INTO #Auxiliar2 
SELECT 
 CtaCte.IdCtaCte,
 CtaCte.IdProveedor,
 Proveedores.CodigoEmpresa,
 Proveedores.RazonSocial,
 TiposComprobante.DescripcionAb+' '+
	Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
	Convert(varchar,CtaCte.NumeroComprobante),
 CtaCte.Fecha,
 CtaCte.Saldo*TiposComprobante.Coeficiente*-1
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.IdProveedor=CtaCte.IdProveedor
 WHERE CtaCte.Saldo<>0 and TiposComprobante.Coeficiente=-1 and #Auxiliar1.IdProveedor is not null
	
SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='0001111133'
SET @vector_T='0005555500'

SELECT 
 0 as [IdAux],
 #Auxiliar2.Codigo as [K_Codigo],
 1 as [K_Orden],
 #Auxiliar2.Codigo as [Codigo],
 #Auxiliar2.Proveedor as [Proveedor],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.Codigo,#Auxiliar2.IdProveedor,#Auxiliar2.Proveedor

UNION ALL 

SELECT 
 #Auxiliar2.IdCtaCte as [IdAux],
 #Auxiliar2.Codigo as [K_Codigo],
 2 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 #Auxiliar2.Comprobante as [Comprobante],
 #Auxiliar2.Fecha as [Fecha],
 #Auxiliar2.Saldo as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2

UNION ALL 

SELECT 
 0 as [IdAux],
 #Auxiliar2.Codigo as [K_Codigo],
 3 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Comprobante],
 Null as [Fecha],
 Null as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
GROUP BY #Auxiliar2.Codigo,#Auxiliar2.IdProveedor,#Auxiliar2.Proveedor

ORDER BY [K_Codigo],[K_Orden]

DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2