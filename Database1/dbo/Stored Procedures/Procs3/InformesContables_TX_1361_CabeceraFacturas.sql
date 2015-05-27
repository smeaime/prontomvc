CREATE PROCEDURE [dbo].[InformesContables_TX_1361_CabeceraFacturas]

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
			 TipoDocumentoIdentificacion VARCHAR(2),
			 NumeroDocumentoIdentificacion VARCHAR(11),
			 RazonSocial VARCHAR(100),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteIVAAcrecentamiento NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePagoACuentaImpuestosMunicipales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 ImporteTransporte NUMERIC(19,0),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda INTEGER,
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI NUMERIC(19,0),
			 FechaVencimiento VARCHAR(8),
			 FechaAnulacion VARCHAR(8),
			 Registro VARCHAR(500)
			)
INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Fac.FechaFactura,
	Case When Fac.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'01')
			When Fac.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'06')
			When Fac.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'11')
			When Fac.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'19')
	End,
	' ',
	Fac.PuntoVenta,
	Fac.NumeroFactura,
	Fac.NumeroFactura,
	'001',
	Case When Fac.IdCodigoIva=4 Then '86' Else '80' End,
	Case When Fac.IdCodigoIva=4 Then '27000000006' Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) End,
	Cli.RazonSocial,
	Fac.ImporteTotal * Fac.CotizacionMoneda * 100,
	Case When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
				Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End * 100,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
				IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
				(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
		 Then 0
		Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
				Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
				IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End * 100,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
				IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
				(1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End * 100,
	0,
	Case When Fac.TipoABC='E' 
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) * Fac.CotizacionMoneda * 100
		Else 0
	End,
	0,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda * 100,
	IsNull(Fac.PercepcionIVA,0) * Fac.CotizacionMoneda * 100,
	0,
	0,
	Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP),
	Monedas.CodigoAFIP,
	Fac.CotizacionMoneda * 1000000,
	'1',
	Case When Fac.TipoABC='E' Then 'X' Else ' ' End,
	Case When Fac.NumeroCAI is not null Then Fac.NumeroCAI Else 0 End,
	Case When Fac.FechaVencimientoCAI is not null 
			Then Convert(varchar,Year(Fac.FechaVencimientoCAI))+
					Substring('00',1,2-len(Convert(varchar,Month(Fac.FechaVencimientoCAI))))+Convert(varchar,Month(Fac.FechaVencimientoCAI))+			
					Substring('00',1,2-len(Convert(varchar,Day(Fac.FechaVencimientoCAI))))+Convert(varchar,Day(Fac.FechaVencimientoCAI))
		Else '00000000'
	End,
	Case When Fac.Anulada is null or Fac.Anulada<>'SI'
		Then '00000000'
		Else Convert(varchar,Year(Fac.FechaAnulacion))+
				Substring('00',1,2-len(Convert(varchar,Month(Fac.FechaAnulacion))))+Convert(varchar,Month(Fac.FechaAnulacion))+			
				Substring('00',1,2-len(Convert(varchar,Day(Fac.FechaAnulacion))))+Convert(varchar,Day(Fac.FechaAnulacion))
	End,
	''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Fac.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta) --and IsNull(Fac.Anulada,'')<>'SI'

/*
UPDATE #Auxiliar
SET ImporteTotal=0, ImporteNoGravado=0, ImporteGravado=0, ImporteIVADiscriminado=0, ImporteIVAAcrecentamiento=0, ImporteExento=0, ImportePagoACuentaImpuestosMunicipales=0, 
	ImportePercepcionesIIBB=0, ImportePercepcionesImpuestosMunicipales=0, ImporteImpuestosInternos=0, ImporteTransporte=0
WHERE FechaAnulacion<>'00000000'
*/

UPDATE #Auxiliar
SET Registro = 	#Auxiliar.TipoRegistro+
		Convert(varchar,Year(#Auxiliar.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
		#Auxiliar.TipoComprobante+
		#Auxiliar.ControladorFiscal+
		Substring('00000',1,5-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobanteRegistrado)))+Convert(varchar,#Auxiliar.NumeroComprobanteRegistrado)+
		#Auxiliar.CantidadHojas+
		#Auxiliar.TipoDocumentoIdentificacion+
		Substring('00000000000000000000',1,20-len(#Auxiliar.NumeroDocumentoIdentificacion))+#Auxiliar.NumeroDocumentoIdentificacion+
		Substring(#Auxiliar.RazonSocial+'                              ',1,30)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteTotal)))+Convert(varchar,#Auxiliar.ImporteTotal),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteNoGravado)))+Convert(varchar,#Auxiliar.ImporteNoGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteGravado)))+Convert(varchar,#Auxiliar.ImporteGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar.ImporteIVADiscriminado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteIVAAcrecentamiento)))+Convert(varchar,#Auxiliar.ImporteIVAAcrecentamiento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteExento)))+Convert(varchar,#Auxiliar.ImporteExento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePagoACuentaImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar.ImportePercepcionesIIBB),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar.ImporteImpuestosInternos),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteTransporte)))+Convert(varchar,#Auxiliar.ImporteTransporte),1,15)+
		#Auxiliar.TipoResponsable+
		#Auxiliar.Moneda+
		Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.CotizacionMoneda)))+Convert(varchar,#Auxiliar.CotizacionMoneda),1,10)+
		#Auxiliar.CantidadAlicuotasIVA+
		#Auxiliar.CodigoOperacion+
		Substring(Substring('00000000000000000000',1,20-len(Convert(varchar(20),#Auxiliar.CAI)))+Convert(varchar(20),#Auxiliar.CAI),7,14)+
		#Auxiliar.FechaVencimiento+
		#Auxiliar.FechaAnulacion+
		'000000000000000'


CREATE TABLE #Auxiliar1 (
			 TipoRegistro VARCHAR(1),
			 Periodo VARCHAR(6),
			 CantidadRegistrosTipo1 INTEGER,
			 CuitEmpresa VARCHAR(11),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteIVAAcrecentamiento NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePagoACuentaImpuestosMunicipales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 Registro VARCHAR(500)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	'2',
	Convert(varchar,Year(@Desde))+Substring('00',1,2-len(Convert(varchar,Month(@Desde))))+Convert(varchar,Month(@Desde)),
	(Select Count(*) From #Auxiliar),
	(Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1)  From Empresa),
	(Select Sum(ImporteTotal) From #Auxiliar),
	(Select Sum(ImporteNoGravado) From #Auxiliar),
	(Select Sum(ImporteGravado) From #Auxiliar),
	(Select Sum(ImporteIVADiscriminado) From #Auxiliar),
	(Select Sum(ImporteIVAAcrecentamiento) From #Auxiliar),
	(Select Sum(ImporteExento) From #Auxiliar),
	(Select Sum(ImportePagoACuentaImpuestosMunicipales) From #Auxiliar),
	(Select Sum(ImportePercepcionesIIBB) From #Auxiliar),
	(Select Sum(ImportePercepcionesImpuestosMunicipales) From #Auxiliar),
	(Select Sum(ImporteImpuestosInternos) From #Auxiliar),
	''

UPDATE #Auxiliar1
SET Registro = 	#Auxiliar1.TipoRegistro+
		#Auxiliar1.Periodo+
		'             '+
		Substring('00000000',1,8-len(Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)))+Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)+
		'                 '+
		#Auxiliar1.CuitEmpresa+
		'                                 '+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteTotal)))+Convert(varchar,#Auxiliar1.ImporteTotal),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteNoGravado)))+Convert(varchar,#Auxiliar1.ImporteNoGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteGravado)))+Convert(varchar,#Auxiliar1.ImporteGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar1.ImporteIVADiscriminado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteIVAAcrecentamiento)))+Convert(varchar,#Auxiliar1.ImporteIVAAcrecentamiento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteExento)))+Convert(varchar,#Auxiliar1.ImporteExento),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,#Auxiliar1.ImportePagoACuentaImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar1.ImporteImpuestosInternos),1,15)+
		'                                                              '+
		'000000000000000'

INSERT INTO #Auxiliar 
 SELECT 
	#Auxiliar1.TipoRegistro,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	#Auxiliar1.ImporteTotal,
	#Auxiliar1.ImporteNoGravado,
	#Auxiliar1.ImporteGravado,
	#Auxiliar1.ImporteIVADiscriminado,
	#Auxiliar1.ImporteIVAAcrecentamiento,
	#Auxiliar1.ImporteExento,
	#Auxiliar1.ImportePagoACuentaImpuestosMunicipales,
	#Auxiliar1.ImportePercepcionesIIBB,
	#Auxiliar1.ImportePercepcionesImpuestosMunicipales,
	#Auxiliar1.ImporteImpuestosInternos,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	Null,
	#Auxiliar1.Registro
 FROM #Auxiliar1

SET NOCOUNT OFF

DECLARE @vector_X varchar(50),@vector_T varchar(50)
SET @vector_X='0111111111111111111111111111111133'
SET @vector_T='0243112512433333336466232253556500'

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
ORDER BY TipoRegistro,FechaComprobante,TipoComprobante,PuntoVenta,NumeroComprobante

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1