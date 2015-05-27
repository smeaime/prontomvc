CREATE Procedure [dbo].[Facturas_ActualizarCampos]

@IdFactura int,
@IdProvinciaDestino int,
@IdObra int,
@Observaciones ntext,
@Exportacion_FOB numeric(18,2),
@Exportacion_PosicionAduana varchar(20),
@Exportacion_Despacho varchar(30),
@Exportacion_Guia varchar(20),
@Exportacion_IdPaisDestino int,
@Exportacion_FechaEmbarque datetime,
@Exportacion_FechaOficializacion datetime,
@IdIBCondicion int,
@IdIBCondicion2 int,
@IdIBCondicion3 int,
@NoIncluirEnCubos varchar(2),
@IdVendedor int = Null,
@IdPuntoVenta int = Null,
@FechaFactura datetime = Null,
@NumeroFactura int = Null,
@NumeroCertificadoObra int = Null,
@ImporteCertificacionObra numeric(18,2) = Null,
@FondoReparoCertificacionObra numeric(18,2) = Null,
@PorcentajeRetencionesEstimadasCertificacionObra numeric(6,2) = Null,
@NumeroExpedienteCertificacionObra varchar(20) = Null,
@FechaRecepcionCliente datetime = Null,
@NumeroProyecto int = Null,
@IdCertificacionObras int = Null,
@IdCertificacionObraDatos int = Null,
@CuentaVentaLetra varchar(1) = Null,
@CuentaVentaPuntoVenta int = Null,
@CuentaVentaNumero int = Null,
@IdTipoNegocioVentas int = Null,
@IdTipoOperacion int = Null

AS

SET @IdVendedor=IsNull(@IdVendedor,-1)
SET @IdPuntoVenta=IsNull(@IdPuntoVenta,0)
SET @FechaFactura=IsNull(@FechaFactura,0)
SET @NumeroFactura=IsNull(@NumeroFactura,0)
SET @NumeroCertificadoObra=IsNull(@NumeroCertificadoObra,0)
SET @ImporteCertificacionObra=IsNull(@ImporteCertificacionObra,0)
SET @FondoReparoCertificacionObra=IsNull(@FondoReparoCertificacionObra,0)
SET @PorcentajeRetencionesEstimadasCertificacionObra=IsNull(@PorcentajeRetencionesEstimadasCertificacionObra,0)
SET @NumeroExpedienteCertificacionObra=IsNull(@NumeroExpedienteCertificacionObra,'')
SET @NumeroProyecto=IsNull(@NumeroProyecto,0)
SET @IdCertificacionObras=IsNull(@IdCertificacionObras,0)
SET @IdCertificacionObraDatos=IsNull(@IdCertificacionObraDatos,0)
SET @IdTipoNegocioVentas=IsNull(@IdTipoNegocioVentas,0)
SET @IdTipoOperacion=IsNull(@IdTipoOperacion,0)

DECLARE @PuntoVenta int

SET @PuntoVenta=IsNull((Select Top 1 PuntoVenta From PuntosVenta Where IdPuntoVenta=@IdPuntoVenta),0)

UPDATE Facturas
SET 
 IdProvinciaDestino=Case When @IdProvinciaDestino=-1 Then Null Else @IdProvinciaDestino End,
 IdObra=Case When @IdObra=-1 Then Null Else @IdObra End,
 Observaciones=@Observaciones,
 Exportacion_FOB=@Exportacion_FOB,
 Exportacion_PosicionAduana=@Exportacion_PosicionAduana,
 Exportacion_Despacho=@Exportacion_Despacho,
 Exportacion_Guia=@Exportacion_Guia,
 Exportacion_IdPaisDestino=@Exportacion_IdPaisDestino,
 Exportacion_FechaEmbarque=@Exportacion_FechaEmbarque,
 Exportacion_FechaOficializacion=@Exportacion_FechaOficializacion,
 IdIBCondicion=Case When @IdIBCondicion=-1 Then Null Else @IdIBCondicion End,
 IdIBCondicion2=Case When @IdIBCondicion2=-1 Then Null Else @IdIBCondicion2 End,
 IdIBCondicion3=Case When @IdIBCondicion3=-1 Then Null Else @IdIBCondicion3 End,
 NoIncluirEnCubos=@NoIncluirEnCubos, 
 IdVendedor=Case When @IdVendedor=-1 Then Null Else @IdVendedor End,
 NumeroCertificadoObra=Case When @NumeroCertificadoObra=0 Then Null Else @NumeroCertificadoObra End,
 ImporteCertificacionObra=Case When @ImporteCertificacionObra=0 Then Null Else @ImporteCertificacionObra End,
 FondoReparoCertificacionObra=Case When @FondoReparoCertificacionObra=0 Then Null Else @FondoReparoCertificacionObra End,
 PorcentajeRetencionesEstimadasCertificacionObra=Case When @PorcentajeRetencionesEstimadasCertificacionObra=0 Then Null Else @PorcentajeRetencionesEstimadasCertificacionObra End,
 NumeroExpedienteCertificacionObra=Case When @NumeroExpedienteCertificacionObra='' Then Null Else @NumeroExpedienteCertificacionObra End,
 FechaRecepcionCliente=IsNull(@FechaRecepcionCliente,FechaFactura),
 NumeroProyecto=Case When @NumeroProyecto=0 Then Null Else @NumeroProyecto End,
 IdCertificacionObras=Case When @IdCertificacionObras=0 Then Null Else @IdCertificacionObras End,
 IdCertificacionObraDatos=Case When @IdCertificacionObraDatos=0 Then Null Else @IdCertificacionObraDatos End,
 CuentaVentaLetra=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaLetra End,
 CuentaVentaPuntoVenta=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaPuntoVenta End,
 CuentaVentaNumero=Case When IsNull(@CuentaVentaNumero,0)=0 Then Null Else @CuentaVentaNumero End,
 IdTipoNegocioVentas=Case When IsNull(@IdTipoNegocioVentas,0)<=0 Then IdTipoNegocioVentas Else @IdTipoNegocioVentas End,
 IdTipoOperacion=Case When IsNull(@IdTipoOperacion,0)<=0 Then IdTipoOperacion Else @IdTipoOperacion End
WHERE (IdFactura=@IdFactura)

IF @IdPuntoVenta>0 
	UPDATE Facturas
	SET IdPuntoVenta=@IdPuntoVenta, PuntoVenta=@PuntoVenta
	WHERE (IdFactura=@IdFactura)

IF @FechaFactura>0
  BEGIN
	UPDATE Facturas
	SET FechaFactura=@FechaFactura
	WHERE IdFactura=@IdFactura

	UPDATE Subdiarios
	SET FechaComprobante=@FechaFactura
	WHERE IdComprobante=@IdFactura and IdTipoComprobante=1

	UPDATE CuentasCorrientesDeudores
	SET Fecha=@FechaFactura
	WHERE IdComprobante=@IdFactura and IdTipoComp=1
  END

IF @NumeroFactura>0
  BEGIN
	UPDATE Facturas
	SET NumeroFactura=@NumeroFactura
	WHERE IdFactura=@IdFactura

	UPDATE Subdiarios
	SET NumeroComprobante=@NumeroFactura
	WHERE IdComprobante=@IdFactura and IdTipoComprobante=1

	UPDATE CuentasCorrientesDeudores
	SET NumeroComprobante=@NumeroFactura
	WHERE IdComprobante=@IdFactura and IdTipoComp=1
  END

RETURN(@IdFactura)