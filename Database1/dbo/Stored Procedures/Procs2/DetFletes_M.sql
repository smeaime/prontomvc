CREATE Procedure [dbo].[DetFletes_M]

@IdDetalleFlete int,
@IdFlete int,
@Fecha datetime,
@Tara numeric(18,2),
@Ancho numeric(6,2),
@Largo numeric(6,2),
@Alto numeric(6,2),
@Capacidad numeric(18,2),
@Patente varchar(6),
@IdOrigenTransmision int

AS

SET NOCOUNT ON

DECLARE @IdDetalleFlete1 int

IF @IdFlete>0 
    BEGIN
	SET @IdDetalleFlete1=@IdDetalleFlete
    END
ELSE
    BEGIN
	SET @IdDetalleFlete1=IsNull((Select df.IdDetalleFlete From DetalleFletes df Where df.Patente=@Patente and df.Fecha=@Fecha and df.Tara=@Tara and df.Capacidad=@Capacidad),0)
	SET @IdFlete=IsNull((Select Fletes.IdFlete From Fletes Where Fletes.Patente=@Patente),0)
    END

SET NOCOUNT OFF

IF @IdDetalleFlete1>0
    BEGIN
	UPDATE [DetalleFletes]
	SET 
	 IdFlete=@IdFlete,
	 Fecha=@Fecha,
	 Tara=@Tara,
	 Ancho=@Ancho,
	 Largo=@Largo,
	 Alto=@Alto,
	 Capacidad=@Capacidad,
	 Patente=@Patente,
	 IdOrigenTransmision=@IdOrigenTransmision
	WHERE (IdDetalleFlete=@IdDetalleFlete1)
    END
ELSE 
    BEGIN
	INSERT INTO [DetalleFletes]
	(
	 IdFlete,
	 Fecha,
	 Tara,
	 Ancho,
	 Largo,
	 Alto,
	 Capacidad,
	 Patente,
	 IdOrigenTransmision
	)
	VALUES
	(
	 @IdFlete,
	 @Fecha,
	 @Tara,
	 @Ancho,
	 @Largo,
	 @Alto,
	 @Capacidad,
	 @Patente,
	 @IdOrigenTransmision
	)
	SELECT @IdDetalleFlete1=@@identity
    END

RETURN(@IdDetalleFlete1)