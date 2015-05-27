CREATE Procedure [dbo].[CtasCtesA_TX_SaldosAFecha]

@FechaHasta datetime,
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@DesdeCodigo varchar(10),
@HastaCodigo varchar(10)

AS 

IF Patindex('%(%', @DesdeAlfa)<>0 
	SET @DesdeAlfa=Substring(@DesdeAlfa,1,Patindex('%(%', @DesdeAlfa)-1)
IF Patindex('%(%', @HastaAlfa)<>0 
	SET @HastaAlfa=Substring(@HastaAlfa,1,Patindex('%(%', @HastaAlfa)-1)

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0011166633'
SET @vector_T='0057955500'

SELECT  
 CtaCte.IdProveedor,
 0 as [Aux],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 Case When @ActivaRango=-1 or @ActivaRango=-3 
	Then Proveedores.CodigoEmpresa
	Else Proveedores.RazonSocial
 End as [Orden],
 SUM(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1) as [Saldo en pesos],
 SUM(CtaCte.ImporteTotalDolar*TiposComprobante.Coeficiente*-1) as [Saldo en u$s],
 SUM(CtaCte.ImporteTotalEuro*TiposComprobante.Coeficiente*-1) as [Saldo en Euros],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or 
	 (@ActivaRango=-2 and Proveedores.RazonSocial>=@DesdeAlfa and 
				  Proveedores.RazonSocial<=@HastaAlfa) or 
	 (@ActivaRango=-3 and Proveedores.CodigoEmpresa>=@DesdeCodigo and 
				  Proveedores.CodigoEmpresa<=@HastaCodigo))
GROUP BY CtaCte.IdProveedor,Proveedores.CodigoEmpresa,Proveedores.RazonSocial

UNION ALL 

SELECT  
 0,
 1 as [Aux],
 Null as [Codigo],
 Null as [Proveedor],
 'zzzzz' as [Orden],
 Null as [Saldo en pesos],
 Null as [Saldo en u$s],
 Null as [Saldo en Euros],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT  
 0,
 2 as [Aux],
 Null as [Codigo],
 'TOTALES GENERALES' as [Proveedor],
 'zzzzz' as [Orden],
 SUM(CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1) as [Saldo en pesos],
 SUM(CtaCte.ImporteTotalDolar*TiposComprobante.Coeficiente*-1) as [Saldo en u$s],
 SUM(CtaCte.ImporteTotalEuro*TiposComprobante.Coeficiente*-1) as [Saldo en Euros],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM CuentasCorrientesAcreedores CtaCte
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or 
	 (@ActivaRango=-2 and Proveedores.RazonSocial>=@DesdeAlfa and 
				  Proveedores.RazonSocial<=@HastaAlfa) or 
	 (@ActivaRango=-3 and Proveedores.CodigoEmpresa>=@DesdeCodigo and 
				  Proveedores.CodigoEmpresa<=@HastaCodigo))

ORDER BY [Aux], [Orden]