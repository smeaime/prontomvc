CREATE PROCEDURE [dbo].[InformesContables_TX_1361_Ventas]

@Desde datetime,
@Hasta datetime,
@Formato varchar(10) = Null,
@ExcluirConCAE varchar(10) = Null,
@PuntoVenta int = Null

AS

SET NOCOUNT ON

SET @Formato=IsNull(@Formato,'RECE')
SET @ExcluirConCAE=IsNull(@ExcluirConCAE,'NO')
SET @PuntoVenta=IsNull(@PuntoVenta,-1)

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
			 Registro VARCHAR(400)
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
	IsNull(Fac.NumeroFacturaInicial,Fac.NumeroFactura),
	IsNull(Fac.NumeroFacturaFinal,Fac.NumeroFactura),
	Case When Fac.IdCodigoIva=4 Then '86' Else '80' End,
	Case When Fac.IdCodigoIva=4 Then '00000000000' Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) End,
	Substring(Case When Fac.IdCodigoIva=4 Then 'CONSUMIDOR FINAL' Else IsNull(Cli.RazonSocial,'') End,1,50),
	Fac.ImporteTotal * Fac.CotizacionMoneda * 100,
	Case When Not (Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9) and Fac.PorcentajeIva1=0 
			Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
		 Else IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0)
	End * 100,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
			Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
					IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
		 When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
			Then 0
		 Else (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
				IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) * Fac.CotizacionMoneda
	End * 100,
	Fac.PorcentajeIva1 * 100,
	Case When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
			Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
					IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / (1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		 When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
			Then 0
		 Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End * 100,
	0,
	Case When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9
			Then (Fac.ImporteTotal - Fac.ImporteIva1 - Fac.ImporteIva2 - Fac.RetencionIBrutos1 - Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3) * Fac.CotizacionMoneda
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
	Case When Fac.Anulada is null or Fac.Anulada<>'SI'
			Then '00000000'
		 Else Convert(varchar,Year(Fac.FechaAnulacion))+
				Substring('00',1,2-len(Convert(varchar,Month(Fac.FechaAnulacion))))+Convert(varchar,Month(Fac.FechaAnulacion))+			
				Substring('00',1,2-len(Convert(varchar,Day(Fac.FechaAnulacion))))+Convert(varchar,Day(Fac.FechaAnulacion))
	End,
	'',
	''
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Fac.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=1
 WHERE Fac.FechaFactura between @Desde and DATEADD(n,1439,@hasta) and (Fac.TipoABC='A' or (Fac.TipoABC='B' and @Formato<>'RECE')) and --IsNull(Fac.Anulada,'')<>'SI'
		(@ExcluirConCAE='NO' or Len(IsNull(Fac.CAE,''))=0) and (@PuntoVenta=-1 or Fac.PuntoVenta=@PuntoVenta)

INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Dev.FechaDevolucion,
	Case When Dev.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'03')
		 When Dev.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'08')
		 When Dev.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'13')
		 When Dev.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'21')
	End,
	' ',
	Dev.PuntoVenta,
	Dev.NumeroDevolucion,
	Dev.NumeroDevolucion,
	Case When Dev.IdCodigoIva=4 Then '86' Else '80' End,
	Case When Dev.IdCodigoIva=4 Then '00000000000' Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) End,
	Substring(Case When Dev.IdCodigoIva=4 Then 'CONSUMIDOR FINAL' Else IsNull(Cli.RazonSocial,'') End,1,50),
	Dev.ImporteTotal * Dev.CotizacionMoneda * 100,
	0,
	Case When Dev.TipoABC='B' 
			Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / (1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda * 100
		 When Dev.TipoABC='E' 
			Then 0
		 Else (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * 100
	End,
	Dev.PorcentajeIva1 * 100,
	Case When Dev.TipoABC='B' 
			Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / (1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1 / 100) * Dev.CotizacionMoneda * 100
		 When Dev.TipoABC='E' 
			Then 0
		 Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * 100
	End,
	0,
	Case When Dev.TipoABC='E' 
			Then (Dev.ImporteTotal - Dev.ImporteIva1 - Dev.ImporteIva2 - Dev.RetencionIBrutos1 - Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * 100
		 Else 0
	End,
	0,
	(Dev.RetencionIBrutos1 + Dev.RetencionIBrutos2 + Dev.RetencionIBrutos3) * Dev.CotizacionMoneda * 100,
	0,
	0,
	Substring('00',1,2-Len(Convert(varchar,DescripcionIva.CodigoAFIP)))+Convert(varchar,DescripcionIva.CodigoAFIP),
	Monedas.CodigoAFIP,
	Dev.CotizacionMoneda * 1000000,
	'1',
	Case When Dev.TipoABC='E' Then 'X' Else ' ' End,
	Case When Dev.NumeroCAI is not null Then Dev.NumeroCAI Else 0 End,
	Case When Dev.FechaVencimientoCAI is not null 
			Then Convert(varchar,Year(Dev.FechaVencimientoCAI))+
					Substring('00',1,2-len(Convert(varchar,Month(Dev.FechaVencimientoCAI))))+Convert(varchar,Month(Dev.FechaVencimientoCAI))+			
					Substring('00',1,2-len(Convert(varchar,Day(Dev.FechaVencimientoCAI))))+Convert(varchar,Day(Dev.FechaVencimientoCAI))
		 Else '00000000'
	End,
	Case When Dev.Anulada is null or Dev.Anulada<>'SI' Then '00000000'
		 Else Convert(varchar,Year(Dev.FechaAnulacion))+
				Substring('00',1,2-len(Convert(varchar,Month(Dev.FechaAnulacion))))+Convert(varchar,Month(Dev.FechaAnulacion))+			
				Substring('00',1,2-len(Convert(varchar,Day(Dev.FechaAnulacion))))+Convert(varchar,Day(Dev.FechaAnulacion))
	End,
	'',
	''
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Dev.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=5
 WHERE Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta) and (Dev.TipoABC='A' or (Dev.TipoABC='B' and @Formato<>'RECE')) and --IsNull(Dev.Anulada,'')<>'SI'
		@ExcluirConCAE='NO' and (@PuntoVenta=-1 or Dev.PuntoVenta=@PuntoVenta)

INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Deb.FechaNotaDebito,
	Case When Deb.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'02')
		 When Deb.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'07')
		 When Deb.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'12')
		 When Deb.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'20')
	End,
	' ',
	Deb.PuntoVenta,
	Deb.NumeroNotaDebito,
	Deb.NumeroNotaDebito,
	Case When Deb.IdCodigoIva=4 Then '86' Else '80' End,
	Case When Deb.IdCodigoIva=4 Then '00000000000' Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) End,
	Substring(Case When Deb.IdCodigoIva=4 Then 'CONSUMIDOR FINAL' Else IsNull(Cli.RazonSocial,'') End,1,50),
	Deb.ImporteTotal * Deb.CotizacionMoneda * 100,
	Case When Not (Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9)
			Then (IsNull((Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado<>'SI'),0) + 
					IsNull(Deb.OtrasPercepciones1,0) + IsNull(Deb.OtrasPercepciones2,0) + IsNull(Deb.OtrasPercepciones3,0)) * Deb.CotizacionMoneda
		 Else 0
	End * 100,
	Case When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
			Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / (1+(Deb.PorcentajeIva1/100)) * Deb.CotizacionMoneda
		 When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
			Then 0
		 Else (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') * Deb.CotizacionMoneda
	End * 100,
	Case When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9 Then 0 Else Deb.PorcentajeIva1 End * 100,
	Case When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
			Then (Select Sum(DetND.Importe) From DetalleNotasDebito DetND Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
					(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		 When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
			Then 0
		 Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End * 100,
	0,
	Case When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
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
	Case When Deb.Anulada is null or Deb.Anulada<>'SI' Then '00000000'
		 Else Convert(varchar,Year(Deb.FechaAnulacion))+
				Substring('00',1,2-len(Convert(varchar,Month(Deb.FechaAnulacion))))+Convert(varchar,Month(Deb.FechaAnulacion))+			
				Substring('00',1,2-len(Convert(varchar,Day(Deb.FechaAnulacion))))+Convert(varchar,Day(Deb.FechaAnulacion))
	End,
	'',
	''
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Deb.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=3
 WHERE Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta) and (Deb.TipoABC='A' or (Deb.TipoABC='B' and @Formato<>'RECE')) and --IsNull(Deb.Anulada,'')<>'SI'
		(@ExcluirConCAE='NO' or Len(IsNull(Deb.CAE,''))=0) and (@PuntoVenta=-1 or Deb.PuntoVenta=@PuntoVenta) and IsNull(Deb.CtaCte,'')='SI'

INSERT INTO #Auxiliar 
 SELECT 
	'1',
	Cre.FechaNotaCredito,
	Case When Cre.TipoABC='A' Then IsNull(Tc.CodigoAFIP_Letra_A,'03')
		 When Cre.TipoABC='B' Then IsNull(Tc.CodigoAFIP_Letra_B,'08')
		 When Cre.TipoABC='C' Then IsNull(Tc.CodigoAFIP_Letra_C,'13')
		 When Cre.TipoABC='E' Then IsNull(Tc.CodigoAFIP_Letra_E,'21')
	End,
	' ',
	Cre.PuntoVenta,
	Cre.NumeroNotaCredito,
	Cre.NumeroNotaCredito,
	Case When Cre.IdCodigoIva=4 Then '86' Else '80' End,
	Case When Cre.IdCodigoIva=4 Then '00000000000' Else Substring(IsNull(Cli.Cuit,'00'),1,2)+Substring(IsNull(Cli.Cuit,'00000000'),4,8)+Substring(IsNull(Cli.Cuit,'0'),13,1) End,
	Substring(Case When Cre.IdCodigoIva=4 Then 'CONSUMIDOR FINAL' Else IsNull(Cli.RazonSocial,'') End,1,50),
	Cre.ImporteTotal * Cre.CotizacionMoneda * 100,
	Case When Not (Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9)
			Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado<>'SI'),0) + 
					IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda
		 Else 0
	End * 100,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
			Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / (1+(Cre.PorcentajeIva1/100)) * Cre.CotizacionMoneda
		 When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
			Then 0
		 Else (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') * Cre.CotizacionMoneda
	End * 100,
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		Then 0
		Else Cre.PorcentajeIva1
	End * 100,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
			Then (Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
					(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * Cre.CotizacionMoneda
		 When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
			Then 0
		 Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda
	End * 100,
	0,
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
			Then (IsNull((Select Sum(DetNC.Importe) From DetalleNotasCredito DetNC Where DetNC.IdNotaCredito=Cre.IdNotaCredito),0) + 
					IsNull(Cre.OtrasPercepciones1,0) + IsNull(Cre.OtrasPercepciones2,0) + IsNull(Cre.OtrasPercepciones3,0)) * Cre.CotizacionMoneda
		 Else 0
	End * 100,
	0,	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * 100,
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
	Case When Cre.Anulada is null or Cre.Anulada<>'SI' Then '00000000'
		 Else Convert(varchar,Year(Cre.FechaAnulacion))+
				Substring('00',1,2-len(Convert(varchar,Month(Cre.FechaAnulacion))))+Convert(varchar,Month(Cre.FechaAnulacion))+			
				Substring('00',1,2-len(Convert(varchar,Day(Cre.FechaAnulacion))))+Convert(varchar,Day(Cre.FechaAnulacion))
	End,
	'',
	''
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=Cli.IdCodigoIva
 LEFT OUTER JOIN Monedas ON Monedas.IdMoneda=Cre.IdMoneda
 LEFT OUTER JOIN TiposComprobante tc ON tc.IdTipoComprobante=4
 WHERE Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta) and (Cre.TipoABC='A' or (Cre.TipoABC='B' and @Formato<>'RECE')) and --IsNull(Cre.Anulada,'')<>'SI'
		(@ExcluirConCAE='NO' or Len(IsNull(Cre.CAE,''))=0) and (@PuntoVenta=-1 or Cre.PuntoVenta=@PuntoVenta) and IsNull(Cre.CtaCte,'')='SI'

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

IF @Formato='RECE'
  BEGIN
	UPDATE #Auxiliar
	SET Registro = 	#Auxiliar.TipoRegistro+
			Convert(varchar,Year(#Auxiliar.FechaComprobante))+
				Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
				Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
			#Auxiliar.TipoComprobante+
			' '+
			Substring('0000',1,4-len(Convert(varchar,#Auxiliar.PuntoVenta)))+Convert(varchar,#Auxiliar.PuntoVenta)+
			Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobante)))+Convert(varchar,#Auxiliar.NumeroComprobante)+
			Substring('00000000',1,8-len(Convert(varchar,#Auxiliar.NumeroComprobanteHasta)))+Convert(varchar,#Auxiliar.NumeroComprobanteHasta)+
			'   '+
			#Auxiliar.TipoDocumentoIdentificacion+
			Substring('00000000000',1,11-len(#Auxiliar.NumeroDocumentoIdentificacion))+#Auxiliar.NumeroDocumentoIdentificacion+
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
			'               '+
			#Auxiliar.TipoResponsable+
			'   '+
			'          '+
			' '+
			' '+
			'00000000000000'+
			'00000000'+
			'00000000'
  END
ELSE
  BEGIN
	UPDATE #Auxiliar
	SET Registro = 	#Auxiliar.TipoRegistro+
			Convert(varchar,Year(#Auxiliar.FechaComprobante))+
				Substring('00',1,2-len(Convert(varchar,Month(#Auxiliar.FechaComprobante))))+Convert(varchar,Month(#Auxiliar.FechaComprobante))+			
				Substring('00',1,2-len(Convert(varchar,Day(#Auxiliar.FechaComprobante))))+Convert(varchar,Day(#Auxiliar.FechaComprobante))+
			#Auxiliar.TipoComprobante+
			#Auxiliar.ControladorFiscal+
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
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteIVAAcrecentamiento)))+Convert(varchar,#Auxiliar.ImporteIVAAcrecentamiento),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteExento)))+Convert(varchar,#Auxiliar.ImporteExento),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePagoACuentaImpuestosMunicipales),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar.ImportePercepcionesIIBB),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar.ImportePercepcionesImpuestosMunicipales),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar.ImporteImpuestosInternos),1,15)+
			#Auxiliar.TipoResponsable+
			#Auxiliar.Moneda+
			Substring(Substring('0000000000',1,10-len(Convert(varchar,#Auxiliar.CotizacionMoneda)))+Convert(varchar,#Auxiliar.CotizacionMoneda),1,10)+
			#Auxiliar.CantidadAlicuotasIVA+
			#Auxiliar.CodigoOperacion+
			Case When Len(Convert(varchar,#Auxiliar.CAI))<=14 
					Then Substring(Substring('00000000000000',1,14-len(Convert(varchar,#Auxiliar.CAI)))+Convert(varchar,#Auxiliar.CAI),1,14)
					Else '00000000000000'
			End+
			Substring(#Auxiliar.FechaVencimiento+'        ',1,8)+
			Substring(#Auxiliar.FechaAnulacion+'        ',1,8)+
			Substring(#Auxiliar.InformacionAdicional+'                                                                           ',1,75)
  END


CREATE TABLE #Auxiliar1
			(
			 TipoRegistro VARCHAR(1),
			 Periodo VARCHAR(6),
			 PuntoVenta INTEGER,
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
			 Registro VARCHAR(400)
			)
INSERT INTO #Auxiliar1 
 SELECT 
	'2',
	Convert(varchar,Year(@Desde))+Substring('00',1,2-len(Convert(varchar,Month(@Desde))))+Convert(varchar,Month(@Desde)),
	9999,
	(Select Count(*) From #Auxiliar),
	(Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteTotal*-1 Else #Auxiliar.ImporteTotal End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteNoGravado*-1 Else #Auxiliar.ImporteNoGravado End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteGravado*-1 Else #Auxiliar.ImporteGravado End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteIVADiscriminado*-1 Else #Auxiliar.ImporteIVADiscriminado End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteIVAAcrecentamiento*-1 Else #Auxiliar.ImporteIVAAcrecentamiento End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteExento*-1 Else #Auxiliar.ImporteExento End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImportePagoACuentaImpuestosMunicipales*-1 Else #Auxiliar.ImportePagoACuentaImpuestosMunicipales End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImportePercepcionesIIBB*-1 Else #Auxiliar.ImportePercepcionesIIBB End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImportePercepcionesImpuestosMunicipales*-1 Else #Auxiliar.ImportePercepcionesImpuestosMunicipales End),
	Sum(Case When #Auxiliar.TipoComprobante='03' or #Auxiliar.TipoComprobante='08' or #Auxiliar.TipoComprobante='13' or #Auxiliar.TipoComprobante='21' Then #Auxiliar.ImporteImpuestosInternos*-1 Else #Auxiliar.ImporteImpuestosInternos End),
	''
 FROM #Auxiliar

IF @Formato='RECE'
  BEGIN
	UPDATE #Auxiliar1
	SET Registro = 	#Auxiliar1.TipoRegistro+
			#Auxiliar1.Periodo+
			'             '+
			Substring('00000000',1,8-len(Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)))+Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)+
			'                 '+
			#Auxiliar1.CuitEmpresa+
			'                      '+
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
			'                                                             *'
  END
ELSE
  BEGIN
	UPDATE #Auxiliar1
	SET Registro = 	#Auxiliar1.TipoRegistro+
			#Auxiliar1.Periodo+
			'                             '+
			Substring('000000000000',1,12-len(Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)))+Convert(varchar,#Auxiliar1.CantidadRegistrosTipo1)+
			'          '+
			#Auxiliar1.CuitEmpresa+
			'                              '+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteTotal)))+Convert(varchar,#Auxiliar1.ImporteTotal),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteNoGravado)))+Convert(varchar,#Auxiliar1.ImporteNoGravado),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteGravado)))+Convert(varchar,#Auxiliar1.ImporteGravado),1,15)+
			'    '+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteIVADiscriminado)))+Convert(varchar,#Auxiliar1.ImporteIVADiscriminado),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteIVAAcrecentamiento)))+Convert(varchar,#Auxiliar1.ImporteIVAAcrecentamiento),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteExento)))+Convert(varchar,#Auxiliar1.ImporteExento),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,#Auxiliar1.ImportePagoACuentaImpuestosMunicipales),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB)))+Convert(varchar,#Auxiliar1.ImportePercepcionesIIBB),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,#Auxiliar1.ImportePercepcionesImpuestosMunicipales),1,15)+
			Substring(Substring('000000000000000',1,15-len(Convert(varchar,#Auxiliar1.ImporteImpuestosInternos)))+Convert(varchar,#Auxiliar1.ImporteImpuestosInternos),1,15)+
			'                                                                                                                          '
  END

INSERT INTO #Auxiliar 
 SELECT 
	#Auxiliar1.TipoRegistro,
	Null,
	Null,
	Null,
	#Auxiliar1.PuntoVenta,
	Null,
	Null,
	Null,
	Null,
	Null,
	#Auxiliar1.ImporteTotal,
	#Auxiliar1.ImporteNoGravado,
	#Auxiliar1.ImporteGravado,
	Null,
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

IF @Formato='SinFormato'
  BEGIN
	SELECT * FROM #Auxiliar
	WHERE TipoRegistro='1'
	ORDER By PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
  END
ELSE
  BEGIN
	DECLARE @vector_X varchar(50),@vector_T varchar(50)
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
  END
  
DROP TABLE #Auxiliar
DROP TABLE #Auxiliar1