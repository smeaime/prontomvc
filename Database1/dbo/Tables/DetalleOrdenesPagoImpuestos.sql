CREATE TABLE [dbo].[DetalleOrdenesPagoImpuestos] (
    [IdDetalleOrdenPagoImpuestos]                   INT             IDENTITY (1, 1) NOT NULL,
    [IdOrdenPago]                                   INT             NULL,
    [TipoImpuesto]                                  VARCHAR (10)    NULL,
    [IdTipoRetencionGanancia]                       INT             NULL,
    [ImportePagado]                                 NUMERIC (18, 2) NULL,
    [ImpuestoRetenido]                              NUMERIC (18, 2) NULL,
    [IdIBCondicion]                                 INT             NULL,
    [NumeroCertificadoRetencionGanancias]           INT             NULL,
    [NumeroCertificadoRetencionIIBB]                INT             NULL,
    [AlicuotaAplicada]                              NUMERIC (6, 2)  NULL,
    [AlicuotaConvenioAplicada]                      NUMERIC (6, 2)  NULL,
    [PorcentajeATomarSobreBase]                     NUMERIC (6, 2)  NULL,
    [PorcentajeAdicional]                           NUMERIC (6, 2)  NULL,
    [ImpuestoAdicional]                             NUMERIC (18, 2) NULL,
    [LeyendaPorcentajeAdicional]                    VARCHAR (50)    NULL,
    [ImporteTotalFacturasMPagadasSujetasARetencion] NUMERIC (18, 2) NULL,
    [IdDetalleImpuesto]                             INT             NULL,
    CONSTRAINT [PK_DetalleOrdenesPagoImpuestos] PRIMARY KEY CLUSTERED ([IdDetalleOrdenPagoImpuestos] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleOrdenesPagoImpuestos_OrdenesPago] FOREIGN KEY ([IdOrdenPago]) REFERENCES [dbo].[OrdenesPago] ([IdOrdenPago])
);

