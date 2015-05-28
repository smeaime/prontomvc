
CREATE  Procedure [dbo].[Proveedores_ActualizarDatosIIBB]

@IdProveedor int,
@PorcentajeIBDirecto numeric(6,2),
@FechaInicioVigenciaIBDirecto datetime,
@FechaFinVigenciaIBDirecto datetime,
@GrupoIIBB int, 
@TipoImpuesto int = Null

AS 

SET @TipoImpuesto=Isnull(@TipoImpuesto,0)

IF @TipoImpuesto=0
   BEGIN
	UPDATE Proveedores
	SET
		PorcentajeIBDirecto = @PorcentajeIBDirecto,
		FechaInicioVigenciaIBDirecto = @FechaInicioVigenciaIBDirecto,
		FechaFinVigenciaIBDirecto = @FechaFinVigenciaIBDirecto,
		GrupoIIBB = @GrupoIIBB
	WHERE IdProveedor=@IdProveedor
   END

IF @TipoImpuesto=1
   BEGIN
	UPDATE Proveedores
	SET
		PorcentajeIBDirectoCapital = @PorcentajeIBDirecto,
		FechaInicioVigenciaIBDirectoCapital = @FechaInicioVigenciaIBDirecto,
		FechaFinVigenciaIBDirectoCapital = @FechaFinVigenciaIBDirecto,
		GrupoIIBBCapital = @GrupoIIBB
	WHERE IdProveedor=@IdProveedor
   END

RETURN(@IdProveedor)
