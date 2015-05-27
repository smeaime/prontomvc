CREATE Procedure [dbo].[AutorizacionesPorComprobanteADesignar_Registrar]

@IdFormulario int,
@IdComprobante int,
@OrdenAutorizacion int,
@IdAutorizo int,
@FechaAutorizacion datetime,
@IdFirmanteDesignado int

AS

DECLARE @IdAutorizacionPorComprobanteADesignar int

SET @IdAutorizacionPorComprobanteADesignar=IsNull((Select Top 1 IdAutorizacionPorComprobanteADesignar From AutorizacionesPorComprobanteADesignar 
							Where IdFormulario=@IdFormulario and IdComprobante=@IdComprobante and OrdenAutorizacion=@OrdenAutorizacion),0)

IF @IdAutorizacionPorComprobanteADesignar=0
    BEGIN
	INSERT INTO [AutorizacionesPorComprobanteADesignar]
	(IdFormulario, IdComprobante, OrdenAutorizacion, IdAutorizo, FechaAutorizacion, IdFirmanteDesignado)
	VALUES
	(@IdFormulario, @IdComprobante, @OrdenAutorizacion, @IdAutorizo, @FechaAutorizacion, @IdFirmanteDesignado)
	SELECT @IdAutorizacionPorComprobanteADesignar=@@identity
    END
ELSE
    BEGIN
	UPDATE AutorizacionesPorComprobanteADesignar
	SET
	 IdAutorizo=@IdAutorizo,
	 FechaAutorizacion=@FechaAutorizacion,
	 IdFirmanteDesignado=@IdFirmanteDesignado
	WHERE IdAutorizacionPorComprobanteADesignar=@IdAutorizacionPorComprobanteADesignar
    END

RETURN(@IdAutorizacionPorComprobanteADesignar)