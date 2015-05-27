
CREATE Procedure [dbo].[CtasCtesA_TX_SaldosEntreFechas]

@FechaDesde datetime,
@FechaHasta datetime,
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@IdObra int = Null

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)

DECLARE @IdTipoComprobanteOrdenPago int
SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago
					From Parametros Where Parametros.IdParametro=1)

CREATE TABLE #Auxiliar1(
			 IdCtaCte INTEGER,
			 IdProveedor INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(15),
			 Referencia INTEGER,
			 Fecha DATETIME,
			 ImporteTotal NUMERIC(18,2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdCtaCte,
  CtaCte.IdProveedor,
  Case When CtaCte.IdTipoComp=16 Then @IdTipoComprobanteOrdenPago Else CtaCte.IdTipoComp End,
  TiposComprobante.DescripcionAB,
  CtaCte.IdComprobante,
  Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
	Then Substring(Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
		Convert(varchar,CtaCte.NumeroComprobante),1,15)
	Else Substring(cp.Letra+'-'+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
		Convert(varchar,cp.NumeroComprobante1)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
		Convert(varchar,cp.NumeroComprobante2),1,15)
  End,
  CtaCte.NumeroComprobante,
  CtaCte.Fecha,
  CtaCte.ImporteTotal * TiposComprobante.Coeficiente
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
 WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or (Proveedores.RazonSocial>=@DesdeAlfa and 
				Proveedores.RazonSocial<=@HastaAlfa))

UPDATE #Auxiliar1
SET NumeroComprobante='00000000'
WHERE NumeroComprobante IS NULL

CREATE TABLE #Auxiliar2(
			 IdProveedor INTEGER,
			 IdTipoComprobante INTEGER,
			 TipoComprobante VARCHAR(5),
			 IdComprobante INTEGER,
			 NumeroComprobante VARCHAR(15),
			 Referencia INTEGER,
			 Fecha DATETIME,
			 ImporteTotal NUMERIC(18,2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  #Auxiliar1.IdProveedor,
  #Auxiliar1.IdTipoComprobante,
  MAX(#Auxiliar1.TipoComprobante),
  #Auxiliar1.IdComprobante,
  MAX(#Auxiliar1.NumeroComprobante),
  #Auxiliar1.Referencia,
  MAX(#Auxiliar1.Fecha),
  SUM(#Auxiliar1.ImporteTotal)
 FROM #Auxiliar1 
 GROUP BY #Auxiliar1.IdProveedor,#Auxiliar1.IdTipoComprobante,#Auxiliar1.IdComprobante,
		#Auxiliar1.Referencia

SET NOCOUNT OFF

Declare @vector_X varchar(30),@vector_T varchar(30)
Set @vector_X='00001111116661533'
Set @vector_T='00000207143333300'

SELECT 
 #Auxiliar2.IdProveedor as [K_IdProveedor],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_RazonSocial],
 0 as [K_Orden],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 Null as [Comp.],
 Null as [Numero],
 Null as [Ref.],
 Null as [Fecha],
 Null as [Imp.orig.],
 (Select Sum(Case When #Auxiliar1.ImporteTotal<0 Then #Auxiliar1.ImporteTotal * -1 Else 0 End)
  From #Auxiliar1 
  Where #Auxiliar1.IdProveedor=#Auxiliar2.IdProveedor and 
	#Auxiliar1.Fecha<@FechaDesde) as [Debe],
 (Select Sum(Case When #Auxiliar1.ImporteTotal>=0 Then #Auxiliar1.ImporteTotal Else 0 End)
  From #Auxiliar1 
  Where #Auxiliar1.IdProveedor=#Auxiliar2.IdProveedor and 
	#Auxiliar1.Fecha<@FechaDesde) as [Haber],
 (Select Sum(#Auxiliar1.ImporteTotal * -1) 
  From #Auxiliar1 
  Where #Auxiliar1.IdProveedor=#Auxiliar2.IdProveedor and 
	#Auxiliar1.Fecha<@FechaDesde) as [Sdo],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar2.IdProveedor
GROUP BY #Auxiliar2.IdProveedor,Proveedores.CodigoEmpresa,Proveedores.RazonSocial

UNION ALL

SELECT 
 #Auxiliar2.IdProveedor as [K_IdProveedor],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_RazonSocial],
 1 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 #Auxiliar2.TipoComprobante as [Comp.],
 #Auxiliar2.NumeroComprobante as [Numero],
 #Auxiliar2.Referencia as [Ref.],
 #Auxiliar2.Fecha as [Fecha],
 #Auxiliar2.ImporteTotal * -1 as [Imp.orig.],
 Case When #Auxiliar2.ImporteTotal<0 Then #Auxiliar2.ImporteTotal * -1
	Else Null
 End as [Debe],
 Case When #Auxiliar2.ImporteTotal>=0 Then #Auxiliar2.ImporteTotal
	Else Null
 End as [Haber],
 #Auxiliar2.ImporteTotal as [Sdo],
 Case When #Auxiliar2.IdTipoComprobante<>@IdTipoComprobanteOrdenPago
	Then cp.Observaciones
	Else Null
 End as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar2.IdProveedor
LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=#Auxiliar2.IdComprobante
WHERE #Auxiliar2.Fecha>=@FechaDesde

UNION ALL

SELECT 
 #Auxiliar2.IdProveedor as [K_IdProveedor],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_RazonSocial],
 2 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Comp.],
 Null as [Numero],
 Null as [Ref.],
 Null as [Fecha],
 Null as [Imp.orig.],
 Null as [Debe],
 Null as [Haber],
 Null as [Sdo],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar2
LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar2.IdProveedor
GROUP BY #Auxiliar2.IdProveedor,Proveedores.CodigoEmpresa,Proveedores.RazonSocial

UNION ALL

SELECT 
 0 as [K_IdProveedor],
 'zzzzz' as [K_Codigo],
 'zzzzz' as [K_RazonSocial],
 3 as [K_Orden],
 Null as [Codigo],
 'TOTALES GENERALES' as [Proveedor],
 Null as [Comp.],
 Null as [Numero],
 Null as [Ref.],
 Null as [Fecha],
 Null as [Imp.orig.],
 Sum(Case When #Auxiliar1.ImporteTotal<0 Then #Auxiliar1.ImporteTotal * -1 Else 0 End) as [Debe],
 Sum(Case When #Auxiliar1.ImporteTotal>=0 Then #Auxiliar1.ImporteTotal Else 0 End) as [Haber],
 Sum(#Auxiliar1.ImporteTotal * -1) as [Sdo],
 Null as [Observaciones],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar1

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
