CREATE PROCEDURE [dbo].[Clientes_TX_CITI]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @Iva1 numeric(6,2), @IdCliente int

SET @Iva1=IsNull((Select top 1 Iva1 From Parametros Where IdParametro=1),0)
SET @IdCliente=Convert(integer,Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
					Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
					Where pic.Clave='Id de cliente por default para importacion de comprobantes de venta' and Len(IsNull(ProntoIni.Valor,''))>0),'0'))

CREATE TABLE #Auxiliar 
			(
			 TipoRegistro VARCHAR(1),
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 NumeroComprobanteHasta INTEGER,
			 TipoDocumentoIdentificacion VARCHAR(2),
			 NumeroDocumentoIdentificacion VARCHAR(11),
			 RazonSocial VARCHAR(50),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(4,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteIVAAcrecentamiento NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePagoACuentaImpuestosMunicipales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda INTEGER,
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI NUMERIC(19,0),
			 FechaVencimiento VARCHAR(8),
			 FechaAnulacion VARCHAR(8),
			 InformacionAdicional VARCHAR(75),
			 FechaPagoRetencion VARCHAR(8),
			 ImporteRetencion NUMERIC(19,0),
			 Registro VARCHAR(400)
			)
INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Fac.FechaFactura,
	Case When IsNull(Fac.NumeroFacturaInicial,0)>0 Then '80'
		Else Case When Fac.TipoABC='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'01')
				When Fac.TipoABC='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'06')
				When Fac.TipoABC='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'11')
				When Fac.TipoABC='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'19')
			End
	End,
	' ',
	Fac.PuntoVenta,
	IsNull(Fac.NumeroFacturaInicial,Fac.NumeroFactura),
	IsNull(Fac.NumeroFacturaFinal,Fac.NumeroFactura),
	Case When IsNull(Fac.NumeroFacturaInicial,0)>0 Then '99' When Fac.TipoABC='A' Then '80' Else '00' End,
	Case When Fac.IdCodigoIva=4 or IsNull(Fac.NumeroFacturaInicial,0)>0 Then '00000000000'
		Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) 
	End,
	Case When Fac.IdCodigoIva=4 or IsNull(Fac.NumeroFacturaInicial,0)>0 Then 'CONSUMIDOR FINAL' Else Cli.RazonSocial End,
	Fac.ImporteTotal * Fac.CotizacionMoneda * 100,
	Case 	When Not (Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9) and Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End * 100,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
		 Then ((Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100))-Fac.AjusteIva) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or (Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
		 Then 0
		Else ((Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - 
			IsNull(Fac.PercepcionIVA,0)) - IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
	End * 100,
	Fac.PorcentajeIva1 * 100,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then ((Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) + IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or (Fac.PorcentajeIva1=0 and IsNull(Fac.AjusteIva,0)=0)
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2 + IsNull(Fac.AjusteIva,0)) * Fac.CotizacionMoneda
	End * 100,
	0,
	Case 	When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - 
			Fac.RetencionIBrutos3) * Fac.CotizacionMoneda
		Else 0
	End * 100,
	0,
	(Fac.RetencionIBrutos1 + Fac.RetencionIBrutos2 + Fac.RetencionIBrutos3) * Fac.CotizacionMoneda * 100,
	IsNull(Fac.PercepcionIVA,0) * Fac.CotizacionMoneda * 100,
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
	Case When Fac.Anulada is null or Fac.Anulada<>'SI' Then '00000000' Else '00000000' End,
	'',
	'',
	0,
	''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Fac.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta) and IsNull(Fac.Anulada,'')<>'SI'

 UNION ALL 

 SELECT 
	'1',
	Deb.FechaNotaDebito,
	Case When Deb.TipoABC='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'02')
		When Deb.TipoABC='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'07')
		When Deb.TipoABC='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'12')
		When Deb.TipoABC='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'20')
	End,
	' ',
	Deb.PuntoVenta,
	Deb.NumeroNotaDebito,
	Deb.NumeroNotaDebito,
	'80',
	Case When Deb.IdCodigoIva=4 Then '00000000000'
		Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) 
	End,
	Cli.RazonSocial,
	Deb.ImporteTotal * Deb.CotizacionMoneda * 100,
	Case 	When Not (Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9)
		 Then (IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND
				Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI'),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		Else 0
	End * 100,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * Deb.CotizacionMoneda
	End * 100,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9 or 
			IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI'),0)=0
		 Then 0
		Else Deb.PorcentajeIva1
	End * 100,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End * 100,
	0,
	Case 	When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito),0) + 
			IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		Else 0
	End * 100,
	0,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda * 100,
	IsNull(Deb.PercepcionIVA,0) * Deb.CotizacionMoneda * 100,
	0,
	Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP),
	Monedas.CodigoAFIP,
	Deb.CotizacionMoneda * 1000000,
	'1',
	Case When Deb.TipoABC='E' Then 'X' Else ' ' End,
	Case When Deb.NumeroCAI is not null Then Deb.NumeroCAI Else 0 End,
	Case When Deb.FechaVencimientoCAI is not null 
		Then Convert(varchar,Year(Deb.FechaVencimientoCAI))+
			Substring('00',1,2-len(Convert(varchar,Month(Deb.FechaVencimientoCAI))))+Convert(varchar,Month(Deb.FechaVencimientoCAI))+			
			Substring('00',1,2-len(Convert(varchar,Day(Deb.FechaVencimientoCAI))))+Convert(varchar,Day(Deb.FechaVencimientoCAI))
		Else '00000000'
	End,
	Case When Deb.Anulada is null or Deb.Anulada<>'SI' Then '00000000' Else '00000000' End,
	'',
	'',
	0,
	''
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Deb.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=3
 WHERE Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta) and IsNull(Deb.Anulada,'')<>'SI'

 UNION ALL 

 SELECT 
	'1',
	Cre.FechaNotaCredito,
	Case When Cre.TipoABC='A' Then IsNull(Tc.CodigoAFIP2_Letra_A,'03')
		When Cre.TipoABC='B' Then IsNull(Tc.CodigoAFIP2_Letra_B,'08')
		When Cre.TipoABC='C' Then IsNull(Tc.CodigoAFIP2_Letra_C,'13')
		When Cre.TipoABC='E' Then IsNull(Tc.CodigoAFIP2_Letra_E,'21')
	End,
	' ',
	Cre.PuntoVenta,
	IsNull(Cre.NumeroFacturaOriginal,Cre.NumeroNotaCredito),
	IsNull(Cre.NumeroFacturaOriginal,Cre.NumeroNotaCredito),
	'80',
	Case When Cre.IdCodigoIva=4 or IsNull(Cre.NumeroFacturaOriginal,0)>0 Then '00000000000'
		Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) 
	End,
	Case When Cre.IdCodigoIva=4 or IsNull(Cre.NumeroFacturaOriginal,0)>0 Then 'CONSUMIDOR FINAL' Else Cli.RazonSocial End,
	Cre.ImporteTotal * Cre.CotizacionMoneda * 100,
	Case 	When Not (Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9)
		 Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
				Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda
		Else 0
	End * 100,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * Cre.CotizacionMoneda
	End * 100,
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9 Or 
			IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI'),0)=0
		Then 0
		Else Cre.PorcentajeIva1
	End * 100,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * Cre.CotizacionMoneda
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda
	End * 100,
	0,
	Case 	When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito),0) + 
			IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda
		Else 0
	End * 100,
	0,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * 100,
	IsNull(Cre.PercepcionIVA,0) * Cre.CotizacionMoneda * 100,
	0,
	Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP),
	Monedas.CodigoAFIP,
	Cre.CotizacionMoneda * 1000000,
	'1',
	Case When Cre.TipoABC='E' Then 'X' Else ' ' End,
	Case When Cre.NumeroCAI is not null Then Cre.NumeroCAI Else 0 End,
	Case When Cre.FechaVencimientoCAI is not null 
		Then Convert(varchar,Year(Cre.FechaVencimientoCAI))+
			Substring('00',1,2-len(Convert(varchar,Month(Cre.FechaVencimientoCAI))))+Convert(varchar,Month(Cre.FechaVencimientoCAI))+			
			Substring('00',1,2-len(Convert(varchar,Day(Cre.FechaVencimientoCAI))))+Convert(varchar,Day(Cre.FechaVencimientoCAI))
		Else '00000000'
	End,
	Case When Cre.Anulada is null or Cre.Anulada<>'SI' Then '00000000' Else '00000000' End,
	'',
	'',
	0,
	''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Cre.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 WHERE Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta) and IsNull(Cre.Anulada,'')<>'SI' and IsNull(Cre.NumeroFacturaOriginal,0)=0


UPDATE #Auxiliar
SET ImporteTotal=0
WHERE ImporteTotal IS NULL

UPDATE #Auxiliar
SET ImporteNoGravado=0
WHERE ImporteNoGravado IS NULL

UPDATE #Auxiliar
SET ImporteGravado=0
WHERE ImporteGravado IS NULL

UPDATE #Auxiliar
SET AlicuotaIVA=0
WHERE AlicuotaIVA IS NULL

UPDATE #Auxiliar
SET ImporteIVADiscriminado=0
WHERE ImporteIVADiscriminado IS NULL

UPDATE #Auxiliar
SET ImporteIVAAcrecentamiento=0
WHERE ImporteIVAAcrecentamiento IS NULL

UPDATE #Auxiliar
SET ImporteExento=0
WHERE ImporteExento IS NULL

UPDATE #Auxiliar
SET ImportePagoACuentaImpuestosMunicipales=0
WHERE ImportePagoACuentaImpuestosMunicipales IS NULL

UPDATE #Auxiliar
SET ImportePercepcionesIIBB=0
WHERE ImportePercepcionesIIBB IS NULL

UPDATE #Auxiliar
SET ImportePercepcionesImpuestosMunicipales=0
WHERE ImportePercepcionesImpuestosMunicipales IS NULL

UPDATE #Auxiliar
SET ImporteImpuestosInternos=0
WHERE ImporteImpuestosInternos IS NULL

UPDATE #Auxiliar
SET AlicuotaIVA=@Iva1 * 100
WHERE ImporteIVADiscriminado>0

UPDATE #Auxiliar
SET AlicuotaIVA=0
WHERE ImporteIVADiscriminado=0

DELETE #Auxiliar WHERE ImporteTotal=0

UPDATE #Auxiliar
SET Registro = 	#Auxiliar.TipoRegistro+
		Convert(varchar,Year(#Auxiliar.FechaComprobante))+
			Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
			Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
		#Auxiliar.TipoComprobante+
		' '+
		Substring('0000',1,4-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
		Substring('00000000000000000000',1,20-len(Convert(varchar,#Auxiliar.NumeroComprobanteHasta)))+Convert(varchar,#Auxiliar.NumeroComprobanteHasta)+
		#Auxiliar.TipoDocumentoIdentificacion+
		Substring('00000000000',1,11-len(#Auxiliar.NumeroDocumentoIdentificacion))+#Auxiliar.NumeroDocumentoIdentificacion+
		Substring(#Auxiliar.RazonSocial+'                              ',1,30)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteTotal)))+Convert(varchar,#Auxiliar.ImporteTotal),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteNoGravado)))+Convert(varchar,#Auxiliar.ImporteNoGravado),1,15)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteGravado)))+Convert(varchar,#Auxiliar.ImporteGravado),1,15)+
		Substring(Substring('0000',1,4-len(Convert(varchar,#Auxiliar.AlicuotaIVA)))+Convert(varchar,#Auxiliar.AlicuotaIVA),1,4)+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar.ImporteIVADiscriminado),1,15)+
		'000000000000000'+
		Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteExento)))+Convert(varchar,#Auxiliar.ImporteExento),1,15)+
		'000000000000000'+
		'000000000000000'+
		'000000000000000'+
		'000000000000000'+
		'00'+
		'   '+
		'0000000000'+
		'1'+
		' '+
		'00000000000000'+
		'00000000'+
		'00000000'+
		'                                                                           '+
		'00000000'+
		'000000000000000'

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50)
SET @vector_X='01111111111111111111111111111133'
SET @vector_T='02431125243333333646632253556500'

SELECT 
	0 as [IdAux],
	TipoRegistro as [Tipo reg.],
	FechaComprobante as [Fecha comp.],
	TipoComprobante as [Tipo comp.],
	ControladorFiscal as [C.fiscal],
	PuntoVenta as [Pto.vta.],
	NumeroComprobante as [Nro.comp.],
	NumeroComprobanteHasta as [Nro.comp.reg.],
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
ORDER By PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante

DROP TABLE #Auxiliar