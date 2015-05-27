CREATE PROCEDURE [dbo].[InformesContables_TX_ComprasYVentas]

@Desde datetime,
@Hasta datetime

AS

SET NOCOUNT ON

DECLARE @proc_name varchar(1000), @Formato varchar(10), @Nada varchar(1), @CuitEmpresa varchar(11), @Periodo varchar(6), @Secuencia varchar(2), 
		@SinMovimiento varchar(1), @ProrratearCreditoFiscal varchar(1), @CreditoFiscalPorComprobante varchar(1), @FechaString varchar(8)

SET @Formato='SinFormato'
SET @Nada=''

SET @CuitEmpresa=IsNull((Select Top 1 Substring(Empresa.Cuit,1,2)+Substring(Empresa.Cuit,4,8)+Substring(Empresa.Cuit,13,1) From Empresa),'')
SET @Periodo=Convert(varchar,Year(@Desde))+Substring('00',1,2-len(Convert(varchar,Month(@Desde))))+Convert(varchar,Month(@Desde))
SET @Secuencia='00'
SET @ProrratearCreditoFiscal='N'
SET @CreditoFiscalPorComprobante=' '

-- VENTAS
CREATE TABLE #Auxiliar100 
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

-- COMPRAS
CREATE TABLE #Auxiliar101 
			(
			 TipoRegistro VARCHAR(1),
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 Coeficiente INTEGER,
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 CantidadHojas VARCHAR(3),
			 AñoDelDocumento INTEGER,
			 CodigoAduana INTEGER,
			 CodigoDestinacion VARCHAR(4),
			 NumeroDespacho INTEGER,
			 DigitoVerificadorNumeroDespacho VARCHAR(1),
			 FechaDespachoAPlaza VARCHAR(8),
			 TipoDocumentoIdentificacionVendedor VARCHAR(2),
			 NumeroDocumentoIdentificacionVendedor VARCHAR(11),
			 RazonSocialVendedor VARCHAR(50),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(5,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestosNacionales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda INTEGER,
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI VARCHAR(14),
			 FechaVencimiento VARCHAR(8),
			 InformacionAdicional VARCHAR(75),
			 Registro VARCHAR(400),
			 FechaRecepcion DATETIME
			)

CREATE TABLE #Auxiliar1011 
			(
			 TipoRegistro VARCHAR(1),
			 FechaComprobante DATETIME,
			 TipoComprobante VARCHAR(2),
			 Coeficiente INTEGER,
			 ControladorFiscal VARCHAR(1),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 CantidadHojas VARCHAR(3),
			 AñoDelDocumento INTEGER,
			 CodigoAduana INTEGER,
			 CodigoDestinacion VARCHAR(4),
			 NumeroDespacho INTEGER,
			 DigitoVerificadorNumeroDespacho VARCHAR(1),
			 FechaDespachoAPlaza VARCHAR(8),
			 TipoDocumentoIdentificacionVendedor VARCHAR(2),
			 NumeroDocumentoIdentificacionVendedor VARCHAR(11),
			 RazonSocialVendedor VARCHAR(50),
			 ImporteTotal NUMERIC(19,0),
			 ImporteNoGravado NUMERIC(19,0),
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(5,0),
			 ImporteIVADiscriminado NUMERIC(19,0),
			 ImporteExento NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,0),
			 ImportePercepcionesOPagosImpuestosNacionales NUMERIC(19,0),
			 ImportePercepcionesIIBB NUMERIC(19,0),
			 ImportePercepcionesImpuestosMunicipales NUMERIC(19,0),
			 ImporteImpuestosInternos NUMERIC(19,0),
			 TipoResponsable VARCHAR(2),
			 Moneda VARCHAR(3),
			 CotizacionMoneda INTEGER,
			 CantidadAlicuotasIVA VARCHAR(1),
			 CodigoOperacion VARCHAR(1),
			 CAI VARCHAR(14),
			 FechaVencimiento VARCHAR(8),
			 InformacionAdicional VARCHAR(75),
			 Registro VARCHAR(400),
			 FechaRecepcion DATETIME
			)

-- TXT COMPRAS Y VENTAS
CREATE TABLE #Auxiliar200 
			(
			 TipoRegistro VARCHAR(1),
			 Fecha DATETIME,
			 Registro VARCHAR(400)
			)

-- REGISTROS DE IVAS
CREATE TABLE #Auxiliar201 
			(
			 IdAux INTEGER IDENTITY (1, 1), 
			 TipoComprobante VARCHAR(2),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 Fecha DATETIME,
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(5,0),
			 ImporteIVA NUMERIC(19,0)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar201 ON #Auxiliar201 (TipoComprobante, PuntoVenta, NumeroComprobante) ON [PRIMARY]

CREATE TABLE #Auxiliar202 
			(
			 TipoRegistro VARCHAR(1),
			 Fecha DATETIME,
			 Registro VARCHAR(400),
			 PuntoVenta INTEGER,
			 NumeroComprobante INTEGER,
			 NumeroDocumentoIdentificacionVendedor VARCHAR(20),
			 ImporteGravado NUMERIC(19,0),
			 AlicuotaIVA NUMERIC(5,0),
			 CodigoAlicuotaIVA VARCHAR(4),
			 ImporteIVADiscriminado NUMERIC(19,0)
			)


SET @proc_name='InformesContables_TX_1361_Ventas'
INSERT INTO #Auxiliar100 
	EXECUTE @proc_name @Desde, @Hasta, @Formato


SET @proc_name='InformesContables_TX_1361_Compras'
INSERT INTO #Auxiliar1011 
	EXECUTE @proc_name @Desde, @Hasta, @Nada, @Formato

INSERT INTO #Auxiliar101
 SELECT TipoRegistro, FechaComprobante, TipoComprobante, Coeficiente, ControladorFiscal, PuntoVenta, NumeroComprobante, CantidadHojas, AñoDelDocumento, CodigoAduana, 
		CodigoDestinacion, NumeroDespacho, DigitoVerificadorNumeroDespacho, FechaDespachoAPlaza, TipoDocumentoIdentificacionVendedor, NumeroDocumentoIdentificacionVendedor, 
		RazonSocialVendedor, Sum(IsNull(ImporteTotal,0)), Sum(IsNull(ImporteNoGravado,0)), Sum(IsNull(ImporteGravado,0)), Max(AlicuotaIVA), Sum(IsNull(ImporteIVADiscriminado,0)), 
		Sum(IsNull(ImporteExento,0)), Sum(IsNull(ImportePercepcionesOPagosImpuestoAlValorAgregado,0)), Sum(IsNull(ImportePercepcionesOPagosImpuestosNacionales,0)), 
		Sum(IsNull(ImportePercepcionesIIBB,0)), Sum(IsNull(ImportePercepcionesImpuestosMunicipales,0)), Sum(IsNull(ImporteImpuestosInternos,0)), TipoResponsable, 
		Moneda, CotizacionMoneda, CantidadAlicuotasIVA, CodigoOperacion, CAI, FechaVencimiento, InformacionAdicional, '', FechaRecepcion
 FROM #Auxiliar1011
 GROUP BY TipoRegistro, FechaComprobante, TipoComprobante, Coeficiente, ControladorFiscal, PuntoVenta, NumeroComprobante, CantidadHojas, AñoDelDocumento, CodigoAduana, 
			CodigoDestinacion, NumeroDespacho, DigitoVerificadorNumeroDespacho, FechaDespachoAPlaza, TipoDocumentoIdentificacionVendedor, NumeroDocumentoIdentificacionVendedor, 
			RazonSocialVendedor, TipoResponsable, Moneda, CotizacionMoneda, CantidadAlicuotasIVA, CodigoOperacion, CAI, FechaVencimiento, InformacionAdicional, FechaRecepcion
 ORDER BY TipoRegistro, FechaComprobante, TipoComprobante, PuntoVenta, NumeroComprobante

SET @SinMovimiento='N'
IF IsNull((Select Count(*) From #Auxiliar100),0)=0 and IsNull((Select Count(*) From #Auxiliar101),0)=0
	SET @SinMovimiento='S'

--select * from #Auxiliar101 order by TipoRegistro, FechaComprobante, TipoComprobante, PuntoVenta, NumeroComprobante

INSERT INTO #Auxiliar200 
(TipoRegistro, Fecha, Registro) 
VALUES 
('1', Null, 
 @CuitEmpresa+
 @Periodo+
 @Secuencia+
 @SinMovimiento+
 @ProrratearCreditoFiscal+
 @CreditoFiscalPorComprobante+
 '000000000000000'+
 '000000000000000'+
 '000000000000000'+
 '000000000000000'+
 '000000000000000'+
 '000000000000000')


DECLARE @TipoRegistro varchar(1), @FechaComprobante datetime, @TipoComprobante varchar(2), @ControladorFiscal varchar(1), @PuntoVenta int,
		@NumeroComprobante int, @NumeroComprobanteHasta int, @TipoDocumentoIdentificacion varchar(2), @NumeroDocumentoIdentificacion varchar(11),
		@RazonSocial varchar(50), @ImporteTotal numeric(19,0), @ImporteNoGravado numeric(19,0), @ImporteGravado numeric(19,0), @AlicuotaIVA numeric(4,0),
		@ImporteIVADiscriminado numeric(19,0), @ImporteIVAAcrecentamiento numeric(19,0), @ImporteExento numeric(19,0), @ImportePagoACuentaImpuestosMunicipales numeric(19,0),
		@ImportePercepcionesIIBB numeric(19,0), @ImportePercepcionesImpuestosMunicipales numeric(19,0), @ImporteImpuestosInternos numeric(19,0), 
		@TipoResponsable varchar(2), @Moneda varchar(3), @CotizacionMoneda int, @CantidadAlicuotasIVA varchar(1), @CodigoOperacion varchar(1), @CAI numeric(19,0),
		@FechaVencimiento varchar(8), @FechaAnulacion varchar(8), @InformacionAdicional varchar(75), @Registro varchar(400), @IdAux int, 
		@Coeficiente INTEGER, @CantidadHojas VARCHAR(3), @AñoDelDocumento INTEGER, @CodigoAduana INTEGER, @CodigoDestinacion VARCHAR(4), @NumeroDespacho INTEGER,
		@DigitoVerificadorNumeroDespacho VARCHAR(1), @FechaDespachoAPlaza VARCHAR(8), @TipoDocumentoIdentificacionVendedor VARCHAR(2), 
		@NumeroDocumentoIdentificacionVendedor VARCHAR(11), @RazonSocialVendedor VARCHAR(50), @ImportePercepcionesOPagosImpuestoAlValorAgregado NUMERIC(19,0), 
		@ImportePercepcionesOPagosImpuestosNacionales NUMERIC(19,0), @FechaRecepcion DATETIME, @TipoDocumentoIdentificacionVendedor_CUIT VARCHAR(2), @CodigoAlicuotaIVA VARCHAR(4),
		@TipoDocumentoIdentificacionVendedor_Otros VARCHAR(2)

SET @TipoDocumentoIdentificacionVendedor_CUIT='80'
SET @TipoDocumentoIdentificacionVendedor_Otros='99'

TRUNCATE TABLE #Auxiliar201

-- VENTAS --

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT TipoRegistro, FechaComprobante, TipoComprobante, ControladorFiscal, PuntoVenta, NumeroComprobante, NumeroComprobanteHasta, TipoDocumentoIdentificacion,
			   NumeroDocumentoIdentificacion, RazonSocial, ImporteTotal, ImporteNoGravado, ImporteGravado, AlicuotaIVA, ImporteIVADiscriminado, ImporteIVAAcrecentamiento,
			   ImporteExento, ImportePagoACuentaImpuestosMunicipales, ImportePercepcionesIIBB, ImportePercepcionesImpuestosMunicipales, ImporteImpuestosInternos,
			   TipoResponsable, Moneda, CotizacionMoneda, CantidadAlicuotasIVA, CodigoOperacion, CAI, FechaVencimiento, FechaAnulacion, InformacionAdicional, Registro
		FROM #Auxiliar100
		ORDER BY PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @NumeroComprobanteHasta, @TipoDocumentoIdentificacion,
						 @NumeroDocumentoIdentificacion, @RazonSocial, @ImporteTotal, @ImporteNoGravado, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteIVAAcrecentamiento,
						 @ImporteExento, @ImportePagoACuentaImpuestosMunicipales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos,
						 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @FechaAnulacion, @InformacionAdicional, @Registro
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @FechaString=Convert(varchar,Year(@FechaComprobante))+
						Substring('00',1,2-len(Convert(varchar,Month(@FechaComprobante))))+Convert(varchar,Month(@FechaComprobante))+			
						Substring('00',1,2-len(Convert(varchar,Day(@FechaComprobante))))+Convert(varchar,Day(@FechaComprobante))
	IF IsNull(@PuntoVenta,0)=0
		SET @PuntoVenta=1

--select @TipoRegistro,@PuntoVenta,@NumeroComprobante,@TipoDocumentoIdentificacion,@NumeroDocumentoIdentificacion,@RazonSocial,
--		@ImporteTotal,@ImporteNoGravado,@ImporteExento,@ImportePagoACuentaImpuestosMunicipales,@ImportePercepcionesIIBB,
--		@ImportePagoACuentaImpuestosMunicipales,@ImporteImpuestosInternos,@Moneda,@CotizacionMoneda,@CantidadAlicuotasIVA,@FechaVencimiento

	INSERT INTO #Auxiliar200 
	(TipoRegistro, Fecha, Registro) 
	VALUES 
	('2', @FechaComprobante, 
	 @FechaString+
	 '00'+@TipoRegistro+
	 Substring('00000',1,5-len(Convert(varchar,@PuntoVenta)))+Convert(varchar,@PuntoVenta)+
	 Substring('00000000000000000000',1,20-len(Convert(varchar,@NumeroComprobante)))+Convert(varchar,@NumeroComprobante)+
	 Substring('00000000000000000000',1,20-len(Convert(varchar,@NumeroComprobante)))+Convert(varchar,@NumeroComprobante)+
	 Case When Len(lTrim(@NumeroDocumentoIdentificacion))=0 Then @TipoDocumentoIdentificacionVendedor_Otros Else @TipoDocumentoIdentificacion End+
	 Substring('00000000000000000000',1,20-len(@NumeroDocumentoIdentificacion))+@NumeroDocumentoIdentificacion+
	 Substring(@RazonSocial+'                              ',1,30)+
	 Case When @ImporteTotal>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteTotal)))+Convert(varchar,@ImporteTotal)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteTotal))))+Convert(varchar,Abs(@ImporteTotal)) 
	 End+
	 Case When @ImporteNoGravado>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteNoGravado)))+Convert(varchar,@ImporteNoGravado)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteNoGravado))))+Convert(varchar,Abs(@ImporteNoGravado)) 
	 End+
	 '000000000000000'+
	 Case When @ImporteExento>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteExento)))+Convert(varchar,@ImporteExento)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteExento))))+Convert(varchar,Abs(@ImporteExento)) 
	 End+
	 Case When @ImportePagoACuentaImpuestosMunicipales>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,@ImportePagoACuentaImpuestosMunicipales)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePagoACuentaImpuestosMunicipales))))+Convert(varchar,Abs(@ImportePagoACuentaImpuestosMunicipales)) 
	 End+
	 Case When @ImportePercepcionesIIBB>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePercepcionesIIBB)))+Convert(varchar,@ImportePercepcionesIIBB)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePercepcionesIIBB))))+Convert(varchar,Abs(@ImportePercepcionesIIBB)) 
	 End+
	 Case When @ImportePercepcionesImpuestosMunicipales>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,@ImportePercepcionesImpuestosMunicipales)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePercepcionesImpuestosMunicipales))))+Convert(varchar,Abs(@ImportePercepcionesImpuestosMunicipales)) 
	 End+
	 Case When @ImporteImpuestosInternos>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteImpuestosInternos)))+Convert(varchar,@ImporteImpuestosInternos)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteImpuestosInternos))))+Convert(varchar,Abs(@ImporteImpuestosInternos)) 
	 End+
	 IsNull(@Moneda,'   ')+
	 Substring('0000000000',1,10-len(Convert(varchar,@CotizacionMoneda)))+Convert(varchar,@CotizacionMoneda)+
	 Case When Len(IsNull(@CantidadAlicuotasIVA,''))<>1 Then '0' Else @CantidadAlicuotasIVA End+
	 ' '+
	 '000000000000000'+
	 @FechaString
	)

	SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar201 Where TipoComprobante=@TipoComprobante and PuntoVenta=@PuntoVenta and NumeroComprobante=@NumeroComprobante),0)
	IF @IdAux=0
		INSERT INTO #Auxiliar201 
		(TipoComprobante, PuntoVenta, NumeroComprobante, Fecha, ImporteGravado, AlicuotaIVA, ImporteIVA) 
		VALUES 
		(@TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado)
	ELSE
		UPDATE #Auxiliar201
		SET ImporteGravado=IsNull(ImporteGravado,0)+@ImporteGravado, ImporteIVA=IsNull(ImporteIVA,0)+@ImporteIVADiscriminado
		WHERE IdAux=@IdAux

	FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @NumeroComprobanteHasta, @TipoDocumentoIdentificacion,
							 @NumeroDocumentoIdentificacion, @RazonSocial, @ImporteTotal, @ImporteNoGravado, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteIVAAcrecentamiento,
							 @ImporteExento, @ImportePagoACuentaImpuestosMunicipales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos,
							 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @FechaAnulacion, @InformacionAdicional, @Registro
  END
CLOSE Cur
DEALLOCATE Cur


DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT TipoComprobante, PuntoVenta, NumeroComprobante, Fecha, ImporteGravado, AlicuotaIVA, ImporteIVA
		FROM #Auxiliar201
		ORDER BY TipoComprobante, PuntoVenta, NumeroComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @CodigoAlicuotaIVA=Case When @AlicuotaIVA=0 Then Case When @ImporteIVADiscriminado>0 Then '0005' Else '0003' End
								When @AlicuotaIVA=1050 Then '0004' 
								When @AlicuotaIVA=2100 Then '0005' 
								When @AlicuotaIVA=2700 Then '0006' 
								When @AlicuotaIVA=500 Then '0008' 
								When @AlicuotaIVA=250 Then '0009' 
								Else '0003' End
	SET @Registro = '00'+@TipoRegistro+
					Substring('00000',1,5-len(Convert(varchar,@PuntoVenta)))+Convert(varchar,@PuntoVenta)+
					Substring('00000000000000000000',1,20-len(Convert(varchar,@NumeroComprobante)))+Convert(varchar,@NumeroComprobante)+
					Case When @ImporteGravado>=0 
							Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteGravado)))+Convert(varchar,@ImporteGravado)
							Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteGravado))))+Convert(varchar,Abs(@ImporteGravado)) 
					End+
					@CodigoAlicuotaIVA+
					--Substring('0000',1,4-len(Convert(varchar,@AlicuotaIVA)))+Convert(varchar,@AlicuotaIVA)+
					Case When @ImporteIVADiscriminado>=0 
							Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteIVADiscriminado)))+Convert(varchar,@ImporteIVADiscriminado)
							Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteIVADiscriminado))))+Convert(varchar,Abs(@ImporteIVADiscriminado)) 
					End

	INSERT INTO #Auxiliar200 
	(TipoRegistro, Fecha, Registro) 
	VALUES 
	('3', @FechaComprobante, @Registro)

	FETCH NEXT FROM Cur INTO @TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado
  END
CLOSE Cur
DEALLOCATE Cur


-- COMPRAS --

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT TipoRegistro, FechaComprobante, TipoComprobante, Coeficiente, ControladorFiscal, PuntoVenta, NumeroComprobante, CantidadHojas, AñoDelDocumento,
			   CodigoAduana, CodigoDestinacion, NumeroDespacho, DigitoVerificadorNumeroDespacho, FechaDespachoAPlaza, TipoDocumentoIdentificacionVendedor,
			   NumeroDocumentoIdentificacionVendedor, RazonSocialVendedor, ImporteTotal, ImporteNoGravado, ImporteGravado, AlicuotaIVA, ImporteIVADiscriminado,
			   ImporteExento, ImportePercepcionesOPagosImpuestoAlValorAgregado, ImportePercepcionesOPagosImpuestosNacionales, ImportePercepcionesIIBB,
			   ImportePercepcionesImpuestosMunicipales, ImporteImpuestosInternos, TipoResponsable, Moneda, CotizacionMoneda, CantidadAlicuotasIVA, CodigoOperacion,
			   CAI, FechaVencimiento, InformacionAdicional, Registro, FechaRecepcion
		FROM #Auxiliar101
		ORDER BY PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @Coeficiente, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @CantidadHojas, 
						 @AñoDelDocumento, @CodigoAduana, @CodigoDestinacion, @NumeroDespacho, @DigitoVerificadorNumeroDespacho, @FechaDespachoAPlaza, 
						 @TipoDocumentoIdentificacionVendedor, @NumeroDocumentoIdentificacionVendedor, @RazonSocialVendedor, @ImporteTotal, @ImporteNoGravado, 
						 @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteExento, @ImportePercepcionesOPagosImpuestoAlValorAgregado, 
						 @ImportePercepcionesOPagosImpuestosNacionales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos, 
						 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @InformacionAdicional, 
						 @Registro, @FechaRecepcion
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @FechaString=Convert(varchar,Year(@FechaComprobante))+
						Substring('00',1,2-len(Convert(varchar,Month(@FechaComprobante))))+Convert(varchar,Month(@FechaComprobante))+			
						Substring('00',1,2-len(Convert(varchar,Day(@FechaComprobante))))+Convert(varchar,Day(@FechaComprobante))
	SET @RazonSocialVendedor=IsNull(@RazonSocialVendedor,'')
	IF IsNull(@PuntoVenta,0)=0
		SET @PuntoVenta=1
	
	--select @FechaString,@TipoRegistro,@PuntoVenta,@NumeroComprobante,@NumeroDespacho,@TipoDocumentoIdentificacionVendedor,@NumeroDocumentoIdentificacionVendedor,
	--		@RazonSocialVendedor,@ImporteTotal,@ImporteNoGravado,@ImporteExento,@ImportePagoACuentaImpuestosMunicipales,@ImportePercepcionesIIBB,
	--		@ImportePercepcionesImpuestosMunicipales,@ImporteImpuestosInternos,@Moneda,@CotizacionMoneda,@CantidadAlicuotasIVA,@ImporteIVADiscriminado
	
	INSERT INTO #Auxiliar200 
	(TipoRegistro, Fecha, Registro) 
	VALUES 
	('4', @FechaComprobante, 
	 @FechaString+
	 Case When Len(@RazonSocialVendedor)>0 Then '00'+@TipoRegistro Else '099' End+
	 Substring('00000',1,5-len(Convert(varchar,@PuntoVenta)))+Convert(varchar,@PuntoVenta)+
	 Substring('00000000000000000000',1,20-len(Convert(varchar,@NumeroComprobante)))+Convert(varchar,@NumeroComprobante)+
	 Case When IsNull(@NumeroDespacho,0)=0 Then '                ' Else Substring('0000000000000000',1,16-len(Convert(varchar,@NumeroDespacho)))+Convert(varchar,@NumeroDespacho) End+
	 Case When Len(lTrim(@NumeroDocumentoIdentificacionVendedor))=0 Then @TipoDocumentoIdentificacionVendedor_Otros Else @TipoDocumentoIdentificacion End+
	 Substring('00000000000000000000',1,20-len(@NumeroDocumentoIdentificacionVendedor))+@NumeroDocumentoIdentificacionVendedor+
	 Substring(Case When len(IsNull(@RazonSocialVendedor,''))=0 Then 'S/D' Else @RazonSocialVendedor End+'                              ',1,30)+
	 Case When @ImporteTotal>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteTotal)))+Convert(varchar,@ImporteTotal)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteTotal))))+Convert(varchar,Abs(@ImporteTotal)) 
	 End+
	 Case When @ImporteNoGravado>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteNoGravado)))+Convert(varchar,@ImporteNoGravado)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteNoGravado))))+Convert(varchar,Abs(@ImporteNoGravado)) 
	 End+
	 Case When @ImporteExento>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteExento)))+Convert(varchar,@ImporteExento)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteExento))))+Convert(varchar,Abs(@ImporteExento)) 
	 End+
	 '000000000000000'+
	 Case When @ImportePagoACuentaImpuestosMunicipales>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePagoACuentaImpuestosMunicipales)))+Convert(varchar,@ImportePagoACuentaImpuestosMunicipales)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePagoACuentaImpuestosMunicipales))))+Convert(varchar,Abs(@ImportePagoACuentaImpuestosMunicipales)) 
	 End+
	 Case When @ImportePercepcionesIIBB>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePercepcionesIIBB)))+Convert(varchar,@ImportePercepcionesIIBB)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePercepcionesIIBB))))+Convert(varchar,Abs(@ImportePercepcionesIIBB)) 
	 End+
	 Case When @ImportePercepcionesImpuestosMunicipales>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImportePercepcionesImpuestosMunicipales)))+Convert(varchar,@ImportePercepcionesImpuestosMunicipales)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImportePercepcionesImpuestosMunicipales))))+Convert(varchar,Abs(@ImportePercepcionesImpuestosMunicipales)) 
	 End+

	 Case When @ImporteImpuestosInternos>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteImpuestosInternos)))+Convert(varchar,@ImporteImpuestosInternos)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteImpuestosInternos))))+Convert(varchar,Abs(@ImporteImpuestosInternos)) 
	 End+

	 IsNull(@Moneda,'   ')+
	 Substring('0000000000',1,10-len(Convert(varchar,@CotizacionMoneda)))+Convert(varchar,@CotizacionMoneda)+
	 Case When Len(IsNull(@CantidadAlicuotasIVA,''))<>1 Then '0' Else @CantidadAlicuotasIVA End+
	 ' '+
	 Case When @ImporteIVADiscriminado>=0 
			Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteIVADiscriminado)))+Convert(varchar,@ImporteIVADiscriminado)
			Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteIVADiscriminado))))+Convert(varchar,Abs(@ImporteIVADiscriminado)) 
	 End+
	 '000000000000000'+
	 '00000000000'+
	 '                              '+
	 '000000000000000'
	)

	FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @Coeficiente, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @CantidadHojas, 
							 @AñoDelDocumento, @CodigoAduana, @CodigoDestinacion, @NumeroDespacho, @DigitoVerificadorNumeroDespacho, @FechaDespachoAPlaza, 
							 @TipoDocumentoIdentificacionVendedor, @NumeroDocumentoIdentificacionVendedor, @RazonSocialVendedor, @ImporteTotal, @ImporteNoGravado, 
							 @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteExento, @ImportePercepcionesOPagosImpuestoAlValorAgregado, 
							 @ImportePercepcionesOPagosImpuestosNacionales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos, 
							 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @InformacionAdicional, 
							 @Registro, @FechaRecepcion
  END
CLOSE Cur
DEALLOCATE Cur


TRUNCATE TABLE #Auxiliar201

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT TipoRegistro, FechaComprobante, TipoComprobante, Coeficiente, ControladorFiscal, PuntoVenta, NumeroComprobante, CantidadHojas, AñoDelDocumento,
			   CodigoAduana, CodigoDestinacion, NumeroDespacho, DigitoVerificadorNumeroDespacho, FechaDespachoAPlaza, TipoDocumentoIdentificacionVendedor,
			   NumeroDocumentoIdentificacionVendedor, RazonSocialVendedor, ImporteTotal, ImporteNoGravado, ImporteGravado, AlicuotaIVA, ImporteIVADiscriminado,
			   ImporteExento, ImportePercepcionesOPagosImpuestoAlValorAgregado, ImportePercepcionesOPagosImpuestosNacionales, ImportePercepcionesIIBB,
			   ImportePercepcionesImpuestosMunicipales, ImporteImpuestosInternos, TipoResponsable, Moneda, CotizacionMoneda, CantidadAlicuotasIVA, CodigoOperacion,
			   CAI, FechaVencimiento, InformacionAdicional, Registro, FechaRecepcion
		FROM #Auxiliar1011
		ORDER BY PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @Coeficiente, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @CantidadHojas, 
						 @AñoDelDocumento, @CodigoAduana, @CodigoDestinacion, @NumeroDespacho, @DigitoVerificadorNumeroDespacho, @FechaDespachoAPlaza, 
						 @TipoDocumentoIdentificacionVendedor, @NumeroDocumentoIdentificacionVendedor, @RazonSocialVendedor, @ImporteTotal, @ImporteNoGravado, 
						 @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteExento, @ImportePercepcionesOPagosImpuestoAlValorAgregado, 
						 @ImportePercepcionesOPagosImpuestosNacionales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos, 
						 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @InformacionAdicional, 
						 @Registro, @FechaRecepcion
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @FechaString=Convert(varchar,Year(@FechaComprobante))+
						Substring('00',1,2-len(Convert(varchar,Month(@FechaComprobante))))+Convert(varchar,Month(@FechaComprobante))+			
						Substring('00',1,2-len(Convert(varchar,Day(@FechaComprobante))))+Convert(varchar,Day(@FechaComprobante))
	SET @RazonSocialVendedor=IsNull(@RazonSocialVendedor,'')
	
	SET @IdAux=IsNull((Select Top 1 IdAux From #Auxiliar201 Where TipoComprobante=@TipoComprobante and PuntoVenta=@PuntoVenta and NumeroComprobante=@NumeroComprobante),0)
	IF @IdAux=0
		INSERT INTO #Auxiliar201 
		(TipoComprobante, PuntoVenta, NumeroComprobante, Fecha, ImporteGravado, AlicuotaIVA, ImporteIVA) 
		VALUES 
		(@TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado)
	ELSE
		UPDATE #Auxiliar201
		SET ImporteGravado=IsNull(ImporteGravado,0)+@ImporteGravado, ImporteIVA=IsNull(ImporteIVA,0)+@ImporteIVADiscriminado
		WHERE IdAux=@IdAux

	FETCH NEXT FROM Cur INTO @TipoRegistro, @FechaComprobante, @TipoComprobante, @Coeficiente, @ControladorFiscal, @PuntoVenta, @NumeroComprobante, @CantidadHojas, 
							 @AñoDelDocumento, @CodigoAduana, @CodigoDestinacion, @NumeroDespacho, @DigitoVerificadorNumeroDespacho, @FechaDespachoAPlaza, 
							 @TipoDocumentoIdentificacionVendedor, @NumeroDocumentoIdentificacionVendedor, @RazonSocialVendedor, @ImporteTotal, @ImporteNoGravado, 
							 @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado, @ImporteExento, @ImportePercepcionesOPagosImpuestoAlValorAgregado, 
							 @ImportePercepcionesOPagosImpuestosNacionales, @ImportePercepcionesIIBB, @ImportePercepcionesImpuestosMunicipales, @ImporteImpuestosInternos, 
							 @TipoResponsable, @Moneda, @CotizacionMoneda, @CantidadAlicuotasIVA, @CodigoOperacion, @CAI, @FechaVencimiento, @InformacionAdicional, 
							 @Registro, @FechaRecepcion
  END
CLOSE Cur
DEALLOCATE Cur

DECLARE Cur CURSOR LOCAL FORWARD_ONLY FOR 
		SELECT TipoComprobante, PuntoVenta, NumeroComprobante, Fecha, ImporteGravado, AlicuotaIVA, ImporteIVA
		FROM #Auxiliar201
		ORDER BY TipoComprobante, PuntoVenta, NumeroComprobante
OPEN Cur
FETCH NEXT FROM Cur INTO @TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado
WHILE @@FETCH_STATUS = 0
  BEGIN
	SET @CodigoAlicuotaIVA=Case When @AlicuotaIVA=0 Then Case When @ImporteIVADiscriminado>0 Then '0005' Else '0003' End
								When @AlicuotaIVA=1050 Then '0004' 
								When @AlicuotaIVA=2100 Then '0005' 
								When @AlicuotaIVA=2700 Then '0006' 
								When @AlicuotaIVA=500 Then '0008' 
								When @AlicuotaIVA=250 Then '0009' 
								Else '0003' End
	SET @Registro =	'00'+@TipoRegistro+
					Substring('00000',1,5-len(Convert(varchar,@PuntoVenta)))+Convert(varchar,@PuntoVenta)+
					Substring('00000000000000000000',1,20-len(Convert(varchar,@NumeroComprobante)))+Convert(varchar,@NumeroComprobante)+
					@TipoDocumentoIdentificacionVendedor_CUIT+ --@TipoDocumentoIdentificacionVendedor+
					Substring('00000000000000000000',1,20-len(@NumeroDocumentoIdentificacionVendedor))+@NumeroDocumentoIdentificacionVendedor+
					Case When @ImporteGravado>=0 
							Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteGravado)))+Convert(varchar,@ImporteGravado)
							Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteGravado))))+Convert(varchar,Abs(@ImporteGravado)) 
					End+
					@CodigoAlicuotaIVA+
					--Substring('0000',1,4-len(Convert(varchar,@AlicuotaIVA)))+Convert(varchar,@AlicuotaIVA)+
					Case When @ImporteIVADiscriminado>=0 
							Then Substring('000000000000000',1,15-len(Convert(varchar,@ImporteIVADiscriminado)))+Convert(varchar,@ImporteIVADiscriminado)
							Else '-'+Substring('00000000000000',1,14-len(Convert(varchar,Abs(@ImporteIVADiscriminado))))+Convert(varchar,Abs(@ImporteIVADiscriminado)) 
					End
  
	INSERT INTO #Auxiliar200 
	(TipoRegistro, Fecha, Registro) 
	VALUES 
	('5', @FechaComprobante, @Registro)

	INSERT INTO #Auxiliar202 
	(TipoRegistro, Fecha, Registro, PuntoVenta, NumeroComprobante, NumeroDocumentoIdentificacionVendedor, ImporteGravado, AlicuotaIVA, CodigoAlicuotaIVA, ImporteIVADiscriminado) 
	VALUES 
	('5', @FechaComprobante, @Registro, @PuntoVenta, @NumeroComprobante, @NumeroDocumentoIdentificacionVendedor, @ImporteGravado, @AlicuotaIVA, @CodigoAlicuotaIVA, @ImporteIVADiscriminado)

	FETCH NEXT FROM Cur INTO @TipoComprobante, @PuntoVenta, @NumeroComprobante, @FechaComprobante, @ImporteGravado, @AlicuotaIVA, @ImporteIVADiscriminado
  END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

--select * from #Auxiliar100 order by PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
--select * from #Auxiliar101 order by PuntoVenta, TipoRegistro, TipoComprobante, NumeroComprobante, FechaComprobante
--select * from #Auxiliar202 order by CodigoAlicuotaIVA,TipoRegistro, Fecha, Registro 

SELECT 
 0 as [IdAux],
 TipoRegistro as [Tipo de registro],
 Fecha as [Fecha],
 Registro as [Registro]
FROM #Auxiliar200
ORDER BY TipoRegistro, Fecha, Registro 

DROP TABLE #Auxiliar100
DROP TABLE #Auxiliar101
DROP TABLE #Auxiliar1011
DROP TABLE #Auxiliar200
DROP TABLE #Auxiliar201
DROP TABLE #Auxiliar202
