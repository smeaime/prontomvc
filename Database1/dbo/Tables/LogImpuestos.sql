CREATE TABLE [dbo].[LogImpuestos] (
    [FechaProceso]                 DATETIME       NULL,
    [ArchivoProcesado]             VARCHAR (12)   NULL,
    [IdProveedor]                  INT            NULL,
    [IGCondicion]                  INT            NULL,
    [FechaLimiteExentoGanancias]   DATETIME       NULL,
    [IvaExencionRetencion]         VARCHAR (2)    NULL,
    [IvaPorcentajeExencion]        NUMERIC (6, 2) NULL,
    [IvaFechaCaducidadExencion]    DATETIME       NULL,
    [CodigoSituacionRetencionIVA]  INT            NULL,
    [FechaLog]                     DATETIME       NULL,
    [SUSSFechaCaducidadExencion]   DATETIME       NULL,
    [PorcentajeIBDirecto]          NUMERIC (6, 2) NULL,
    [FechaInicioVigenciaIBDirecto] DATETIME       NULL,
    [FechaFinVigenciaIBDirecto]    DATETIME       NULL,
    [GrupoIIBB]                    INT            NULL,
    [IdCliente]                    INT            NULL
);

