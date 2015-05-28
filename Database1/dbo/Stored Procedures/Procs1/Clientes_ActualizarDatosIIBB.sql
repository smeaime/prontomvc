
CREATE  Procedure [dbo].[Clientes_ActualizarDatosIIBB]

@IdCliente int,
@PorcentajeIBDirecto numeric(6,2),
@FechaInicioVigenciaIBDirecto datetime,
@FechaFinVigenciaIBDirecto datetime,
@GrupoIIBB int, 
@TipoImpuesto int = Null

AS 

SET @TipoImpuesto=Isnull(@TipoImpuesto,0)

IF @TipoImpuesto=0
   BEGIN
	UPDATE Clientes
	SET
		PorcentajeIBDirecto = @PorcentajeIBDirecto,
		FechaInicioVigenciaIBDirecto = @FechaInicioVigenciaIBDirecto,
		FechaFinVigenciaIBDirecto = @FechaFinVigenciaIBDirecto,
		GrupoIIBB = @GrupoIIBB
	WHERE IdCliente = @IdCliente
   END

IF @TipoImpuesto=1
   BEGIN
	UPDATE Clientes
	SET
		PorcentajeIBDirectoCapital = @PorcentajeIBDirecto,
		FechaInicioVigenciaIBDirectoCapital = @FechaInicioVigenciaIBDirecto,
		FechaFinVigenciaIBDirectoCapital = @FechaFinVigenciaIBDirecto,
		GrupoIIBBCapital = @GrupoIIBB
	WHERE IdCliente = @IdCliente
   END

RETURN(@IdCliente)
