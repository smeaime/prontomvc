CREATE Procedure [dbo].[AutorizacionesPorComprobante_A]

@IdAutorizacionPorComprobante int  output,
@IdFormulario int,
@IdComprobante int,
@OrdenAutorizacion int,
@IdAutorizo int,
@FechaAutorizacion datetime,
@Visto varchar(2)

AS

INSERT INTO [AutorizacionesPorComprobante]
(
 IdFormulario,
 IdComprobante,
 OrdenAutorizacion,
 IdAutorizo,
 FechaAutorizacion,
 Visto
)
VALUES
(
 @IdFormulario,
 @IdComprobante,
 @OrdenAutorizacion,
 @IdAutorizo,
 @FechaAutorizacion,
 @Visto
)
SELECT @IdAutorizacionPorComprobante=@@identity

DECLARE @Importe numeric(18,2), @IdTipoCompraRM int, @FirmantesPorRubroRango varchar(2)

IF @IdFormulario=3
    BEGIN
	CREATE TABLE #Auxiliar1 (IdComprobante INTEGER, IdFormulario INTEGER, OrdenAutorizacion INTEGER, IdFirmante INTEGER)
	INSERT INTO #Auxiliar1
	 SELECT dr.IdRequerimiento, a.IdFormulario, da.OrdenAutorizacion, daf.IdFirmante
	 FROM DetalleRequerimientos dr
	 LEFT OUTER JOIN Requerimientos r ON r.IdRequerimiento=dr.IdRequerimiento
	 LEFT OUTER JOIN Articulos ON Articulos.IdArticulo=dr.IdArticulo
	 LEFT OUTER JOIN DetalleAutorizacionesFirmantes daf ON daf.IdRubro=Articulos.IdRubro and daf.IdSubrubro=Articulos.IdSubrubro and IsNull(daf.ParaTaller,'')=IsNull(r.ParaTaller,'')
	 LEFT OUTER JOIN DetalleAutorizaciones da ON da.IdDetalleAutorizacion=daf.IdDetalleAutorizacion
	 LEFT OUTER JOIN Autorizaciones a ON a.IdAutorizacion=daf.IdAutorizacion
	 WHERE dr.IdRequerimiento=@IdComprobante and daf.IdFirmante is not null

	IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
			From DetalleAutorizaciones da
			Left Outer Join Autorizaciones On da.IdAutorizacion=Autorizaciones.IdAutorizacion
			Left Outer Join #Auxiliar1 On #Auxiliar1.IdFormulario=@IdFormulario and #Auxiliar1.IdComprobante=@IdComprobante and #Auxiliar1.OrdenAutorizacion=da.OrdenAutorizacion
			Where Autorizaciones.IdFormulario=@IdFormulario and 
				Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante aut
						Where aut.IdFormulario=@IdFormulario and aut.OrdenAutorizacion=da.OrdenAutorizacion and aut.IdComprobante=@IdComprobante) and 
				Not (Exists(Select Top 1 daf.IdDetalleAutorizacionFirmantes From DetalleAutorizacionesFirmantes daf 
						Where daf.IdDetalleAutorizacion=da.IdDetalleAutorizacion) and IsNull(#Auxiliar1.IdFirmante,0)=0))
			UPDATE Requerimientos SET CircuitoFirmasCompleto='SI' WHERE IdRequerimiento=@IdComprobante
	DROP TABLE #Auxiliar1
    END

IF @IdFormulario=4
    BEGIN
	SET @Importe=IsNull((Select Top 1 (TotalPedido-TotalIva1)*IsNull(CotizacionMoneda,1) From Pedidos Where IdPedido=@IdComprobante),0)
	SET @IdTipoCompraRM=IsNull((Select Top 1 IdTipoCompraRM From Pedidos Where IdPedido=@IdComprobante),0)
	SET @FirmantesPorRubroRango=Isnull((Select Top 1 ProntoIni.Valor From ProntoIni 
						Left Outer Join ProntoIniClaves pic On pic.IdProntoIniClave=ProntoIni.IdProntoIniClave
						Where pic.Clave='Modelo de firmas de documentos por firmante entre importes por rubro' and IsNull(ProntoIni.Valor,'')='SI'),'NO')

	IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
			From DetalleAutorizaciones da
			Left Outer Join Autorizaciones On da.IdAutorizacion=Autorizaciones.IdAutorizacion
			Where Autorizaciones.IdFormulario=@IdFormulario and 
				Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante aut Where aut.IdFormulario=@IdFormulario and aut.OrdenAutorizacion=da.OrdenAutorizacion and aut.IdComprobante=@IdComprobante) and 
				((IsNull(da.ImporteDesde1,0)=0 and IsNull(da.ImporteHasta1,0)=0) or (@Importe between IsNull(da.ImporteDesde1,0) and IsNull(da.ImporteHasta1,0))) and 
				(Len(IsNull(da.IdsTipoCompra,''))=0 or Patindex('%('+Convert(varchar,@IdTipoCompraRM)+')%', IsNull(da.IdsTipoCompra,''))<>0)) and @FirmantesPorRubroRango<>'SI'
		UPDATE Pedidos SET CircuitoFirmasCompleto='SI' WHERE IdPedido=@IdComprobante
	ELSE
		IF @FirmantesPorRubroRango='SI'
		    BEGIN
			EXEC AutorizacionesPorComprobante_Generar
			IF Not EXISTS(Select Top 1 a.IdComprobante From _TempAutorizaciones a Where a.IdFormulario=@IdFormulario and a.IdComprobante=@IdComprobante)
				UPDATE Pedidos SET CircuitoFirmasCompleto='SI' WHERE IdPedido=@IdComprobante
		    END
    END

IF @IdFormulario=5
    BEGIN
	SET @Importe=IsNull((Select Top 1 ImporteComparativaCalculado From Comparativas Where IdComparativa=@IdComprobante),0)
	
	IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
			From DetalleAutorizaciones da
			Left Outer Join Autorizaciones On da.IdAutorizacion=Autorizaciones.IdAutorizacion
			Where Autorizaciones.IdFormulario=@IdFormulario and 
				Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante aut
						Where aut.IdFormulario=@IdFormulario and aut.OrdenAutorizacion=da.OrdenAutorizacion and aut.IdComprobante=@IdComprobante) and 
				((IsNull(da.ImporteDesde1,0)=0 and IsNull(da.ImporteHasta1,0)=0) or (@Importe between IsNull(da.ImporteDesde1,0) and IsNull(da.ImporteHasta1,0))))
		UPDATE Comparativas SET CircuitoFirmasCompleto='SI' WHERE IdComparativa=@IdComprobante
    END

IF @IdFormulario=31
    BEGIN
	SET @Importe=IsNull((Select Top 1 TotalBruto*IsNull(CotizacionMoneda,1) From ComprobantesProveedores Where IdComprobanteProveedor=@IdComprobante),0)
	
	IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
			From DetalleAutorizaciones da
			Left Outer Join Autorizaciones On da.IdAutorizacion=Autorizaciones.IdAutorizacion
			Where Autorizaciones.IdFormulario=@IdFormulario and 
				Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante aut
						Where aut.IdFormulario=@IdFormulario and aut.OrdenAutorizacion=da.OrdenAutorizacion and aut.IdComprobante=@IdComprobante) and 
				((IsNull(da.ImporteDesde1,0)=0 and IsNull(da.ImporteHasta1,0)=0) or (@Importe between IsNull(da.ImporteDesde1,0) and IsNull(da.ImporteHasta1,0))))
		UPDATE ComprobantesProveedores SET CircuitoFirmasCompleto='SI' WHERE IdComprobanteProveedor=@IdComprobante
    END

IF @IdFormulario<>3 and @IdFormulario<>4 and @IdFormulario<>5 and @IdFormulario<>31
    BEGIN
	IF Not EXISTS(Select Top 1 da.OrdenAutorizacion
			From DetalleAutorizaciones da
			Left Outer Join Autorizaciones On da.IdAutorizacion=Autorizaciones.IdAutorizacion
			Where Autorizaciones.IdFormulario=@IdFormulario and 
				Not Exists(Select Top 1 aut.IdAutorizacionPorComprobante From AutorizacionesPorComprobante aut
						Where aut.IdFormulario=@IdFormulario and aut.OrdenAutorizacion=da.OrdenAutorizacion and aut.IdComprobante=@IdComprobante))
	    BEGIN
		IF @IdFormulario=2
			UPDATE Lmateriales SET CircuitoFirmasCompleto='SI' WHERE IdLMateriales=@IdComprobante
		IF @IdFormulario=6
			UPDATE AjustesStock SET CircuitoFirmasCompleto='SI' WHERE IdAjusteStock=@IdComprobante
		IF @IdFormulario=7
			UPDATE Presupuestos SET CircuitoFirmasCompleto='SI' WHERE IdPresupuesto=@IdComprobante
		IF @IdFormulario=8
			UPDATE ValesSalida SET CircuitoFirmasCompleto='SI' WHERE IdValeSalida=@IdComprobante
		IF @IdFormulario=9
			UPDATE SalidasMateriales SET CircuitoFirmasCompleto='SI' WHERE IdSalidaMateriales=@IdComprobante
		IF @IdFormulario=10
			UPDATE OtrosIngresosAlmacen SET CircuitoFirmasCompleto='SI' WHERE IdOtroIngresoAlmacen=@IdComprobante
		IF @IdFormulario=11
			UPDATE Recepciones SET CircuitoFirmasCompleto='SI' WHERE IdRecepcion=@IdComprobante
		IF @IdFormulario=21
			UPDATE OrdenesCompra SET CircuitoFirmasCompleto='SI' WHERE IdOrdenCompra=@IdComprobante
		IF @IdFormulario=55
			UPDATE AutorizacionesCompra SET CircuitoFirmasCompleto='SI' WHERE IdAutorizacionCompra=@IdComprobante
		IF @IdFormulario=56
			UPDATE CertificacionesObrasDatos SET CircuitoFirmasCompleto='SI' WHERE IdCertificacionObraDatos=@IdComprobante
		IF @IdFormulario=57
			UPDATE DetalleSubcontratosDatos SET CircuitoFirmasCompleto='SI' WHERE IdDetalleSubcontratoDatos=@IdComprobante
	    END
    END

RETURN(@IdAutorizacionPorComprobante)