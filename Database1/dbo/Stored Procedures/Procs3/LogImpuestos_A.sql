
CREATE Procedure [dbo].[LogImpuestos_A]

@FechaProceso datetime,
@ArchivoProcesado varchar(12),
@IdProveedor int = Null,
@IGCondicion int = Null,
@FechaLimiteExentoGanancias datetime = Null,
@IvaExencionRetencion varchar(2) = Null,
@IvaPorcentajeExencion numeric(6,2) = Null,
@IvaFechaCaducidadExencion datetime = Null,
@CodigoSituacionRetencionIVA int = Null,
@SUSSFechaCaducidadExencion datetime = Null,
@PorcentajeIBDirecto numeric(6,2) = Null,
@FechaInicioVigenciaIBDirecto datetime = Null,
@FechaFinVigenciaIBDirecto datetime = Null,
@GrupoIIBB int = Null,
@IdCliente int = Null

AS 

IF @IGCondicion=-1
	SET @IGCondicion=Null
IF @IvaPorcentajeExencion=-1
	SET @IvaPorcentajeExencion=Null
IF @CodigoSituacionRetencionIVA=-1
	SET @CodigoSituacionRetencionIVA=Null
IF @PorcentajeIBDirecto=-1
	SET @PorcentajeIBDirecto=Null
IF @GrupoIIBB=-1
	SET @GrupoIIBB=Null
IF @IdCliente=-1
	SET @IdCliente=Null
IF @IdProveedor=-1
	SET @IdProveedor=Null

INSERT INTO [LogImpuestos]
(
 FechaProceso,
 ArchivoProcesado,
 IdProveedor,
 IGCondicion,
 FechaLimiteExentoGanancias,
 IvaExencionRetencion,
 IvaPorcentajeExencion,
 IvaFechaCaducidadExencion,
 CodigoSituacionRetencionIVA,
 SUSSFechaCaducidadExencion,
 FechaLog,
 PorcentajeIBDirecto,
 FechaInicioVigenciaIBDirecto,
 FechaFinVigenciaIBDirecto,
 GrupoIIBB,
 IdCliente
)
VALUES
(
 @FechaProceso,
 @ArchivoProcesado,
 @IdProveedor,
 @IGCondicion,
 @FechaLimiteExentoGanancias,
 @IvaExencionRetencion,
 @IvaPorcentajeExencion,
 @IvaFechaCaducidadExencion,
 @CodigoSituacionRetencionIVA,
 @SUSSFechaCaducidadExencion,
 GetDate(),
 @PorcentajeIBDirecto,
 @FechaInicioVigenciaIBDirecto,
 @FechaFinVigenciaIBDirecto,
 @GrupoIIBB,
 @IdCliente
)
RETURN(@IdProveedor)
