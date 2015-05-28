CREATE Procedure [dbo].[OrdenesPago_A]

@IdOrdenPago int  output,
@NumeroOrdenPago int,
@FechaOrdenPago datetime,
@IdProveedor int,
@Efectivo numeric(12,2),
@Descuentos numeric(12,2),
@Valores numeric(12,2),
@Documentos numeric(12,2),
@Otros1 numeric(12,2),
@IdCuenta1 int,
@Otros2 numeric(12,2),
@IdCuenta2 int,
@Otros3 numeric(12,2),
@IdCuenta3 int,
@Acreedores numeric(12,2),
@RetencionIVA numeric(12,2),
@RetencionGanancias numeric(12,2),
@RetencionIBrutos numeric(12,2),
@GastosGenerales numeric(12,2),
@Estado varchar(2),
@IdCuenta int,
@Tipo varchar(2),
@Anulada varchar(2),
@CotizacionDolar numeric(18,4),
@Dolarizada varchar(2),
@Exterior varchar(2),
@NumeroCertificadoRetencionGanancias int,
@BaseGanancias numeric(18,2),
@IdMoneda int,
@CotizacionMoneda numeric(18,4),
@AsientoManual varchar(2),
@Observaciones ntext,
@IdObra int,
@IdCuentaGasto int,
@DiferenciaBalanceo numeric(18,2),
@IdOPComplementariaFF int,
@IdEmpleadoFF int,
@NumeroCertificadoRetencionIVA int,
@NumeroCertificadoRetencionIIBB int,
@RetencionSUSS numeric(18,2),
@NumeroCertificadoRetencionSUSS int,
@TipoOperacionOtros int,
@IdUsuarioIngreso int,
@FechaIngreso datetime,
@IdUsuarioModifico int,
@FechaModifico datetime,
@Confirmado varchar(2),
@IdObraOrigen int,
@CotizacionEuro numeric(18,4),
@TipoGrabacion varchar(1),
@IdProvinciaDestino int,
@CalculaSUSS varchar(2),
@RetencionIVAComprobantesM numeric(18,2),
@IdUsuarioAnulo int,
@FechaAnulacion datetime,
@MotivoAnulacion ntext,
@NumeroRendicionFF int,
@ConfirmacionAcreditacionFF varchar(2),
@OPInicialFF varchar(2),
@IdConcepto int,
@IdConcepto2 int,
@FormaAnulacionCheques varchar(1),
@Detalle varchar(20),
@RecalculoRetencionesUltimaModificacion varchar(2),
@IdImpuestoDirecto int,
@NumeroReciboProveedor int,
@FechaReciboProveedor datetime,
@TextoAuxiliar1 varchar(100),
@TextoAuxiliar2 varchar(100),
@TextoAuxiliar3 varchar(100),
@IdsComprobanteProveedorRetenidosIva varchar(100),
@TotalesImportesRetenidosIva varchar(100),
@ReversionContablePorAnulacion varchar(2)

AS

BEGIN TRAN
   BEGIN
	DECLARE @NumeracionAutomaticaDeOrdenesDePago varchar(2), @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE varchar(2), @NumeracionUnicaDeOrdenesDePago varchar(2), @Existe int, 
			@NumeroOP int, @NumeroOP1 int, @NumeroOP2 int, @NumeroOP3 int, @NumeroOP4 int, @IdEjercicioContableControlNumeracion int, @FechaInicioControl datetime

	SET @NumeracionAutomaticaDeOrdenesDePago=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='NumeracionAutomaticaDeOrdenesDePago'),'NO')
	SET @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='NumeracionIndependienteDeOrdenesDePagoFFyCTACTE'),'NO')
	SET @NumeracionUnicaDeOrdenesDePago=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='NumeracionUnicaDeOrdenesDePago'),'NO')
	SET @NumeroOP1=IsNull((Select Top 1 ProximaOrdenPago From Parametros Where IdParametro=1),1)
	SET @NumeroOP2=IsNull((Select Top 1 ProximaOrdenPagoOtros From Parametros Where IdParametro=1),1)
	SET @NumeroOP3=IsNull((Select Top 1 ProximaOrdenPagoFF From Parametros Where IdParametro=1),1)
	SET @NumeroOP4=IsNull((Select Top 1 ProximaOrdenPagoExterior From Parametros Where IdParametro=1),1)
	SET @IdEjercicioContableControlNumeracion=IsNull((Select Top 1 P2.Valor From Parametros2 P2 Where P2.Campo='IdEjercicioContableControlNumeracion'),0)
	IF @IdEjercicioContableControlNumeracion<>0
		SET @FechaInicioControl=IsNull((Select Top 1 FechaInicio From EjerciciosContables Where IdEjercicioContable=@IdEjercicioContableControlNumeracion),Convert(datetime,'01/01/2000'))
	ELSE
		SET @FechaInicioControl=Convert(datetime,'01/01/2000')

	IF @NumeracionUnicaDeOrdenesDePago='SI'
		SET @NumeroOP=@NumeroOP1
	ELSE
		IF @Exterior='SI'
			SET @NumeroOP=@NumeroOP4
		ELSE
			IF @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='SI'
			    BEGIN
				IF @Tipo='CC'
					SET @NumeroOP=@NumeroOP1
				IF  @Tipo='FF'
					SET @NumeroOP=@NumeroOP3
				IF  @Tipo='OT'
					SET @NumeroOP=@NumeroOP2
			    END
			ELSE
				IF @Tipo='CC' or @Tipo='FF'
					SET @NumeroOP=@NumeroOP1
				ELSE
					SET @NumeroOP=@NumeroOP2

	WHILE Exists(Select Top 1 IdOrdenPago
			From OrdenesPago 
			Where NumeroOrdenPago=@NumeroOP and FechaOrdenPago>=@FechaInicioControl and 
				(@NumeracionUnicaDeOrdenesDePago='SI' or 
				 (((@Exterior='SI' and IsNull(Exterior,'NO')='SI') or 
				   (@Exterior<>'SI' and IsNull(Exterior,'NO')<>'SI' and 
				    ((@NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='SI' and @Tipo=Tipo) or 
				     (@NumeracionIndependienteDeOrdenesDePagoFFyCTACTE<>'SI' and 
				      ((@Tipo='CC' and (Tipo='CC' or Tipo='FF')) or 
				       (@Tipo='FF' and (Tipo='CC' or Tipo='FF')) or @Tipo=Tipo))))))))
		SET @NumeroOP=@NumeroOP+1

	SET @Existe=0
	IF @NumeracionAutomaticaDeOrdenesDePago='NO' and Exists(Select Top 1 IdOrdenPago From OrdenesPago Where NumeroOrdenPago=@NumeroOrdenPago and FechaOrdenPago>=@FechaInicioControl)
		SET @Existe=1

	IF @NumeracionAutomaticaDeOrdenesDePago='SI' or @Existe=1 or @NumeroOrdenPago=@NumeroOP
	   BEGIN
		SET @NumeroOrdenPago=@NumeroOP
		IF @NumeracionUnicaDeOrdenesDePago='SI'
			UPDATE Parametros SET ProximaOrdenPago=@NumeroOP+1
		ELSE
			IF @Exterior='SI'
				UPDATE Parametros SET ProximaOrdenPagoExterior=@NumeroOP+1
			ELSE
				IF @NumeracionIndependienteDeOrdenesDePagoFFyCTACTE='SI'
				    BEGIN
					IF @Tipo='CC'
						UPDATE Parametros SET ProximaOrdenPago=@NumeroOP+1
					IF @Tipo='FF'
						UPDATE Parametros SET ProximaOrdenPagoFF=@NumeroOP+1
					IF @Tipo='OT'
						UPDATE Parametros SET ProximaOrdenPagoOtros=@NumeroOP+1
				    END
				ELSE
					IF @Tipo='CC' or @Tipo='FF'
						UPDATE Parametros SET ProximaOrdenPago=@NumeroOP+1
					ELSE
						UPDATE Parametros SET ProximaOrdenPagoOtros=@NumeroOP+1
	   END
   END

INSERT INTO [OrdenesPago]
(
 NumeroOrdenPago,
 FechaOrdenPago,
 IdProveedor,
 Efectivo,
 Descuentos,
 Valores,
 Documentos,
 Otros1,
 IdCuenta1,
 Otros2,
 IdCuenta2,
 Otros3,
 IdCuenta3,
 Acreedores,
 RetencionIVA,
 RetencionGanancias,
 RetencionIBrutos,
 GastosGenerales,
 Estado,
 IdCuenta,
 Tipo,
 Anulada,
 CotizacionDolar,
 Dolarizada,
 Exterior,
 NumeroCertificadoRetencionGanancias,
 BaseGanancias,
 IdMoneda,
 CotizacionMoneda,
 AsientoManual,
 Observaciones,
 IdObra,
 IdCuentaGasto,
 DiferenciaBalanceo,
 IdOPComplementariaFF,
 IdEmpleadoFF,
 NumeroCertificadoRetencionIVA,
 NumeroCertificadoRetencionIIBB,
 RetencionSUSS,
 NumeroCertificadoRetencionSUSS,
 TipoOperacionOtros,
 IdUsuarioIngreso,
 FechaIngreso,
 IdUsuarioModifico,
 FechaModifico,
 Confirmado,
 IdObraOrigen,
 CotizacionEuro,
 TipoGrabacion,
 IdProvinciaDestino,
 CalculaSUSS,
 RetencionIVAComprobantesM,
 IdUsuarioAnulo,
 FechaAnulacion,
 MotivoAnulacion,
 NumeroRendicionFF,
 ConfirmacionAcreditacionFF,
 OPInicialFF,
 IdConcepto,
 IdConcepto2,
 FormaAnulacionCheques,
 Detalle,
 RecalculoRetencionesUltimaModificacion,
 IdImpuestoDirecto,
 NumeroReciboProveedor,
 FechaReciboProveedor,
 TextoAuxiliar1,
 TextoAuxiliar2,
 TextoAuxiliar3,
 IdsComprobanteProveedorRetenidosIva,
 TotalesImportesRetenidosIva,
 ReversionContablePorAnulacion
)
VALUES
(
 @NumeroOrdenPago,
 @FechaOrdenPago,
 @IdProveedor,
 @Efectivo,
 @Descuentos,
 @Valores,
 @Documentos,
 @Otros1,
 @IdCuenta1,
 @Otros2,
 @IdCuenta2,
 @Otros3,
 @IdCuenta3,
 @Acreedores,
 @RetencionIVA,
 @RetencionGanancias,
 @RetencionIBrutos,
 @GastosGenerales,
 @Estado,
 @IdCuenta,
 @Tipo,
 @Anulada,
 @CotizacionDolar,
 @Dolarizada,
 @Exterior,
 @NumeroCertificadoRetencionGanancias,
 @BaseGanancias,
 @IdMoneda,
 @CotizacionMoneda,
 @AsientoManual,
 @Observaciones,
 @IdObra,
 @IdCuentaGasto,
 @DiferenciaBalanceo,
 @IdOPComplementariaFF,
 @IdEmpleadoFF,
 @NumeroCertificadoRetencionIVA,
 @NumeroCertificadoRetencionIIBB,
 @RetencionSUSS,
 @NumeroCertificadoRetencionSUSS,
 @TipoOperacionOtros,
 @IdUsuarioIngreso,
 @FechaIngreso,
 @IdUsuarioModifico,
 @FechaModifico,
 @Confirmado,
 @IdObraOrigen,
 @CotizacionEuro,
 @TipoGrabacion,
 @IdProvinciaDestino,
 @CalculaSUSS,
 @RetencionIVAComprobantesM,
 @IdUsuarioAnulo,
 @FechaAnulacion,
 @MotivoAnulacion,
 @NumeroRendicionFF,
 @ConfirmacionAcreditacionFF,
 @OPInicialFF,
 @IdConcepto,
 @IdConcepto2,
 @FormaAnulacionCheques,
 @Detalle,
 @RecalculoRetencionesUltimaModificacion,
 @IdImpuestoDirecto, @NumeroReciboProveedor,
 @FechaReciboProveedor,
 @TextoAuxiliar1,
 @TextoAuxiliar2,
 @TextoAuxiliar3,
 @IdsComprobanteProveedorRetenidosIva,
 @TotalesImportesRetenidosIva,
 @ReversionContablePorAnulacion
)

SELECT @IdOrdenPago=@@identity

IF @@ERROR <> 0 GOTO AbortTransaction

COMMIT TRAN
GOTO EndTransaction

AbortTransaction:
ROLLBACK TRAN

EndTransaction:
RETURN(@IdOrdenPago)