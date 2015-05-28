CREATE TABLE [dbo].[_TempCuboSaldosComprobantesPorObraProveedor] (
    [IdTempCuboSaldosComprobantesPorObraProveedor] INT             IDENTITY (1, 1) NOT NULL,
    [Obra]                                         VARCHAR (13)    NULL,
    [Proveedor]                                    VARCHAR (50)    NULL,
    [RubroContable]                                VARCHAR (50)    NULL,
    [Detalle]                                      VARCHAR (100)   NULL,
    [Importe]                                      NUMERIC (18, 2) NULL,
    [TotalComprobante]                             NUMERIC (18, 2) NULL,
    [SaldoComprobante]                             NUMERIC (18, 2) NULL,
    [SaldoImporte]                                 NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboSaldosComprobantesPorObraProveedor] PRIMARY KEY CLUSTERED ([IdTempCuboSaldosComprobantesPorObraProveedor] ASC) WITH (FILLFACTOR = 90)
);

