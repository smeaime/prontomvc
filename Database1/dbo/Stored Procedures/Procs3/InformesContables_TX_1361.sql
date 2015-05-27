
CREATE PROCEDURE [dbo].[InformesContables_TX_1361]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

CREATE TABLE #Auxiliar 
			(
			 TipoRegistro VARCHAR(1),
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 NumeroComprobanteRegistrado INTEGER,
			 CantidadHojas VARCHAR(3),
			 TipoDocumentoIdentificacion INTEGER,
			 NumeroDocumentoIdentificacion VARCHAR(11),
			 RazonSocial VARCHAR(50),
			 ImporteTotal NUMERIC(18,2),
			 ImporteNoGravado NUMERIC(18,2),
			 ImporteGravado NUMERIC(18,2),
			 ImporteIVADiscriminado NUMERIC(18,2),
			 ImporteIVAAcrecentamiento NUMERIC(18,2),
			 ImporteExento NUMERIC(18,2),
			 ImportePagoACuentaImpuestosMunicipales NUMERIC(18,2),
			 ImportePercepcionesIIBB NUMERIC(18,2),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(18,2),
			 ImporteImpuestosInternos NUMERIC(18,2),
			 ImporteTransporte NUMERIC(18,2),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda NUMERIC(11,6),
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI VARCHAR(20),
			 FechaVencimiento VARCHAR(8),
			 FechaAnulacion VARCHAR(8),
			 Registro VARCHAR(300)
			)
INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Fac.FechaFactura,
	Case 	When Fac.TipoABC='A'
		 Then '01'
		When Fac.TipoABC='B'
		 Then '06'
		When Fac.TipoABC='C'
		 Then '11'
		When Fac.TipoABC='E'
		 Then '19'
	End,
	' ',
	Fac.PuntoVenta,
	Fac.NumeroFactura,
	Fac.NumeroFactura,
	'001',
	'80',
	Substring(Cli.Cuit,1,2)+Substring(Cli.Cuit,4,8)+Substring(Cli.Cuit,13,1),
	Cli.RazonSocial,
	Fac.ImporteTotal * Fac.CotizacionMoneda,
	0,
	Case 	When Fac.TipoABC='B' 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) / 
			(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' 
		 Then 0
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - 
			Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3) * Fac.CotizacionMoneda
	End,
	Case 	When Fac.TipoABC='B' 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) / 
			(1+(Fac.PorcentajeIva1/100)) * 
			(Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' 
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End,
	0,
	Case 	When Fac.TipoABC='E' 
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - 
			Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3) * Fac.CotizacionMoneda
		Else 0
	End,
	0,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * 
		Fac.CotizacionMoneda,
	0,
	0,
	0,
	Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+
		Convert(varchar,DescripcionIva.CodigoAFIP),
	Monedas.CodigoAFIP,
	Fac.CotizacionMoneda,
	'1',
	Case When Fac.TipoABC='E' Then 'X' Else ' ' End,
	Case When Fac.NumeroCAI is not null 
		Then Substring(Convert(varchar,Fac.NumeroCAI)+space(20),1,20)
		Else Space(20)
	End,
	Case When Fac.FechaVencimientoCAI is not null 
		Then Convert(varchar,Year(Fac.FechaVencimientoCAI))+
			Substring('00',1,2-len(Convert(varchar,Day(Fac.FechaVencimientoCAI))))+Convert(varchar,Day(Fac.FechaVencimientoCAI))+			
			Substring('00',1,2-len(Convert(varchar,Month(Fac.FechaVencimientoCAI))))+Convert(varchar,Month(Fac.FechaVencimientoCAI))
		Else Space(8)
	End,
	Case When Fac.Anulada is null or Fac.Anulada<>'SI'
		Then Space(8)
		Else Convert(varchar,Year(Fac.FechaAnulacion))+
			Substring('00',1,2-len(Convert(varchar,Day(Fac.FechaAnulacion))))+Convert(varchar,Day(Fac.FechaAnulacion))+			
			Substring('00',1,2-len(Convert(varchar,Month(Fac.FechaAnulacion))))+Convert(varchar,Month(Fac.FechaAnulacion))
	End,
	''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Fac.IdMoneda
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta) and 
	(Fac.Anulada is null or Fac.Anulada<>'SI')

SET NOCOUNT OFF

declare @vector_X varchar(50),@vector_T varchar(50)
set @vector_X='0111111111111111111111111111111133'
set @vector_T='0243112512433333336466232253556500'

SELECT 
	0 as [IdAux],
	TipoRegistro as [Tipo reg.],
	FechaComprobante as [Fecha comp.],
	TipoComprobante as [Tipo comp.],
	ControladorFiscal as [C.fiscal],
	PuntoVenta as [Pto.vta.],
	NumeroComprobante as [Nro.comp.],
	NumeroComprobanteRegistrado as [Nro.comp.reg.],
	CantidadHojas as [Hojas],
	TipoDocumentoIdentificacion as [Tipo doc.],
	NumeroDocumentoIdentificacion as [Nro.doc.],
	RazonSocial as [Cliente],
	ImporteTotal as [Imp.total],
	ImporteNoGravado as [Imp no grav.],
	ImporteGravado as [Imp grav.],
	ImporteIVADiscriminado as [IVA],
	ImporteIVAAcrecentamiento as [IVA acr.],
	ImporteExento as [Imp.exento],
	ImportePagoACuentaImpuestosMunicipales as [Imp.cta.impuestos],
	ImportePercepcionesIIBB as [Imp.perc.IIBB],
	ImportePercepcionesImpuestosMunicipales as [Imp.perc.impuestos],
	ImporteImpuestosInternos as [Imp.impuestos int.],
	ImporteTransporte as [Imp.transp.],
	TipoResponsable as [Tipo resp.],
	Moneda as [Moneda],
	CotizacionMoneda as [Cot.moneda],
	CantidadAlicuotasIVA as [Cant.alicuotas],
	CodigoOperacion as [Cod.ope.],
	CAI as [Nro.CAI],
	FechaVencimiento as [Fecha vto.CAI],
	FechaAnulacion as [Fecha anulacion],
	Registro as [Registro],
	@Vector_T as Vector_T,
	@Vector_X as Vector_X
FROM #Auxiliar 
ORDER By FechaComprobante,TipoComprobante,PuntoVenta,NumeroComprobante

DROP TABLE #Auxiliar
