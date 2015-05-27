
CREATE PROCEDURE [dbo].[Proveedores_TX_SICORE]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 A_CodigoMovimiento VARCHAR(2),
			 A_Proveedor VARCHAR(50),
			 A_Fecha DATETIME,
			 A_NumeroMovimiento INTEGER,
			 A_ImporteTotal NUMERIC(18,0),
			 A_CodigoImpuesto INTEGER,
			 A_CodigoRegimen INTEGER,
			 A_CodigoOperacion VARCHAR(1),
			 A_BaseCalculo NUMERIC(18,0),
			 A_FechaEmisionRetencion DATETIME,
			 A_CodigoCondicion INTEGER,
			 A_ImporteRetencion NUMERIC(18,0),
			 A_PorcentajeExclusion NUMERIC(6,0),
			 A_FechaEmisionBoletin VARCHAR(10),
			 A_TipoDocumentoRetenido VARCHAR(2),
			 A_NumeroDocumentoRetenido VARCHAR(20),
			 A_NumeroCertificadoOriginal INTEGER,
			 A_DenominacionOrdenante VARCHAR(30),
			 A_Acrecentamiento VARCHAR(1),
			 A_CuitDelPaisDelRetenido VARCHAR(11),
			 A_CuitDelOrdenante VARCHAR(11),
			 A_Registro VARCHAR(300)
			)
INSERT INTO #Auxiliar 
 SELECT 
  Case When IsNull(DetOP.ImporteTotalFacturasMPagadasSujetasARetencion,0)<>0 Then '99' Else '06' End,
  pr.RazonSocial,
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  (Select Sum(IsNull(dop.Importe,0)) From DetalleOrdenesPago dop 
   Where dop.IdOrdenPago=DetOP.IdOrdenPago and 
	 dop.IdTipoRetencionGanancia is not null and 
	 dop.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia) * op.CotizacionMoneda * 100,
  TiposRetencionGanancia.CodigoImpuestoAFIP,
  TiposRetencionGanancia.CodigoRegimenAFIP,
  '1',
  DetOP.ImportePagado * op.CotizacionMoneda * 100,
  op.FechaOrdenPago,
  DescripcionIva.CodigoAFIP,
  DetOP.ImpuestoRetenido * op.CotizacionMoneda * 100,
  0,
  '00/00/0000',
  '80',
/*(Select Top 1 Substring(cp.Letra+Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+
			  Convert(varchar,cp.NumeroComprobante1)+
			  Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+
			  Convert(varchar,cp.NumeroComprobante2),1,15)
   From DetalleOrdenesPago DetOP
   Left Outer Join CuentasCorrientesAcreedores ON CuentasCorrientesAcreedores.IdCtaCte=DetOP.IdImputacion
   Left Outer Join ComprobantesProveedores cp ON cp.IdComprobanteProveedor=CuentasCorrientesAcreedores.IdComprobante
   Where DetOP.IdOrdenPago=op.IdOrdenPago and cp.IdComprobanteProveedor is not null), */
  '000000000'+Substring(pr.Cuit,1,2)+Substring(pr.Cuit,4,8)+Substring(pr.Cuit,13,1),
  DetOP.NumeroCertificadoRetencionGanancias,
  Substring(IsNull((Select Top 1 Empresa.Nombre From Empresa),' '),1,30),
  '0',
  '00000000000',
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  ''
 FROM DetalleOrdenesPagoImpuestos DetOP
 LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=DetOP.IdOrdenPago
 LEFT OUTER JOIN Proveedores pr ON pr.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN DescripcionIva ON pr.IdCodigoIva = DescripcionIva.IdCodigoIva 
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=DetOP.IdTipoRetencionGanancia
 WHERE op.IdProveedor is not null and 
	(op.FechaOrdenPago between @Desde and @Hasta) and 
	IsNull(op.Anulada,'NO')='NO' and 
	IsNull(op.Confirmado,'SI')='SI' and 
	DetOP.TipoImpuesto='Ganancias' and 
	IsNull(op.RetencionGanancias,0)<>0

UNION ALL

 SELECT  
  '06',
  Proveedores.RazonSocial, 
  op.FechaOrdenPago,
  op.NumeroOrdenPago,
  Case When IsNull(op.Acreedores,0)<>0 
	Then op.Acreedores
	Else IsNull(op.Valores,0)
  End * op.CotizacionMoneda * 100,
  TiposRetencionGanancia.CodigoImpuestoAFIP,
  TiposRetencionGanancia.CodigoRegimenAFIP,
  '1',
  Case When IsNull(op.Acreedores,0)<>0 
	Then op.Acreedores
	Else IsNull(op.Valores,0)
  End * op.CotizacionMoneda * 100,
  op.FechaOrdenPago,
  DescripcionIva.CodigoAFIP,
  op.RetencionGanancias * op.CotizacionMoneda * 100,
  0,
  '00/00/0000',
  '80',
  '000000000'+Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),  IsNull(op.NumeroCertificadoRetencionGanancias,0),
  Substring(IsNull((Select Top 1 Empresa.Nombre From Empresa),' '),1,30),
  '0',
  '00000000000',
  (Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
  ''
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN TiposRetencionGanancia ON TiposRetencionGanancia.IdTipoRetencionGanancia=Proveedores.IdTipoRetencionGanancia
 LEFT OUTER JOIN DescripcionIva ON Proveedores.IdCodigoIva = DescripcionIva.IdCodigoIva 
 WHERE op.FechaOrdenPago between @Desde and @Hasta and 
	IsNull(op.Anulada,'NO')='NO' and 
	IsNull(op.Confirmado,'SI')='SI' and 
	op.IdProveedor is not null and 
	IsNull(op.RetencionGanancias,0)<>0 and 
	IsNull((Select Top 1 Sum(IsNull(DetOP.ImpuestoRetenido,0))
			From DetalleOrdenesPagoImpuestos DetOP
			Where op.IdOrdenPago=DetOP.IdOrdenPago and DetOP.TipoImpuesto='Ganancias'),0)=0


UPDATE #Auxiliar
SET A_ImporteTotal = 0
WHERE A_ImporteTotal IS NULL

UPDATE #Auxiliar
SET A_BaseCalculo = 0
WHERE A_BaseCalculo IS NULL

UPDATE #Auxiliar
SET A_ImporteRetencion = 0
WHERE A_ImporteRetencion IS NULL

UPDATE #Auxiliar
SET A_NumeroDocumentoRetenido = Space(20)
WHERE A_NumeroDocumentoRetenido IS NULL

UPDATE #Auxiliar
SET A_NumeroCertificadoOriginal = 0
WHERE A_NumeroCertificadoOriginal IS NULL

UPDATE #Auxiliar
SET A_Registro = #Auxiliar.A_CodigoMovimiento+
		 Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_Fecha))))+Convert(varchar,Day(#Auxiliar.A_Fecha))+'/'+
			 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_Fecha))))+Convert(varchar,Month(#Auxiliar.A_Fecha))+'/'+
			 Convert(varchar,Year(#Auxiliar.A_Fecha))+
		 Substring('0000000000000000',1,16-len(Convert(varchar,#Auxiliar.A_NumeroMovimiento)))+Convert(varchar,#Auxiliar.A_NumeroMovimiento)+
		 Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),1,13)+'.'+
		 	Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.A_ImporteTotal)))+Convert(varchar,#Auxiliar.A_ImporteTotal),14,2)+
		 Substring('000',1,3-len(Convert(varchar,#Auxiliar.A_CodigoImpuesto)))+Convert(varchar,#Auxiliar.A_CodigoImpuesto)+
		 Substring('000',1,3-len(Convert(varchar,#Auxiliar.A_CodigoRegimen)))+Convert(varchar,#Auxiliar.A_CodigoRegimen)+
		 #Auxiliar.A_CodigoOperacion+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar.A_BaseCalculo)))+Convert(varchar,#Auxiliar.A_BaseCalculo),1,11)+'.'+
		 	Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar.A_BaseCalculo)))+Convert(varchar,#Auxiliar.A_BaseCalculo),12,2)+
		 Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.A_FechaEmisionRetencion))))+Convert(varchar,Day(#Auxiliar.A_FechaEmisionRetencion))+'/'+
			 Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.A_FechaEmisionRetencion))))+Convert(varchar,Month(#Auxiliar.A_FechaEmisionRetencion))+'/'+
			 Convert(varchar,Year(#Auxiliar.A_FechaEmisionRetencion))+
		 Substring('00',1,2-len(Convert(varchar,#Auxiliar.A_CodigoCondicion)))+Convert(varchar,#Auxiliar.A_CodigoCondicion)+
		 '0'+
		 Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar.A_ImporteRetencion)))+Convert(varchar,#Auxiliar.A_ImporteRetencion),1,11)+'.'+
		 	Substring(Substring('0000000000000',1,13-len(Convert(varchar,#Auxiliar.A_ImporteRetencion)))+Convert(varchar,#Auxiliar.A_ImporteRetencion),12,2)+
		 Substring('000000',1,6-len(Convert(varchar,#Auxiliar.A_PorcentajeExclusion)))+Convert(varchar,#Auxiliar.A_PorcentajeExclusion)+
		 #Auxiliar.A_FechaEmisionBoletin+
		 #Auxiliar.A_TipoDocumentoRetenido+
		 Substring(#Auxiliar.A_NumeroDocumentoRetenido+Space(20),1,20)+
		 Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.A_NumeroCertificadoOriginal)))+Convert(varchar,#Auxiliar.A_NumeroCertificadoOriginal)+
		 Substring(#Auxiliar.A_DenominacionOrdenante,1,30)+Substring(Space(30),1,30-len(#Auxiliar.A_DenominacionOrdenante))+
		 #Auxiliar.A_Acrecentamiento+
		 #Auxiliar.A_CuitDelPaisDelRetenido+
		 #Auxiliar.A_CuitDelOrdenante

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111133'
SET @vector_T='055555555555555555555500'

SELECT 
 0,
 A_CodigoMovimiento as [Cod.Cmp.],
 A_Fecha as [Fecha Cmp.],
 A_NumeroMovimiento as [Numero Cmp.],
 A_ImporteTotal/100 as [Importe total],
 A_Proveedor as [Proveedor],
 A_CodigoImpuesto as [Cod.Imp.],
 A_CodigoRegimen as [Cod.Reg.],
 A_CodigoOperacion as [Cod.Ope.],
 A_BaseCalculo/100 as [Base Calc.],
 A_FechaEmisionRetencion as [Fecha emision],
 A_CodigoCondicion as [Cod.Cond.],
 A_ImporteRetencion/100 as [Importe ret.],
 A_PorcentajeExclusion as [% Excl.],
 A_FechaEmisionBoletin as [Fecha boletin],
 A_TipoDocumentoRetenido as [Tipo Doc.],
 A_NumeroDocumentoRetenido as [Numero Doc.],
 A_NumeroCertificadoOriginal as [Numero certificado],
 A_DenominacionOrdenante as [Empresa],
 A_CuitDelPaisDelRetenido as [CUIT 1],
 A_CuitDelOrdenante as [CUIT Empresa],
 A_Registro as [Registro],
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_ImporteRetencion<>0
ORDER BY A_Fecha,  A_NumeroCertificadoOriginal,  A_Proveedor,  A_NumeroMovimiento

DROP TABLE #Auxiliar
