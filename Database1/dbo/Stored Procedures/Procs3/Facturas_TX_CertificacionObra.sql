
CREATE  Procedure [dbo].[Facturas_TX_CertificacionObra]

@IdObra int

AS 

SET NOCOUNT ON

SET @IdObra=IsNull(@IdObra,-1)

CREATE TABLE #Auxiliar1 
			(
			 IdFactura INTEGER,
			 IdObra INTEGER,
			 ImporteCertificacionObra NUMERIC(18,2),
			 FondoReparoCertificacionObra NUMERIC(18,2),
			 ImporteCertificacionObra_Pendiente NUMERIC(18,2),
			 FondoReparoCertificacionObra_Pendiente NUMERIC(18,2),
			 PorcentajeRetencionesEstimadasCertificacionObra NUMERIC(6,2),
			 RetencionesEstimadasCertificacionObra NUMERIC(18,2)
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar1 ON #Auxiliar1 (IdFactura) ON [PRIMARY]
INSERT INTO #Auxiliar1
 SELECT Facturas.IdFactura, Facturas.IdObra, IsNull(Facturas.ImporteCertificacionObra,0), IsNull(Facturas.FondoReparoCertificacionObra,0), 
	Null, Null, IsNull(Facturas.PorcentajeRetencionesEstimadasCertificacionObra,0), Null
 FROM Facturas 
 WHERE (@IdObra=-1 or Facturas.IdObra=@IdObra) and IsNull(Facturas.NumeroCertificadoObra,0)<>0

/*  CURSOR  */
DECLARE @IdFactura int, @IdObra1 int, @ImporteCertificacionObra numeric(18,2), @FondoReparoCertificacionObra numeric(18,2), 
	@ImporteCertificacionObra_Pendiente numeric(18,2), @FondoReparoCertificacionObra_Pendiente numeric(18,2), 
	@PorcentajeRetencionesEstimadasCertificacionObra numeric(6,2), @RetencionesEstimadasCertificacionObra numeric(18,2), 
	@SaldoCtaCte numeric(18,2), @ImportePagado numeric(18,2)

DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdFactura, IdObra, ImporteCertificacionObra, FondoReparoCertificacionObra, PorcentajeRetencionesEstimadasCertificacionObra
		FROM #Auxiliar1
		ORDER BY IdFactura
OPEN Cur
FETCH NEXT FROM Cur INTO @IdFactura, @IdObra1, @ImporteCertificacionObra, @FondoReparoCertificacionObra, @PorcentajeRetencionesEstimadasCertificacionObra
WHILE @@FETCH_STATUS = 0
   BEGIN
	SET @SaldoCtaCte=IsNull((Select Top 1 cc.Saldo From CuentasCorrientesDeudores cc Where cc.IdTipoComp=1 and cc.IdComprobante=@IdFactura),0)
	SET @ImportePagado=(@ImporteCertificacionObra+@FondoReparoCertificacionObra)-@SaldoCtaCte
	IF @ImportePagado<0 
		SET @ImportePagado=0

	IF @ImportePagado>=@ImporteCertificacionObra
	    BEGIN
		SET @ImporteCertificacionObra_Pendiente=0
		SET @ImportePagado=@ImportePagado-@ImporteCertificacionObra
	    END
	ELSE
	    BEGIN
		SET @ImporteCertificacionObra_Pendiente=@ImporteCertificacionObra-@ImportePagado
		SET @ImportePagado=0
	    END

	IF @ImportePagado>=@FondoReparoCertificacionObra
	    BEGIN
		SET @FondoReparoCertificacionObra_Pendiente=0
		SET @ImportePagado=@ImportePagado-@FondoReparoCertificacionObra
	    END
	ELSE
	    BEGIN
		SET @FondoReparoCertificacionObra_Pendiente=@FondoReparoCertificacionObra-@ImportePagado
		SET @ImportePagado=0
	    END

	SET @RetencionesEstimadasCertificacionObra=0
	IF @ImporteCertificacionObra_Pendiente>0
		SET @RetencionesEstimadasCertificacionObra=(@ImporteCertificacionObra+@FondoReparoCertificacionObra)*@PorcentajeRetencionesEstimadasCertificacionObra/100

	UPDATE #Auxiliar1
	SET ImporteCertificacionObra_Pendiente=@ImporteCertificacionObra_Pendiente, FondoReparoCertificacionObra_Pendiente=@FondoReparoCertificacionObra_Pendiente, 
		RetencionesEstimadasCertificacionObra=@RetencionesEstimadasCertificacionObra
	WHERE IdFactura=@IdFactura

	FETCH NEXT FROM Cur INTO @IdFactura, @IdObra1, @ImporteCertificacionObra, @FondoReparoCertificacionObra, @PorcentajeRetencionesEstimadasCertificacionObra
   END
CLOSE Cur
DEALLOCATE Cur

SET NOCOUNT OFF

SELECT #Auxiliar1.*, Facturas.FechaFactura, Facturas.FechaVencimiento, Facturas.NumeroCertificadoObra, Facturas.NumeroExpedienteCertificacionObra, 
	Facturas.TipoABC+' '+Substring('0000',1,4-Len(Convert(varchar,IsNull(Facturas.PuntoVenta,0))))+Convert(varchar,IsNull(Facturas.PuntoVenta,0))+'-'+
		Substring('00000000',1,8-Len(Convert(varchar,Facturas.NumeroFactura)))+Convert(varchar,Facturas.NumeroFactura) as [Factura], 
	Obras.NumeroObra, Obras.Descripcion as [Obra], '' as [Estado]
FROM #Auxiliar1
LEFT OUTER JOIN Facturas ON Facturas.IdFactura=#Auxiliar1.IdFactura
LEFT OUTER JOIN Obras ON Obras.IdObra=#Auxiliar1.IdObra
ORDER BY #Auxiliar1.IdObra, Facturas.FechaFactura, Facturas.NumeroCertificadoObra

DROP TABLE #Auxiliar1
