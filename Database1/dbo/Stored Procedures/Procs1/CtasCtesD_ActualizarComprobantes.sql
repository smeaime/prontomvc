


CREATE Procedure [dbo].[CtasCtesD_ActualizarComprobantes]

@IdOrigenTransmision int

AS

CREATE TABLE #Auxiliar 	
			(
			 IdCtaCte INTEGER,
			 IdCtaCteOriginal INTEGER,
			 CuitClienteTransmision VARCHAR(13),
			 IdTipoComprobante INTEGER,
			 IdComprobanteOriginal INTEGER,
			 IdImputacionOriginal INTEGER
			)
CREATE NONCLUSTERED INDEX IX__Auxiliar ON #Auxiliar (IdCtaCte) ON [PRIMARY]
INSERT INTO #Auxiliar 
 SELECT IdCtaCte, IdCtaCteOriginal, CuitClienteTransmision, IdTipoComp, 
	IdComprobanteOriginal, IdImputacionOriginal
 FROM CuentasCorrientesDeudores 
 WHERE IdOrigenTransmision=@IdOrigenTransmision and 
	(IsNull(IdCliente,0)=0 or IsNull(IdComprobante,0)=0 or IsNull(IdImputacion,0)=0)

/*  CURSOR  */
DECLARE @IdCtaCte int, @IdCtaCteOriginal int, @CuitClienteTransmision varchar(13), 
	@IdTipoComprobante int, @IdComprobanteOriginal int, @IdImputacionOriginal int
DECLARE Cur CURSOR LOCAL FORWARD_ONLY 
	FOR	SELECT IdCtaCte, IdCtaCteOriginal, CuitClienteTransmision, 
			IdTipoComprobante, IdComprobanteOriginal, IdImputacionOriginal
		FROM #Auxiliar
		ORDER BY IdCtaCte
OPEN Cur
FETCH NEXT FROM Cur INTO @IdCtaCte, @IdCtaCteOriginal, @CuitClienteTransmision, 
			 @IdTipoComprobante, @IdComprobanteOriginal, @IdImputacionOriginal
WHILE @@FETCH_STATUS = 0
   BEGIN
	IF Len(IsNull(@CuitClienteTransmision,''))>0
		UPDATE CuentasCorrientesDeudores
		SET IdCliente=IsNull((Select Top 1 Clientes.IdCliente From Clientes 
					Where Clientes.Cuit=@CuitClienteTransmision),0)
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdCliente,0)=0

	IF @IdTipoComprobante=1
	   BEGIN
		UPDATE CuentasCorrientesDeudores
		SET IdComprobante=(Select Top 1 Fac.IdFactura From Facturas Fac 
				   Where Fac.IdFacturaOriginal=@IdComprobanteOriginal and 
					Fac.IdOrigenTransmision=@IdOrigenTransmision)
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdComprobante,0)=0
	
		UPDATE CuentasCorrientesDeudores
		SET IdImputacion=IdCtaCte
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdImputacion,0)=0
	   END
	
	IF @IdTipoComprobante=2
	   BEGIN
		UPDATE CuentasCorrientesDeudores
		SET IdDetalleRecibo=(Select Top 1 Det.IdDetalleRecibo From DetalleRecibos Det 
					Where Det.IdReciboOriginal=@IdComprobanteOriginal and 
						Det.IdOrigenTransmision=@IdOrigenTransmision and 
						Det.IdDetalleReciboOriginal=IdDetalleReciboOriginal)
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdComprobante,0)=0

		UPDATE CuentasCorrientesDeudores
		SET IdComprobante=(Select Top 1 Rec.IdRecibo From Recibos Rec 
				   Where Rec.IdReciboOriginal=@IdComprobanteOriginal and 
					Rec.IdOrigenTransmision=@IdOrigenTransmision)
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdComprobante,0)=0
	
		UPDATE CuentasCorrientesDeudores
		SET IdImputacion=(Select Top 1 Cta.IdCtaCte From CuentasCorrientesDeudores Cta 
				   Where Cta.IdImputacionOriginal=@IdImputacionOriginal and 
					Cta.IdOrigenTransmision=@IdOrigenTransmision and Cta.IdTipoComp=1)
		WHERE IdCtaCte=@IdCtaCte and IsNull(IdImputacion,0)=0
	   END

	FETCH NEXT FROM Cur INTO @IdCtaCte, @IdCtaCteOriginal, @CuitClienteTransmision, 
				 @IdTipoComprobante, @IdComprobanteOriginal, @IdImputacionOriginal
   END
CLOSE Cur
DEALLOCATE Cur

UPDATE DetalleRecibos
SET IdImputacion=-1
WHERE IdOrigenTransmision=@IdOrigenTransmision

DROP TABLE #Auxiliar


