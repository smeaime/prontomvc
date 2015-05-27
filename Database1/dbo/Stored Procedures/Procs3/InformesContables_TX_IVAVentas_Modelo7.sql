CREATE PROCEDURE [dbo].[InformesContables_TX_IVAVentas_Modelo7]

@Desde datetime,
@Hasta datetime

AS

-- Modelo armado para Capen con discriminacion de percepciones de IIBB por Capital, Bs.As. y otros

SET NOCOUNT ON

DECLARE @IdCtaAdicCol1 int, @IdCtaAdicCol2 int, @IdCtaAdicCol3 int, @IdCtaAdicCol4 int, @IdCtaAdicCol5 int, @Cuentas varchar(100), 
	@CtaAdicCol1 varchar(50), @CtaAdicCol2 varchar(50), @CtaAdicCol3 varchar(50), @CtaAdicCol4 varchar(50), @CtaAdicCol5 varchar(50)

SET @IdCtaAdicCol1=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAdicionalIVAVentas1'),0)
SET @IdCtaAdicCol2=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAdicionalIVAVentas2'),0)
SET @IdCtaAdicCol3=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAdicionalIVAVentas3'),0)
SET @IdCtaAdicCol4=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAdicionalIVAVentas4'),0)
SET @IdCtaAdicCol5=IsNull((Select Top 1 Valor From Parametros2 Where Campo='IdCuentaAdicionalIVAVentas5'),0)
SET @Cuentas='('+Convert(varchar,@IdCtaAdicCol1)+')('+Convert(varchar,@IdCtaAdicCol2)+')('+Convert(varchar,@IdCtaAdicCol3)+')'+
		'('+Convert(varchar,@IdCtaAdicCol4)+')('+Convert(varchar,@IdCtaAdicCol5)+')'
SET @CtaAdicCol1=IsNull((Select Top 1 Descripcion From Cuentas Where IdCuenta=@IdCtaAdicCol1),'')
SET @CtaAdicCol2=IsNull((Select Top 1 Descripcion From Cuentas Where IdCuenta=@IdCtaAdicCol2),'')
SET @CtaAdicCol3=IsNull((Select Top 1 Descripcion From Cuentas Where IdCuenta=@IdCtaAdicCol3),'')
SET @CtaAdicCol4=IsNull((Select Top 1 Descripcion From Cuentas Where IdCuenta=@IdCtaAdicCol4),'')
SET @CtaAdicCol5=IsNull((Select Top 1 Descripcion From Cuentas Where IdCuenta=@IdCtaAdicCol5),'')

CREATE TABLE #Auxiliar0 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar0 
 SELECT 
  'FA',
  dfoc.IdFactura,
  OrdenesCompra.IdObra
 FROM DetalleFacturasOrdenesCompra dfoc
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = dfoc.IdFactura
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dfoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

 UNION ALL

 SELECT 
  'FA',
  DetFacRem.IdFactura,
  DetalleRemitos.IdObra
 FROM DetalleFacturasRemitos DetFacRem
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura = DetFacRem.IdFactura
 LEFT OUTER JOIN DetalleRemitos ON DetFacRem.IdDetalleRemito = DetalleRemitos.IdDetalleRemito
 WHERE DetalleRemitos.IdObra is not null and 
	(Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

 UNION ALL

 SELECT 
  'CD',
  DetDev.IdDevolucion,
  DetDev.IdObra
 FROM DetalleDevoluciones DetDev
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion = DetDev.IdDevolucion
 WHERE DetDev.IdObra is not null and 
	(Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(Dev.Anulada is null or Dev.Anulada<>'SI')

 UNION ALL

 SELECT 
  'ND',
  Deb.IdNotaDebito,
  Deb.IdObra
 FROM NotasDebito Deb
 WHERE Deb.IdObra is not null and 
	(Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and
	(Deb.Anulada is null or Deb.Anulada<>'SI') and 
	Deb.CtaCte='SI' and 
	Deb.IdNotaCreditoVenta_RecuperoGastos is null

 UNION ALL

 SELECT 
  'NC',
  Cre.IdNotaCredito,
  OrdenesCompra.IdObra
 FROM DetalleNotasCreditoOrdenesCompra dcoc
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito = dcoc.IdNotaCredito
 LEFT OUTER JOIN DetalleOrdenesCompra doc ON doc.IdDetalleOrdenCompra = dcoc.IdDetalleOrdenCompra
 LEFT OUTER JOIN OrdenesCompra ON doc.IdOrdenCompra = OrdenesCompra.IdOrdenCompra
 WHERE OrdenesCompra.IdObra is not null and 
	(Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and 
	(Cre.Anulada is null or Cre.Anulada<>'SI') and 
	Cre.CtaCte='SI' and 
	Cre.IdFacturaVenta_RecuperoGastos is null

CREATE TABLE #Auxiliar1 
			(
			 Tipo VARCHAR(2),
			 IdComprobante INTEGER,
			 IdObra INTEGER
			)
INSERT INTO #Auxiliar1 
 SELECT 
  Tipo,
  IdComprobante,
  MAX(IdObra)
 FROM #Auxiliar0
 GROUP BY Tipo,IdComprobante

CREATE TABLE #Auxiliar2 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoExportacion NUMERIC(18, 2),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar2 
 SELECT 
	1,
	Fac.IdFactura,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then 	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and Fac.PorcentajeIva1<>0
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) / 
					(1+(Fac.PorcentajeIva1/100)) * Fac.CotizacionMoneda
				When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
					IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
				 Then 0
				Else ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
			End
		Else 0
	End,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Fac.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)<>'4') or 
					IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
				Else 0
			End
		Else 0
	End,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Fac.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4') 
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
				Else 0
			End
		Else 0
	End,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol1
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol2
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol3
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol4
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol5
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Fac.CotizacionMoneda
		Else 0
	End
 FROM DetalleFacturas Det 
 LEFT OUTER JOIN Facturas Fac ON Fac.IdFactura=Det.IdFactura
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdArticulo
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Articulos.IdRubro
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Rubros.IdCuenta
 WHERE IsNull(Fac.Anulada,'')<>'SI' and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

UNION ALL

 SELECT 
	1,
	Fac.IdFactura,
	0,
	IsNull(Fac.OtrasPercepciones1,0) + IsNull(Fac.OtrasPercepciones2,0) + IsNull(Fac.OtrasPercepciones3,0),
	0,
	0,
	0,
	0,
	0,
	0
 FROM Facturas Fac 
 WHERE IsNull(Fac.Anulada,'')<>'SI' and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta)) and 
	(IsNull(Fac.OtrasPercepciones1,0)<>0 or IsNull(Fac.OtrasPercepciones2,0)<>0 or IsNull(Fac.OtrasPercepciones3,0)<>0)

UNION ALL

 SELECT 
	5,
	Dev.IdDevolucion,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then 	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 and Dev.PorcentajeIva1<>0
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) / 
					(1+(Dev.PorcentajeIva1/100)) * Dev.CotizacionMoneda
				When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or 
					IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9 or Dev.PorcentajeIva1=0
				 Then 0
				Else ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
			End
		Else 0
	End * -1,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Dev.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)<>'4') or 
					IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9 or Dev.PorcentajeIva1=0
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
				Else 0
			End
		Else 0
	End * -1,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Rubros.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Dev.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4') 
				 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
				Else 0
			End
		Else 0
	End * -1,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol1
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol2
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol3
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol4
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Rubros.IdCuenta,-1)=@IdCtaAdicCol5
		 Then ((Det.Cantidad*Det.PrecioUnitario)*(1-(Det.Bonificacion/100))) * Dev.CotizacionMoneda
		Else 0
	End * -1
 FROM DetalleDevoluciones Det 
 LEFT OUTER JOIN Devoluciones Dev ON Dev.IdDevolucion=Det.IdDevolucion
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=Det.IdArticulo
 LEFT OUTER JOIN Rubros ON Rubros.IdRubro=Articulos.IdRubro
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Rubros.IdCuenta
 WHERE IsNull(Dev.Anulada,'')<>'SI' and (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta))

UNION ALL

 SELECT 
	5,
	Dev.IdDevolucion,
	0,
	IsNull(Dev.OtrasPercepciones1,0) + IsNull(Dev.OtrasPercepciones2,0),
	0,
	0,
	0,
	0,
	0,
	0
 FROM Devoluciones Dev 
 WHERE IsNull(Dev.Anulada,'')<>'SI' and (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and 
	(IsNull(Dev.OtrasPercepciones1,0)<>0 or IsNull(Dev.OtrasPercepciones2,0)<>0)

UNION ALL

 SELECT 
	3,
	Deb.IdNotaDebito,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then 	Case 	When Det.Gravado='SI' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>9
				 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
				Else 0
			End
		Else 0
	End,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Deb.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)<>'4') or 
					IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
				 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
				When Det.Gravado='NO' 
				 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
				Else 0
			End
		Else 0
	End,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Deb.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4') 
				 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
				Else 0
			End
		Else 0
	End,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol1
		 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol2
		 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol3
		 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol4
		 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
		Else 0
	End,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol5
		 Then IsNull(Det.Importe,0) * Deb.CotizacionMoneda
		Else 0
	End
 FROM DetalleNotasDebito Det
 LEFT OUTER JOIN NotasDebito Deb ON Deb.IdNotaDebito=Det.IdNotaDebito
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN Conceptos ON Conceptos.IdConcepto=Det.IdConcepto
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Conceptos.IdCuenta
 WHERE IsNull(Deb.Anulada,'')<>'SI' and (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and
	Deb.CtaCte='SI' and Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL

 SELECT 
	4,
	Cre.IdNotaCredito,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then 	Case 	When Det.Gravado='SI' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>9
				 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
				Else 0
			End
		Else 0
	End * -1,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Cre.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)<>'4') or 
					IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
				 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
				When Det.Gravado='NO' 
				 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
				Else 0
			End
		Else 0
	End * -1,
	Case 	When Patindex('%('+Convert(varchar,IsNull(Conceptos.IdCuenta,-1))+')%', @Cuentas)=0
		 Then	Case 	When (Cre.TipoABC='E' and Substring(IsNull(Cuentas.Jerarquia,''),1,1)='4') 
				 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
				Else 0
			End
		Else 0
	End * -1,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol1
		 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol2
		 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol3
		 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol4
		 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
		Else 0
	End * -1,
	Case 	When IsNull(Conceptos.IdCuenta,-1)=@IdCtaAdicCol5
		 Then IsNull(Det.Importe,0) * Cre.CotizacionMoneda
		Else 0
	End * -1
 FROM DetalleNotasCredito Det
 LEFT OUTER JOIN NotasCredito Cre ON Cre.IdNotaCredito=Det.IdNotaCredito
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN Conceptos ON Conceptos.IdConcepto=Det.IdConcepto
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Conceptos.IdCuenta
 WHERE IsNull(Cre.Anulada,'')<>'SI' and (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and
	Cre.CtaCte='SI' and Cre.IdFacturaVenta_RecuperoGastos is null

CREATE TABLE #Auxiliar3 
			(
			 IdTipoComprobante INTEGER,
			 IdComprobante INTEGER,
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoExportacion NUMERIC(18, 2),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar3 
 SELECT IdTipoComprobante, IdComprobante, Sum(IsNull(A_NetoGravado,0)), Sum(IsNull(A_NetoNoGravado,0)), Sum(IsNull(A_NetoNoGravadoExportacion,0)), 
	Sum(IsNull(A_CtaAdicCol1,0)), Sum(IsNull(A_CtaAdicCol2,0)), Sum(IsNull(A_CtaAdicCol3,0)), Sum(IsNull(A_CtaAdicCol4,0)), 
	Sum(IsNull(A_CtaAdicCol5,0))
 FROM #Auxiliar2
 GROUP BY IdTipoComprobante, IdComprobante

CREATE TABLE #Auxiliar 
			(
			 A_Fecha DATETIME,
			 A_TipoComprobante VARCHAR(3),
			 A_Comprobante VARCHAR(20),
			 A_Cuenta INTEGER,
			 A_Cliente VARCHAR(100),
			 A_CondicionIVA VARCHAR(50),
			 A_Cuit VARCHAR(13),
			 A_NetoGravado NUMERIC(18, 2),
			 A_NetoNoGravado NUMERIC(18, 2),
			 A_NetoNoGravadoExportacion NUMERIC(18, 2),
			 A_Tasa NUMERIC(6, 2),
			 A_Iva NUMERIC(18, 2),
			 A_Percepcion NUMERIC(18, 2),
			 A_PercepcionIVA NUMERIC(18, 2),
			 A_Total NUMERIC(18, 2),
			 A_IdObra INTEGER,
			 A_Comprobante1 VARCHAR(20),
			 A_CtaAdicCol1 NUMERIC(18, 2),
			 A_CtaAdicCol2 NUMERIC(18, 2),
			 A_CtaAdicCol3 NUMERIC(18, 2),
			 A_CtaAdicCol4 NUMERIC(18, 2),
			 A_CtaAdicCol5 NUMERIC(18, 2),
			 A_AjusteDiferencia NUMERIC(18, 2),
			 A_PercepcionCA NUMERIC(18, 2),
			 A_PercepcionBA NUMERIC(18, 2),
			 A_PercepcionOT NUMERIC(18, 2)
			)
INSERT INTO #Auxiliar 

 SELECT 
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End,
	'1FA', 
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	IsNull(#Auxiliar3.A_NetoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravadoExportacion,0),
	Case When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 Then 0 Else Fac.PorcentajeIva1 End,
	Case 	When Fac.TipoABC='B' and IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>8 and 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)<>9 and Fac.PorcentajeIva1<>0 
		 Then (Fac.ImporteTotal - Fac.RetencionIBrutos1 - 
			Fac.RetencionIBrutos2 - Fac.RetencionIBrutos3 - 
			IsNull(Fac.OtrasPercepciones1,0) - IsNull(Fac.OtrasPercepciones2,0) - 
			IsNull(Fac.OtrasPercepciones3,0) - IsNull(Fac.PercepcionIVA,0)) / 
			(1+(Fac.PorcentajeIva1/100)) * (Fac.PorcentajeIva1 / 100) * Fac.CotizacionMoneda
		When Fac.TipoABC='E' or IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=8 or 
			IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)=9 or Fac.PorcentajeIva1=0 
		 Then 0
		Else (Fac.ImporteIva1 + Fac.ImporteIva2) * Fac.CotizacionMoneda
	End,
	(IsNull(Fac.RetencionIBrutos1,0) + IsNull(Fac.RetencionIBrutos2,0) + IsNull(Fac.RetencionIBrutos3,0)) * Fac.CotizacionMoneda,
	IsNull(Fac.PercepcionIVA,0) * Fac.CotizacionMoneda,
	Fac.ImporteTotal * Fac.CotizacionMoneda,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	IsNull(#Auxiliar3.A_CtaAdicCol1,0),
	IsNull(#Auxiliar3.A_CtaAdicCol2,0),
	IsNull(#Auxiliar3.A_CtaAdicCol3,0),
	IsNull(#Auxiliar3.A_CtaAdicCol4,0),
	IsNull(#Auxiliar3.A_CtaAdicCol5,0),
	0,
	Case When IsNull(Provincias.Codigo,'')='00' Then (IsNull(Fac.RetencionIBrutos1,0) + IsNull(Fac.RetencionIBrutos2,0) + IsNull(Fac.RetencionIBrutos3,0)) * Fac.CotizacionMoneda Else 0 End,
	Case When IsNull(Provincias.Codigo,'')='01' Then (IsNull(Fac.RetencionIBrutos1,0) + IsNull(Fac.RetencionIBrutos2,0) + IsNull(Fac.RetencionIBrutos3,0)) * Fac.CotizacionMoneda Else 0 End,
	Case When IsNull(Provincias.Codigo,'')<>'00' and IsNull(Provincias.Codigo,'')<>'01' Then (IsNull(Fac.RetencionIBrutos1,0) + IsNull(Fac.RetencionIBrutos2,0) + IsNull(Fac.RetencionIBrutos3,0)) * Fac.CotizacionMoneda Else 0 End
 FROM Facturas Fac 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Fac.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Fac.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Fac.IdIBCondicion
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='FA' and #Auxiliar1.IdComprobante=Fac.IdFactura
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdTipoComprobante=1 and #Auxiliar3.IdComprobante=Fac.IdFactura
 WHERE (Fac.Anulada is null or Fac.Anulada<>'SI') and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO'  
		Then Fac.FechaFactura
		Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

UNION ALL 

 SELECT 
	Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End,
	'1FA',
	'FAC '+Fac.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	Null,
	'FACTURA ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Fac.PuntoVenta)))+Convert(varchar,Fac.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Fac.NumeroFactura)))+Convert(varchar,Fac.NumeroFactura),
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM Facturas Fac 
 WHERE IsNull(Fac.Anulada,'')='SI' and 
	(Case When IsNull(Fac.ContabilizarAFechaVencimiento,'NO')='NO' Then Fac.FechaFactura Else Fac.FechaVencimiento End between @Desde and DATEADD(n,1439,@hasta))

UNION ALL 

 SELECT 
	Dev.FechaDevolucion,
	'2CD',
	'CRE '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	IsNull(#Auxiliar3.A_NetoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravadoExportacion,0),
	Case When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9 Then 0 Else Dev.PorcentajeIva1 End,
	Case 	When Dev.TipoABC='B' and IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Dev.ImporteTotal - Dev.RetencionIBrutos1 - 
			Dev.RetencionIBrutos2 - Dev.RetencionIBrutos3) / 
			(1+(Dev.PorcentajeIva1/100)) * (Dev.PorcentajeIva1/100) * 
			Dev.CotizacionMoneda * -1
		When Dev.TipoABC='E' or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Dev.ImporteIva1 + Dev.ImporteIva2) * Dev.CotizacionMoneda * -1
	End,
	(IsNull(Dev.RetencionIBrutos1,0) + IsNull(Dev.RetencionIBrutos2,0) + IsNull(Dev.RetencionIBrutos3,0)) * Dev.CotizacionMoneda * -1,
	0,
	Dev.ImporteTotal * Dev.CotizacionMoneda * -1,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	IsNull(#Auxiliar3.A_CtaAdicCol1,0),
	IsNull(#Auxiliar3.A_CtaAdicCol2,0),
	IsNull(#Auxiliar3.A_CtaAdicCol3,0),
	IsNull(#Auxiliar3.A_CtaAdicCol4,0),
	IsNull(#Auxiliar3.A_CtaAdicCol5,0),
	0,
	Case When IsNull(Provincias.Codigo,'')='00' Then (IsNull(Dev.RetencionIBrutos1,0) + IsNull(Dev.RetencionIBrutos2,0) + IsNull(Dev.RetencionIBrutos3,0)) * Dev.CotizacionMoneda * -1 Else 0 End,
	Case When IsNull(Provincias.Codigo,'')='01' Then (IsNull(Dev.RetencionIBrutos1,0) + IsNull(Dev.RetencionIBrutos2,0) + IsNull(Dev.RetencionIBrutos3,0)) * Dev.CotizacionMoneda * -1 Else 0 End,
	Case When IsNull(Provincias.Codigo,'')<>'00' and IsNull(Provincias.Codigo,'')<>'01' Then (IsNull(Dev.RetencionIBrutos1,0) + IsNull(Dev.RetencionIBrutos2,0) + IsNull(Dev.RetencionIBrutos3,0)) * Dev.CotizacionMoneda * -1 Else 0 End
 FROM Devoluciones Dev 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Dev.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Dev.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Dev.IdIBCondicion
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='CD' and #Auxiliar1.IdComprobante=Dev.IdDevolucion
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdTipoComprobante=5 and #Auxiliar3.IdComprobante=Dev.IdDevolucion
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and (Dev.Anulada is null or Dev.Anulada<>'SI')

UNION ALL 

 SELECT 
	Dev.FechaDevolucion,
	'2CD',
	'CRE '+Dev.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	Null,
	'DEVOLUCION ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Dev.PuntoVenta)))+Convert(varchar,Dev.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Dev.NumeroDevolucion)))+Convert(varchar,Dev.NumeroDevolucion),
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM Devoluciones Dev 
 WHERE (Dev.FechaDevolucion between @Desde and DATEADD(n,1439,@hasta)) and (Dev.Anulada is not null and Dev.Anulada='SI')

UNION ALL 

 SELECT 
	Deb.FechaNotaDebito,
	'3ND',
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	IsNull(#Auxiliar3.A_NetoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravadoExportacion,0),
	Case When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9 Then 0 Else Deb.PorcentajeIva1 End,
	Case 	When Deb.TipoABC='B' and IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)<>8 
		 Then (Select Sum(IsNull(DetND.Importe,0)) From DetalleNotasDebito DetND
			Where DetND.IdNotaDebito=Deb.IdNotaDebito and DetND.Gravado='SI') / 
			(1+(Deb.PorcentajeIva1/100)) * (Deb.PorcentajeIva1/100) * Deb.CotizacionMoneda
		When Deb.TipoABC='E' or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Deb.ImporteIva1 + Deb.ImporteIva2) * Deb.CotizacionMoneda
	End,
	(IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda,
	IsNull(Deb.PercepcionIVA,0) * Deb.CotizacionMoneda,
	Deb.ImporteTotal * Deb.CotizacionMoneda,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito), 
	IsNull(#Auxiliar3.A_CtaAdicCol1,0),
	IsNull(#Auxiliar3.A_CtaAdicCol2,0),
	IsNull(#Auxiliar3.A_CtaAdicCol3,0),
	IsNull(#Auxiliar3.A_CtaAdicCol4,0),
	IsNull(#Auxiliar3.A_CtaAdicCol5,0),
	0,
	Case When IsNull(Provincias.Codigo,'')='00' Then (IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda Else 0 End,
	Case When IsNull(Provincias.Codigo,'')='01' Then (IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda Else 0 End,
	Case When IsNull(Provincias.Codigo,'')<>'00' and IsNull(Provincias.Codigo,'')<>'01' Then (IsNull(Deb.RetencionIBrutos1,0) + IsNull(Deb.RetencionIBrutos2,0) + IsNull(Deb.RetencionIBrutos3,0)) * Deb.CotizacionMoneda Else 0 End
 FROM NotasDebito Deb 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Deb.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Deb.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Deb.IdIBCondicion
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='ND' and #Auxiliar1.IdComprobante=Deb.IdNotaDebito
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdTipoComprobante=3 and #Auxiliar3.IdComprobante=Deb.IdNotaDebito
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and (Deb.Anulada is null or Deb.Anulada<>'SI') and 
	Deb.CtaCte='SI' and Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Deb.FechaNotaDebito,
	'3ND',
	'DEB '+Deb.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito),
	Null,
	'NOTA DE DEBITO ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Deb.PuntoVenta)))+Convert(varchar,Deb.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Deb.NumeroNotaDebito)))+Convert(varchar,Deb.NumeroNotaDebito), 
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM NotasDebito Deb 
 WHERE (Deb.FechaNotaDebito between @Desde and DATEADD(n,1439,@hasta)) and (Deb.Anulada is not null and Deb.Anulada='SI') and 
	Deb.CtaCte='SI' and Deb.IdNotaCreditoVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.FechaNotaCredito,
	'4NC',
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito),
	Cuentas.Codigo,
	Cli.RazonSocial,
	DescripcionIva.Descripcion,
	Cli.Cuit,
	IsNull(#Auxiliar3.A_NetoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravado,0),
	IsNull(#Auxiliar3.A_NetoNoGravadoExportacion,0),
	Case When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9 Then 0 Else Cre.PorcentajeIva1 End,
	Case When Cre.TipoABC='B' and IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)<>8 
		Then (Select Sum(IsNull(DetNC.Importe,0)) From DetalleNotasCredito DetNC
			Where DetNC.IdNotaCredito=Cre.IdNotaCredito and DetNC.Gravado='SI') / 
			(1+(Cre.PorcentajeIva1/100)) * (Cre.PorcentajeIva1/100) * 
			Cre.CotizacionMoneda * -1
		When Cre.TipoABC='E' or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=8 or IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)=9
		 Then 0
		Else (Cre.ImporteIva1 + Cre.ImporteIva2) * Cre.CotizacionMoneda * -1
	End,
	(IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1,
	IsNull(Cre.PercepcionIVA,0) * Cre.CotizacionMoneda * -1,
	Cre.ImporteTotal * Cre.CotizacionMoneda * -1,
	#Auxiliar1.IdObra,
	Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito), 
	0,
	0,
	0,
	0,
	0,
	0,
	Case When IsNull(Provincias.Codigo,'')='00' Then (IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1 Else 0 End,
	Case When IsNull(Provincias.Codigo,'')='01' Then (IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1 Else 0 End,
	Case When IsNull(Provincias.Codigo,'')<>'00' and IsNull(Provincias.Codigo,'')<>'01' Then (IsNull(Cre.RetencionIBrutos1,0) + IsNull(Cre.RetencionIBrutos2,0) + IsNull(Cre.RetencionIBrutos3,0)) * Cre.CotizacionMoneda * -1 Else 0 End
 FROM NotasCredito Cre 
 LEFT OUTER JOIN Clientes Cli ON Cli.IdCliente=Cre.IdCliente
 LEFT OUTER JOIN Cuentas ON Cuentas.IdCuenta=Cli.IdCuenta
 LEFT OUTER JOIN DescripcionIva ON DescripcionIva.IdCodigoIva=IsNull(Cre.IdCodigoIva,Cli.IdCodigoIva)
 LEFT OUTER JOIN IBCondiciones ON IBCondiciones.IdIBCondicion=Cre.IdIBCondicion
 LEFT OUTER JOIN Provincias ON Provincias.IdProvincia=IBCondiciones.IdProvincia
 LEFT OUTER JOIN #Auxiliar1 ON #Auxiliar1.Tipo='NC' and #Auxiliar1.IdComprobante=Cre.IdNotaCredito
 LEFT OUTER JOIN #Auxiliar3 ON #Auxiliar3.IdTipoComprobante=4 and #Auxiliar3.IdComprobante=Cre.IdNotaCredito
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and (Cre.Anulada is null or Cre.Anulada<>'SI') and 
	Cre.CtaCte='SI' and Cre.IdFacturaVenta_RecuperoGastos is null

UNION ALL 

 SELECT 
	Cre.FechaNotaCredito,
	'4NC',
	'CRE '+Cre.TipoABC+'-'+Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito),
	Null,
	'NOTA DE CREDITO ANULADA',
	Null,
	Null,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	Null,
	Substring('0000',1,4-Len(Convert(varchar,Cre.PuntoVenta)))+Convert(varchar,Cre.PuntoVenta)+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Cre.NumeroNotaCredito)))+Convert(varchar,Cre.NumeroNotaCredito), 
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0,
	0
 FROM NotasCredito Cre 
 WHERE (Cre.FechaNotaCredito between @Desde and DATEADD(n,1439,@hasta)) and (Cre.Anulada is not null and Cre.Anulada='SI') and 
	Cre.CtaCte='SI' and Cre.IdFacturaVenta_RecuperoGastos is null

UPDATE #Auxiliar
SET A_NetoGravado=IsNull(A_NetoGravado,0), A_NetoNoGravado=IsNull(A_NetoNoGravado,0), A_NetoNoGravadoExportacion=IsNull(A_NetoNoGravadoExportacion,0), 
	A_Iva=IsNull(A_Iva,0), A_Percepcion=IsNull(A_Percepcion,0), A_PercepcionIVA=IsNull(A_PercepcionIVA,0), A_Total=IsNull(A_Total,0), 
	A_CtaAdicCol1=IsNull(A_CtaAdicCol1,0), A_CtaAdicCol2=IsNull(A_CtaAdicCol2,0), A_CtaAdicCol3=IsNull(A_CtaAdicCol3,0), 
	A_CtaAdicCol4=IsNull(A_CtaAdicCol4,0), A_CtaAdicCol5=IsNull(A_CtaAdicCol5,0)

UPDATE #Auxiliar
SET A_AjusteDiferencia=A_Total-(A_NetoGravado+A_NetoNoGravado+A_NetoNoGravadoExportacion+A_Iva+A_Percepcion+A_PercepcionIVA+
				A_CtaAdicCol1+A_CtaAdicCol2+A_CtaAdicCol3+A_CtaAdicCol4+A_CtaAdicCol5)
UPDATE #Auxiliar
SET A_NetoGravado=A_NetoGravado+A_AjusteDiferencia, A_AjusteDiferencia=0
WHERE A_AjusteDiferencia<>0 and A_NetoGravado<>0

UPDATE #Auxiliar
SET A_NetoNoGravado=A_NetoNoGravado+A_AjusteDiferencia, A_AjusteDiferencia=0
WHERE A_AjusteDiferencia<>0 and A_NetoNoGravado<>0

UPDATE #Auxiliar
SET A_NetoNoGravadoExportacion=A_NetoNoGravadoExportacion+A_AjusteDiferencia, A_AjusteDiferencia=0
WHERE A_AjusteDiferencia<>0 and A_NetoNoGravadoExportacion<>0

SET NOCOUNT OFF

DECLARE @vector_X varchar(50), @vector_T varchar(50), @vector_E varchar(500), @vector_E1 varchar(500)
SET @vector_X='0000111111116661666'
SET @vector_T='0000947992153330333'
SET @vector_E=' FON:8,CEN | FON:8,CEN |  FON:8,LEF | FON:8,CEN | FON:8,CEN | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 |'+
		' FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 '
SET @vector_E1=' ANC:10,FON:8,CEN | ANC:16,FON:8,CEN | ANC:35,FON:8,LEF | ANC:18,FON:8,CEN | ANC:13,FON:8,CEN | ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 |'+
		' ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:6,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 | ANC:10,FON:8,NUM:#COMMA##0.00 '
IF @IdCtaAdicCol1>0
    BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
	SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 '
	SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00,VAL:1;13;'+@CtaAdicCol1+' '
    END
ELSE
    BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
    END
IF @IdCtaAdicCol2>0
    BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
	SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 '
	SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00,VAL:1;14;'+@CtaAdicCol2+' '
    END
ELSE
    BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
    END
IF @IdCtaAdicCol3>0
    BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
	SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 '
	SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00,VAL:1;15;'+@CtaAdicCol3+' '
    END
ELSE
    BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
    END
IF @IdCtaAdicCol4>0
    BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
	SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 '
	SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00,VAL:1;16;'+@CtaAdicCol4+' '
    END
ELSE
    BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
    END
IF @IdCtaAdicCol5>0
    BEGIN
	SET @vector_X=@vector_X+'6'
	SET @vector_T=@vector_T+'3'
	SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 '
	SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00,VAL:1;17'+@CtaAdicCol5+' '
    END
ELSE
    BEGIN
	SET @vector_X=@vector_X+'1'
	SET @vector_T=@vector_T+'9'
    END
SET @vector_X=@vector_X+'6666133'
SET @vector_T=@vector_T+'3333900'
SET @vector_E=@vector_E+'| FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 | FON:8,NUM:#COMMA##0.00 '
SET @vector_E1=@vector_E1+'| ANC:12,FON:8,NUM:#COMMA##0.00 | ANC:12,FON:8,NUM:#COMMA##0.00 | ANC:12,FON:8,NUM:#COMMA##0.00 | ANC:12,FON:8,NUM:#COMMA##0.00 '

SELECT 
 0 as [IdReg],
 1 as [Agrupacion],
 A_TipoComprobante as [Tipo],
 A_Comprobante1 as [Comprobante1],
 Null as [.],
 A_Fecha as [Fecha],
 A_Comprobante as [Comprobante],
 A_Cuenta as [Cuenta],
 Obras.NumeroObra as [Obra],
 A_Cliente as [Cliente],
 A_CondicionIVA as [Condicion],
 A_Cuit as [CUIT],
 Case When A_NetoGravado<>0 then A_NetoGravado Else Null End as [Gravado],
 Case When A_NetoNoGravado<>0 then A_NetoNoGravado Else Null End as [No gravado],
 Case When A_NetoNoGravadoExportacion<>0 then A_NetoNoGravadoExportacion Else Null End as [No grav. exp.],
 A_Tasa as [Tasa],
 Case When A_Iva<>0 then A_Iva Else Null End as [IVA],
 Case When A_PercepcionIVA<>0 then A_PercepcionIVA Else Null End as [Perc.IVA],
 Case When A_Percepcion<>0 then A_Percepcion Else Null End as [Perc.I.B.],
 Case When A_CtaAdicCol1<>0 then A_CtaAdicCol1 Else Null End as [CtaAdicCol1],
 Case When A_CtaAdicCol2<>0 then A_CtaAdicCol2 Else Null End as [CtaAdicCol2],
 Case When A_CtaAdicCol3<>0 then A_CtaAdicCol3 Else Null End as [CtaAdicCol3],
 Case When A_CtaAdicCol4<>0 then A_CtaAdicCol4 Else Null End as [CtaAdicCol4],
 Case When A_CtaAdicCol5<>0 then A_CtaAdicCol5 Else Null End as [CtaAdicCol5],
 Case When A_Total<>0 then A_Total Else Null End as [Total compr.],
 Case When A_PercepcionCA<>0 then A_PercepcionCA Else Null End as [Percep.IIBB Cap],
 Case When A_PercepcionBA<>0 then A_PercepcionBA Else Null End as [Percep.IIBB BsAs],
 Case When A_PercepcionOT<>0 then A_PercepcionOT Else Null End as [Percep.IIBB Otros],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar.A_IdObra

UNION ALL 

SELECT 
 0 as [IdReg],
 4 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL GENERAL' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 SUM(A_NetoNoGravado) as [No gravado],
 SUM(A_NetoNoGravadoExportacion) as [No grav. exp.],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 SUM(A_PercepcionIVA) as [Perc.IVA],
 SUM(A_Percepcion) as [Perc.I.B.],
 SUM(A_CtaAdicCol1) as [CtaAdicCol1],
 SUM(A_CtaAdicCol2) as [CtaAdicCol2],
 SUM(A_CtaAdicCol3) as [CtaAdicCol3],
 SUM(A_CtaAdicCol4) as [CtaAdicCol4],
 SUM(A_CtaAdicCol5) as [CtaAdicCol5],
 SUM(A_Total) as [Total compr.],
 SUM(A_PercepcionCA) as [Percep.IIBB Cap],
 SUM(A_PercepcionBA) as [Percep.IIBB BsAs],
 SUM(A_PercepcionOT) as [Percep.IIBB Otros],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 

UNION ALL 

SELECT 
 0 as [IdReg],
 5 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [No grav. exp.],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [CtaAdicCol1],
 Null as [CtaAdicCol2],
 Null as [CtaAdicCol3],
 Null as [CtaAdicCol4],
 Null as [CtaAdicCol5],
 Null as [Total compr.],
 Null as [Percep.IIBB Cap],
 Null as [Percep.IIBB BsAs],
 Null as [Percep.IIBB Otros],
 'FinTransporte' as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT 
 0 as [IdReg],
 6 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL IVA '+CONVERT(VARCHAR,A_Tasa)+'%' as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 Null as [No gravado],
 Null as [No grav. exp.],
 A_Tasa as [Tasa],
 SUM(A_Iva) as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [CtaAdicCol1],
 Null as [CtaAdicCol2],
 Null as [CtaAdicCol3],
 Null as [CtaAdicCol4],
 Null as [CtaAdicCol5],
 Null as [Total compr.],
 Null as [Percep.IIBB Cap],
 Null as [Percep.IIBB BsAs],
 Null as [Percep.IIBB Otros],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_Tasa<>0
GROUP BY A_Tasa
UNION ALL 

SELECT 
 0 as [IdReg],
 7 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [No grav. exp.],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [CtaAdicCol1],
 Null as [CtaAdicCol2],
 Null as [CtaAdicCol3],
 Null as [CtaAdicCol4],
 Null as [CtaAdicCol5],
 Null as [Total compr.],
 Null as [Percep.IIBB Cap],
 Null as [Percep.IIBB BsAs],
 Null as [Percep.IIBB Otros],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

UNION ALL 

SELECT 
 0 as [IdReg],
 8 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 'TOTAL '+A_CondicionIVA as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 SUM(A_NetoGravado) as [Gravado],
 Null as [No gravado],
 Null as [No grav. exp.],
 Null as [Tasa],
 SUM(A_Iva) as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [CtaAdicCol1],
 Null as [CtaAdicCol2],
 Null as [CtaAdicCol3],
 Null as [CtaAdicCol4],
 Null as [CtaAdicCol5],
 Null as [Total compr.],
 Null as [Percep.IIBB Cap],
 Null as [Percep.IIBB BsAs],
 Null as [Percep.IIBB Otros],
 @Vector_E as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X
FROM #Auxiliar 
WHERE A_Tasa<>0
GROUP BY A_CondicionIVA

UNION ALL 

SELECT 
 0 as [IdReg],
 10 as [Agrupacion],
 'zz' as [Tipo],
 Null as [Comprobante1],
 Null as [.],
 Null as [Fecha],
 Null as [Comprobante],
 Null as [Cuenta],
 Null as [Obra],
 Null as [Cliente],
 Null as [Condicion],
 Null as [CUIT],
 Null as [Gravado],
 Null as [No gravado],
 Null as [No grav. exp.],
 Null as [Tasa],
 Null as [IVA],
 Null as [Perc.IVA],
 Null as [Perc.I.B.],
 Null as [CtaAdicCol1],
 Null as [CtaAdicCol2],
 Null as [CtaAdicCol3],
 Null as [CtaAdicCol4],
 Null as [CtaAdicCol5],
 Null as [Total compr.],
 Null as [Percep.IIBB Cap],
 Null as [Percep.IIBB BsAs],
 Null as [Percep.IIBB Otros],
 @Vector_E1 as Vector_E,
 @Vector_T as Vector_T,
 @Vector_X as Vector_X

ORDER By [Agrupacion], [Fecha], [Comprobante1], [Tipo]

DROP TABLE #Auxiliar
DROP TABLE #Auxiliar0
DROP TABLE #Auxiliar1
DROP TABLE #Auxiliar2
DROP TABLE #Auxiliar3