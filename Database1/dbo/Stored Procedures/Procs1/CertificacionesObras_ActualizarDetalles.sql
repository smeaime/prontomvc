CREATE Procedure [dbo].[CertificacionesObras_ActualizarDetalles]

@IdCertificacionObras int,
@Mes int,
@Año int,
@Importe numeric(18,4),
@Cantidad numeric(18,2),
@ImporteAvance numeric(18,4),
@CantidadAvance numeric(18,2)

AS

DECLARE @IdCertificacionObrasPxQ int

SET @IdCertificacionObrasPxQ=IsNull((Select Top 1 IdCertificacionObrasPxQ From CertificacionesObrasPxQ 
					Where IdCertificacionObras=@IdCertificacionObras and Mes=@Mes and Año=@Año),0)

IF @IdCertificacionObrasPxQ=0
    BEGIN
	INSERT INTO [CertificacionesObrasPxQ]
	(IdCertificacionObras, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance)
	VALUES
	(@IdCertificacionObras, @Mes, @Año, Case When @Importe>0 Then @Importe Else Null End, 
	 Case When @Cantidad>0 Then @Cantidad Else Null End,  Case When @ImporteAvance>0 Then @ImporteAvance Else Null End, 
	 Case When @CantidadAvance>0 Then @CantidadAvance Else Null End)
	
	SELECT @IdCertificacionObrasPxQ=@@identity
    END
ELSE
    BEGIN
	UPDATE CertificacionesObrasPxQ
	SET Importe=Case When @Importe>=0 Then @Importe Else Importe End,
		Cantidad=Case When @Cantidad>=0 Then @Cantidad Else Cantidad End,
		ImporteAvance=Case When @ImporteAvance>=0 Then @ImporteAvance Else ImporteAvance End,
		CantidadAvance=Case When @CantidadAvance>=0 Then @CantidadAvance Else CantidadAvance End
	WHERE IdCertificacionObrasPxQ=@IdCertificacionObrasPxQ
    END