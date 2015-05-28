





























CREATE Procedure [dbo].[CtasCtesA_TX_DetallePorTipoDeProveedor]

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar0 (
			 IdTipoProveedor INTEGER,
			 TipoProveedor VARCHAR(50),
			 TipoSaldo VARCHAR(20),
			 Codigo VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Saldo NUMERIC(12,2)
			)
INSERT INTO #Auxiliar0 
 SELECT 
  Proveedores.TipoProveedor,
  Case 	When Proveedores.TipoProveedor=1 Then 'Proveedores locales'
	When Proveedores.TipoProveedor=2 Then 'Proveedores locales'
	When Proveedores.TipoProveedor=3 Then 'Proveedores exterior'
	When Proveedores.TipoProveedor=4 Then 'Empresas vinculadas'
	When Proveedores.TipoProveedor=5 Then 'Proveedores locales'
  End,
  '',
  Proveedores.CodigoEmpresa,
  Proveedores.RazonSocial,
  SUM(CtaCte.Saldo*TiposComprobante.Coeficiente*-1)
  FROM CuentasCorrientesAcreedores CtaCte
  LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
  LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
  GROUP BY Proveedores.TipoProveedor,Proveedores.RazonSocial,Proveedores.CodigoEmpresa

DELETE FROM #Auxiliar0
WHERE Saldo=0

UPDATE #Auxiliar0
SET TipoSaldo='1.DEUDA'
WHERE Saldo<0

UPDATE #Auxiliar0
SET TipoSaldo='2.ANTICIPOS'
WHERE Saldo>0

SET NOCOUNT OFF

DECLARE @vector_X varchar(30),@vector_T varchar(30)
SET @vector_X='00001111133'
SET @vector_T='00001313500'

SELECT 
 0 as [IdAux],
 #Auxiliar0.TipoProveedor as [K_TipoProveedor],
 #Auxiliar0.TipoSaldo as [K_TipoSaldo],
 1 as [K_Orden],
 #Auxiliar0.TipoProveedor as [Tipo de proveedor],
 #Auxiliar0.TipoSaldo as [Tipo de saldo],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar0
GROUP BY #Auxiliar0.TipoProveedor,#Auxiliar0.TipoSaldo

UNION ALL 

SELECT 
 0 as [IdAux],
 #Auxiliar0.TipoProveedor as [K_TipoProveedor],
 #Auxiliar0.TipoSaldo as [K_TipoSaldo],
 2 as [K_Orden],
 Null as [Tipo de proveedor],
 Null as [Tipo de saldo],
 #Auxiliar0.Codigo as [Codigo],
 #Auxiliar0.Proveedor as [Proveedor],
 #Auxiliar0.Saldo as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar0

UNION ALL 

SELECT 
 0 as [IdAux],
 #Auxiliar0.TipoProveedor as [K_TipoProveedor],
 #Auxiliar0.TipoSaldo as [K_TipoSaldo],
 3 as [K_Orden],
 'TOTAL '+#Auxiliar0.TipoProveedor+' ('+#Auxiliar0.TipoSaldo+')' as [Tipo de proveedor],
 Null as [Tipo de saldo],
 Null as [Codigo],
 Null as [Proveedor],
 SUM(#Auxiliar0.Saldo) as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar0
GROUP BY #Auxiliar0.TipoProveedor,#Auxiliar0.TipoSaldo

UNION ALL 

SELECT 
 0 as [IdAux],
 #Auxiliar0.TipoProveedor as [K_TipoProveedor],
 #Auxiliar0.TipoSaldo as [K_TipoSaldo],
 4 as [K_Orden],
 Null as [Tipo de proveedor],
 Null as [Tipo de saldo],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar0
GROUP BY #Auxiliar0.TipoProveedor,#Auxiliar0.TipoSaldo

ORDER BY [K_TipoProveedor],[K_TipoSaldo],[K_Orden],[Saldo] DESC

DROP TABLE #Auxiliar0





























