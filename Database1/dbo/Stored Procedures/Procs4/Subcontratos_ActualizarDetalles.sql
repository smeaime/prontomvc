
CREATE Procedure [dbo].[Subcontratos_ActualizarDetalles]

@IdSubcontrato int,
@Mes int,
@Año int,
@Importe numeric(18,2),
@Cantidad numeric(18,2),
@ImporteAvance numeric(18,2),
@CantidadAvance numeric(18,2),
@NumeroCertificado int,
@CantidadAvanceAcumulada numeric(18,2),
@ImporteDescuento numeric(18,2)

AS

DECLARE @IdSubcontratoPxQ int, @ImporteTotal numeric(18,2), @ImporteAvance1 numeric(18,2), @ImporteDescuento1 numeric(18,2)

SET @IdSubcontratoPxQ=IsNull((Select Top 1 IdSubcontratoPxQ From SubcontratosPxQ Where IdSubcontrato=@IdSubcontrato and NumeroCertificado=@NumeroCertificado),0)

IF @IdSubcontratoPxQ=0
    BEGIN
	SET @ImporteTotal=Case When @ImporteAvance>0 Then @ImporteAvance Else 0 End - Case When @ImporteDescuento>0 Then @ImporteDescuento Else 0 End
	INSERT INTO [SubcontratosPxQ]
	(IdSubcontrato, Mes, Año, Importe, Cantidad, ImporteAvance, CantidadAvance, NumeroCertificado, CantidadAvanceAcumulada, ImporteDescuento, ImporteTotal)
	VALUES
	(@IdSubcontrato, @Mes, @Año, Case When @Importe>0 Then @Importe Else Null End, 
	 Case When @Cantidad>0 Then @Cantidad Else Null End,  
	 Case When @ImporteAvance>0 Then @ImporteAvance Else Null End, 
	 Case When @CantidadAvance>0 Then @CantidadAvance Else Null End, 
	 @NumeroCertificado, 
	 Case When @CantidadAvanceAcumulada>0 Then @CantidadAvanceAcumulada Else Null End,  
	 Case When @ImporteDescuento>0 Then @ImporteDescuento Else Null End, 
	 Case When @ImporteTotal>0 Then @ImporteTotal Else Null End)
	
	SELECT @IdSubcontratoPxQ=@@identity
    END
ELSE
    BEGIN
	IF @ImporteAvance>0
		SET @ImporteAvance1=@ImporteAvance
	ELSE
		SET @ImporteAvance1=IsNull((Select Top 1 ImporteAvance From SubcontratosPxQ Where IdSubcontratoPxQ=@IdSubcontratoPxQ),0)

	IF @ImporteDescuento>0
		SET @ImporteDescuento1=@ImporteDescuento
	ELSE
		SET @ImporteDescuento1=IsNull((Select Top 1 ImporteDescuento From SubcontratosPxQ Where IdSubcontratoPxQ=@IdSubcontratoPxQ),0)

	SET @ImporteTotal=@ImporteAvance1-@ImporteDescuento1

	UPDATE SubcontratosPxQ
	SET Importe=Case When @Importe>=0 Then @Importe Else Importe End,
		Cantidad=Case When @Cantidad>=0 Then @Cantidad Else Cantidad End,
		ImporteAvance=Case When @ImporteAvance>=0 Then @ImporteAvance Else ImporteAvance End,
		CantidadAvance=Case When @CantidadAvance>=0 Then @CantidadAvance Else CantidadAvance End, 
		NumeroCertificado=@NumeroCertificado, 
		CantidadAvanceAcumulada=Case When @CantidadAvanceAcumulada>=0 Then @CantidadAvanceAcumulada Else CantidadAvance End,
		ImporteDescuento=Case When @ImporteDescuento>=0 Then @ImporteDescuento Else ImporteDescuento End,
		ImporteTotal=@ImporteTotal
	WHERE IdSubcontratoPxQ=@IdSubcontratoPxQ
    END
