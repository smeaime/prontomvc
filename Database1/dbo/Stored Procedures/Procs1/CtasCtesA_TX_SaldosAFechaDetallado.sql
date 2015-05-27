CREATE Procedure [dbo].[CtasCtesA_TX_SaldosAFechaDetallado]

@FechaDesde datetime,
@FechaHasta datetime,
@ActivaRango int,
@DesdeAlfa varchar(100),
@HastaAlfa varchar(100),
@DesdeCodigo varchar(10),
@HastaCodigo varchar(10)

AS 

SET NOCOUNT ON

IF Patindex('%(%', @DesdeAlfa)<>0 
	SET @DesdeAlfa=Substring(@DesdeAlfa,1,Patindex('%(%', @DesdeAlfa)-1)
IF Patindex('%(%', @HastaAlfa)<>0 
	SET @HastaAlfa=Substring(@HastaAlfa,1,Patindex('%(%', @HastaAlfa)-1)

DECLARE @IdTipoComprobanteOrdenPago int, @Saldo Numeric(18,2)

SET @IdTipoComprobanteOrdenPago=(Select Top 1 Parametros.IdTipoComprobanteOrdenPago From Parametros Where Parametros.IdParametro=1)
SET @Saldo=0

CREATE TABLE #Auxiliar1
			(
			 IdProveedor INTEGER,
			 SaldoPesos NUMERIC(18, 2),
			 SaldoDolares NUMERIC(18, 2),
			 SaldoEuros NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar1 
 SELECT 
  CtaCte.IdProveedor,
  SUM(Case When CtaCte.Fecha<@FechaDesde 
	Then IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente*-1
	Else 0
      End),
  SUM(Case When CtaCte.Fecha<@FechaDesde 
	Then IsNull(CtaCte.ImporteTotalDolar,0)*TiposComprobante.Coeficiente*-1
	Else 0
      End),
  SUM(Case When CtaCte.Fecha<@FechaDesde 
	Then IsNull(CtaCte.ImporteTotalEuro,0)*TiposComprobante.Coeficiente*-1
	Else 0
      End)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 WHERE CtaCte.Fecha<@FechaHasta and 
	(@ActivaRango=-1 or 
	 (@ActivaRango=-2 and Proveedores.RazonSocial>=@DesdeAlfa and 
				  Proveedores.RazonSocial<=@HastaAlfa) or 
	 (@ActivaRango=-3 and Proveedores.CodigoEmpresa>=@DesdeCodigo and 
				  Proveedores.CodigoEmpresa<=@HastaCodigo))
 GROUP BY CtaCte.IdProveedor

CREATE TABLE #Auxiliar2
			(
			 IdProveedor INTEGER,
			 SaldoPesos NUMERIC(18, 2),
			 SaldoDolares NUMERIC(18, 2),
			 SaldoEuros NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
  CtaCte.IdProveedor,
  SUM(IsNull(CtaCte.ImporteTotal,0)*TiposComprobante.Coeficiente*-1),
  SUM(IsNull(CtaCte.ImporteTotalDolar,0)*TiposComprobante.Coeficiente*-1),
  SUM(IsNull(CtaCte.ImporteTotalEuro,0)*TiposComprobante.Coeficiente*-1)
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 WHERE CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or 
	 (@ActivaRango=-2 and Proveedores.RazonSocial>=@DesdeAlfa and 
				  Proveedores.RazonSocial<=@HastaAlfa) or 
	 (@ActivaRango=-3 and Proveedores.CodigoEmpresa>=@DesdeCodigo and 
				  Proveedores.CodigoEmpresa<=@HastaCodigo))
 GROUP BY CtaCte.IdProveedor

SET NOCOUNT OFF


Declare @vector_X varchar(50),@vector_T varchar(50)
Set @vector_X='00001116633'
Set @vector_T='00001143300'

SELECT  
 #Auxiliar1.IdProveedor as [K_Id],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 0 as [K_Orden],
 Proveedores.CodigoEmpresa as [Codigo],
 Proveedores.RazonSocial as [Proveedor],
 'SALDO INICIAL AL '+Convert(varchar,@FechaDesde,103) as [Comprobante],
 Null as [Importe],
 #Auxiliar1.SaldoPesos as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar1
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar1.IdProveedor

UNION ALL

SELECT  
 CtaCte.IdProveedor as [K_Id],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 1 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 '    '+
 Substring(
	 Case When CtaCte.IdTipoComp=@IdTipoComprobanteOrdenPago or CtaCte.IdTipoComp=16
		Then '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+
					Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+
					Convert(varchar,Day(CtaCte.Fecha))+') '+
			'OP '+
			Substring(Substring('00000000',1,8-Len(Convert(varchar,CtaCte.NumeroComprobante)))+
			Convert(varchar,CtaCte.NumeroComprobante),1,15)
		Else '('+Convert(varchar,Year(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Month(CtaCte.Fecha))))+
					Convert(varchar,Month(CtaCte.Fecha))+
				Substring('00',1,2-Len(Convert(varchar,Day(CtaCte.Fecha))))+
					Convert(varchar,Day(CtaCte.Fecha))+') '+
			TiposComprobante.DescripcionAb+' '+
			Substring(IsNull(cp.Letra,'?')+'-'+
				Substring('0000',1,4-Len(Convert(varchar,IsNull(cp.NumeroComprobante1,0))))+
					Convert(varchar,IsNull(cp.NumeroComprobante1,0))+'-'+
				Substring('00000000',1,8-Len(Convert(varchar,IsNull(cp.NumeroComprobante2,CtaCte.NumeroComprobante))))+
					Convert(varchar,IsNull(cp.NumeroComprobante2,CtaCte.NumeroComprobante)),1,15)+' '+
			' del '+Convert(varchar,CtaCte.Fecha,103)+' '+
			'[ Ref. : '+Convert(varchar,IsNull(cp.NumeroReferencia,0))+' ]'
	 End,1,70) as [Comprobante],
 CtaCte.ImporteTotal*TiposComprobante.Coeficiente*-1 as [Importe],
 @Saldo as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM CuentasCorrientesAcreedores CtaCte
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=CtaCte.IdProveedor
 LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=CtaCte.IdTipoComp
 LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CtaCte.IdComprobante
 WHERE CtaCte.Fecha>=@FechaDesde and CtaCte.Fecha<=@FechaHasta and 
	(@ActivaRango=-1 or 
	 (@ActivaRango=-2 and Proveedores.RazonSocial>=@DesdeAlfa and 
				  Proveedores.RazonSocial<=@HastaAlfa) or 
	 (@ActivaRango=-3 and Proveedores.CodigoEmpresa>=@DesdeCodigo and 
				  Proveedores.CodigoEmpresa<=@HastaCodigo))

UNION ALL

SELECT  
 #Auxiliar2.IdProveedor as [K_Id],
 Proveedores.CodigoEmpresa as [K_Codigo],
 Proveedores.RazonSocial as [K_Proveedor],
 2 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 'SALDO FINAL AL '+Convert(varchar,@FechaHasta,103) as [Comprobante],
 Null as [Importe],
 #Auxiliar2.SaldoPesos as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar2
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=#Auxiliar2.IdProveedor

UNION ALL

SELECT  
 0 as [K_Id],
 Null as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 3 as [K_Orden],
 Null as [Codigo],
 Null as [Proveedor],
 Null as [Comprobante],
 Null as [Importe],
 0 as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL

SELECT  
 0 as [K_Id],
 Null as [K_Codigo],
 'zzzzz' as [K_Proveedor],
 4 as [K_Orden],
 Null as [Codigo],
 'TOTALES GENERALES' as [Proveedor],
 Null as [Comprobante],
 Null as [Importe],
 IsNull(Sum(#Auxiliar2.SaldoPesos),0) as [Saldo],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
 FROM #Auxiliar2

ORDER BY [K_Proveedor],[K_Orden],[Comprobante]

DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2