
CREATE Procedure [dbo].[CtasCtesA_TT]

AS 

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 IdProveedor INTEGER,
			 Codigo VARCHAR(20),
			 Proveedor VARCHAR(50),
			 Saldo NUMERIC(12,2)
			)
INSERT INTO #Auxiliar 
SELECT 
 CtaCte.IdProveedor,
 Proveedores.CodigoEmpresa,
 Proveedores.RazonSocial,
 SUM(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 GROUP By CtaCte.IdProveedor,Proveedores.CodigoEmpresa,Proveedores.RazonSocial

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='0116133'
Set @vector_T='0245300'

SELECT 
 IdProveedor,
 Codigo as [Codigo],
 Proveedor as [Proveedor],
 Saldo as [Saldo actual],
 (Select Count(*) From CuentasCorrientesAcreedores CtaCte 
  Where CtaCte.IdProveedor=#Auxiliar.IdProveedor) as [Cant.Reg.],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar
ORDER BY #Auxiliar.Proveedor

UPDATE Proveedores
SET Saldo=(Select #Auxiliar.Saldo From #Auxiliar Where #Auxiliar.IdProveedor=Proveedores.IdProveedor)

DROP TABLE #Auxiliar
