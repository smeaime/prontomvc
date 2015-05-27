CREATE Procedure [dbo].[Proveedores_TX_SIRE]

@FechaDesde datetime,
@FechaHasta datetime

AS 

/*
declare @FechaDesde datetime,@FechaHasta datetime,@Formato int = Null
set @FechaDesde=convert(datetime,'1/1/2015',103)
set @FechaHasta=convert(datetime,'31/3/2015',103)
*/

SET NOCOUNT ON

DECLARE @Formulario varchar(4), @Version varchar(4), @Impuesto varchar(3), @CuitAgente varchar(11)

SET @Formulario='2004'
SET @Version='0100'
SET @Impuesto='353'

SET @CuitAgente=IsNull((Select Top 1 Substring(Cuit,1,2)+Substring(Cuit,4,8)+Substring(Cuit,13,1) From Empresa Where IdEmpresa=1),0)

CREATE TABLE #Auxiliar1 
			(
			 IdDetalleOrdenPago INTEGER,
			 Formulario VARCHAR(4),
			 Version VARCHAR(4),
			 Trazabilidad VARCHAR(10),
			 CuitAgente VARCHAR(11),
			 Impuesto VARCHAR(3),
			 Regimen INTEGER,
			 Proveedor VARCHAR(50),
			 CuitRetenido VARCHAR(11),
			 OrdenPago INTEGER,
			 FechaRetencion DATETIME,
			 TipoComprobante VARCHAR(2),
			 FechaComprobante DATETIME,
			 NumeroComprobante VARCHAR(16),
			 NumeroCertificado INTEGER,
			 ImporteComprobante NUMERIC(18,2),
			 ImporteRetencion NUMERIC(18,2),
			 CertificadoOriginal VARCHAR(25),
			 CertificadoOriginalFechaRetencion VARCHAR(10),
			 CertificadoOriginalImporte NUMERIC(18,2),
			 OtrosDatos VARCHAR(30),
			 Registro VARCHAR(300)
			)

--INSERT INTO #Auxiliar1 
-- SELECT  
--  dop.IdDetalleOrdenPago,
--  @Formulario,
--  @Version,
--  '          ',
--  @CuitAgente,
--  @Impuesto,
--  IsNull(ImpuestosDirectos.CodigoRegimen,0),
--  Proveedores.RazonSocial, 
--  Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),
--  op.NumeroOrdenPago,
--  op.FechaOrdenPago,
--  Case When cp.IdTipoComprobante=11 or cp.IdTipoComprobante=18 or cp.IdTipoComprobante=19 or cp.IdTipoComprobante=40 or 
--			cp.IdTipoComprobante=42 or cp.IdTipoComprobante=44 or cp.IdTipoComprobante=45 Then '01' 
--		When cp.IdTipoComprobante=10 or cp.IdTipoComprobante=13 Then '03' 
--		Else '05' 
--  End,
--  IsNull(cp.FechaComprobante,op.FechaOrdenPago),
--	  IsNull(Substring('0000',1,4-Len(Convert(varchar,cp.NumeroComprobante1)))+Convert(varchar,cp.NumeroComprobante1)+'-'+
--			 Substring('00000000',1,8-Len(Convert(varchar,cp.NumeroComprobante2)))+Convert(varchar,cp.NumeroComprobante2),
--			 '00000000'+Substring('00000000',1,8-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago)),
--  op.NumeroCertificadoRetencionSUSS,
--    IsNull(cp.TotalComprobante,(select sum(Importe) from DetalleOrdenesPago where IdOrdenPago = op.IdOrdenPago)) * IsNull(cp.CotizacionMoneda,op.CotizacionMoneda),
--  dop.ImporteRetencionSUSS * op.CotizacionMoneda,
--  '                         ',
--  '          ',
--  0,
--  '                              ',
--  ''
-- FROM DetalleOrdenesPago dop
-- LEFT OUTER JOIN OrdenesPago op ON op.IdOrdenPago=dop.IdOrdenPago
-- LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
-- LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
-- LEFT OUTER JOIN CuentasCorrientesAcreedores Cta ON Cta.IdCtaCte=dop.IdImputacion
-- LEFT OUTER JOIN TiposComprobante ON TiposComprobante.IdTipoComprobante=Cta.IdTipoComp
-- LEFT OUTER JOIN ComprobantesProveedores cp ON cp.IdComprobanteProveedor=Cta.IdComprobante
-- WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
--	IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
--	op.IdProveedor is not null and IsNull(dop.ImporteRetencionSUSS,0)<>0 and IsNull(op.RetencionSUSS,0)<>0

INSERT INTO #Auxiliar1 
 SELECT  
  op.IdOrdenPago,
  @Formulario,
  @Version,
  '          ',
  @CuitAgente,
  @Impuesto,
  IsNull(ImpuestosDirectos.CodigoRegimen,0),
  Proveedores.RazonSocial, 
  Substring(Proveedores.Cuit,1,2)+Substring(Proveedores.Cuit,4,8)+Substring(Proveedores.Cuit,13,1),
  op.NumeroOrdenPago,
  op.FechaOrdenPago,
  '06',
  op.FechaOrdenPago,
  Substring('000000000000',1,12-Len(Convert(varchar,op.NumeroOrdenPago)))+Convert(varchar,op.NumeroOrdenPago),
  op.NumeroCertificadoRetencionSUSS,
  IsNull((select sum(Importe) from DetalleOrdenesPago where IdOrdenPago = op.IdOrdenPago) * IsNull(op.CotizacionMoneda,1),0),
  op.RetencionSUSS * op.CotizacionMoneda,
  '                         ',
  '          ',
  0,
  '                              ',
  ''
 FROM OrdenesPago op
 LEFT OUTER JOIN Proveedores ON Proveedores.IdProveedor=op.IdProveedor
 LEFT OUTER JOIN ImpuestosDirectos ON Proveedores.IdImpuestoDirectoSUSS = ImpuestosDirectos.IdImpuestoDirecto
 WHERE op.FechaOrdenPago between @FechaDesde and @FechaHasta and 
	IsNull(op.Anulada,'')<>'SI' and IsNull(op.Confirmado,'')<>'NO' and 
	op.IdProveedor is not null and IsNull(op.RetencionSUSS,0)<>0 


UPDATE #Auxiliar1
SET Registro = 	
		Formulario+
		Version+
		Trazabilidad+
		CuitAgente+
		Impuesto+
		Substring('000',1,3-Len(Convert(varchar,Regimen)))+Convert(varchar,Regimen)+
		CuitRetenido+
		Substring('00',1,2-len(Convert(varchar,Day(FechaRetencion))))+Convert(varchar,Day(FechaRetencion))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(FechaRetencion))))+Convert(varchar,Month(FechaRetencion))+'/'+
			Convert(varchar,Year(FechaRetencion))+
		TipoComprobante+
		Substring('00',1,2-len(Convert(varchar,Day(FechaComprobante))))+Convert(varchar,Day(FechaComprobante))+'/'+
			Substring('00',1,2-len(Convert(varchar,Month(FechaComprobante))))+Convert(varchar,Month(FechaComprobante))+'/'+
			Convert(varchar,Year(FechaComprobante))+
		NumeroComprobante+substring('                ',1,16-Len(NumeroComprobante))+
		Substring('00000000000000',1,14-len(Convert(varchar,ImporteComprobante)))+Convert(varchar,ImporteComprobante)+
		Substring('00000000000000',1,14-len(Convert(varchar,ImporteRetencion)))+Convert(varchar,ImporteRetencion)+
		CertificadoOriginal+
		CertificadoOriginalFechaRetencion+
		Substring('00000000000000',1,14-len(Convert(varchar,CertificadoOriginalImporte)))+Convert(varchar,CertificadoOriginalImporte)+
		OtrosDatos

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='011111111111111111111133'
SET @vector_T='033453355555555555555500'

SELECT 
	IdDetalleOrdenPago as [IdDetalleOrdenPago],
	Formulario as [Formulario],
	Version as [Version],
	Trazabilidad as [Trazabilidad],
	CuitAgente as [Cuit agente],
	Impuesto as [Impuesto],
	Regimen as [Regimen],
	Proveedor as [Proveedor],
	CuitRetenido as [Cuit retenido],
	OrdenPago as [Orden de pago],
	FechaRetencion as [Fecha ret.],
	TipoComprobante as [Tipo comp.],
	FechaComprobante as [Fecha comp.],
	NumeroComprobante as [Numero comp.],
	NumeroCertificado as [Nro. certif.],
	ImporteComprobante as [Importe comp.],
	ImporteRetencion as [Importe ret.],
	CertificadoOriginal as [Certificado orig.],
	CertificadoOriginalFechaRetencion as [Fecha certif. orig.],
	CertificadoOriginalImporte as [Importe certif. orig.],
	OtrosDatos as [Otros datos],
	Registro as [Registro],
	@vector_T as Vector_T,
	@vector_X as Vector_X
FROM #Auxiliar1
ORDER BY Proveedor, FechaRetencion, NumeroComprobante

DROP TABLE #Auxiliar1
