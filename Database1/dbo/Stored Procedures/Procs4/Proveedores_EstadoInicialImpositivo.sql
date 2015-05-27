CREATE Procedure [dbo].[Proveedores_EstadoInicialImpositivo]

@FechaProceso datetime,
@ArchivoProcesado varchar(10),
@TipoImpuesto int = Null

AS

SET @TipoImpuesto=Isnull(@TipoImpuesto,0)

IF @TipoImpuesto=0
   BEGIN
	INSERT INTO [LogImpuestos]
	SELECT @FechaProceso, @ArchivoProcesado+' Ini', IdProveedor, IGCondicion, FechaLimiteExentoGanancias, IvaExencionRetencion, 
		IvaPorcentajeExencion, IvaFechaCaducidadExencion, CodigoSituacionRetencionIVA, GetDate(), SUSSFechaCaducidadExencion,
		PorcentajeIBDirecto, FechaInicioVigenciaIBDirecto, FechaFinVigenciaIBDirecto, GrupoIIBB, Null
	FROM Proveedores
	
	INSERT INTO [LogImpuestos]
	SELECT @FechaProceso, @ArchivoProcesado+' Ini', Null, Null, Null, Null, Null, Null, Null, GetDate(), Null,
		PorcentajeIBDirecto, FechaInicioVigenciaIBDirecto, FechaFinVigenciaIBDirecto, GrupoIIBB, IdCliente
	FROM Clientes
   END

IF @TipoImpuesto=1
   BEGIN
	INSERT INTO [LogImpuestos]
	SELECT @FechaProceso, @ArchivoProcesado+' Ini', IdProveedor, IGCondicion, FechaLimiteExentoGanancias, IvaExencionRetencion, 
		IvaPorcentajeExencion, IvaFechaCaducidadExencion, CodigoSituacionRetencionIVA, GetDate(), SUSSFechaCaducidadExencion,
		PorcentajeIBDirectoCapital, FechaInicioVigenciaIBDirectoCapital, FechaFinVigenciaIBDirectoCapital, GrupoIIBBCapital, Null
	FROM Proveedores
	
	INSERT INTO [LogImpuestos]
	SELECT @FechaProceso, @ArchivoProcesado+' Ini', Null, Null, Null, Null, Null, Null, Null, GetDate(), Null,
		PorcentajeIBDirectoCapital, FechaInicioVigenciaIBDirectoCapital, FechaFinVigenciaIBDirectoCapital, GrupoIIBBCapital, IdCliente
	FROM Clientes
   END

IF exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_TempInformacionImpositiva]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[_TempInformacionImpositiva]