CREATE TABLE [dbo].[TiposRetencionGanancia] (
    [IdTipoRetencionGanancia]                    INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]                                VARCHAR (50) NULL,
    [CodigoImpuestoAFIP]                         INT          NULL,
    [CodigoRegimenAFIP]                          INT          NULL,
    [InformacionAuxiliar]                        VARCHAR (50) NULL,
    [ProximoNumeroCertificadoRetencionGanancias] INT          NULL,
    [BienesOServicios]                           VARCHAR (1)  NULL,
    CONSTRAINT [PK_TiposRetencionGanancia] PRIMARY KEY CLUSTERED ([IdTipoRetencionGanancia] ASC) WITH (FILLFACTOR = 90)
);

