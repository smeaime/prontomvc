CREATE TABLE [dbo].[Subdiarios] (
    [IdSubdiario]                 INT             IDENTITY (1, 1) NOT NULL,
    [Ejercicio]                   INT             NULL,
    [IdCuentaSubdiario]           INT             NULL,
    [IdCuenta]                    INT             NULL,
    [IdTipoComprobante]           INT             NULL,
    [NumeroComprobante]           INT             NULL,
    [FechaComprobante]            DATETIME        NULL,
    [Detalle]                     VARCHAR (100)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Debe]                        NUMERIC (18, 2) NULL,
    [Haber]                       NUMERIC (18, 2) NULL,
    [IdComprobante]               INT             NULL,
    [IdMoneda]                    INT             NULL,
    [CotizacionMoneda]            NUMERIC (18, 4) NULL,
    [REP_IMPUTAC_INS]             VARCHAR (1)     NULL,
    [REP_IMPUTAC_UPD]             VARCHAR (1)     NULL,
    [IdDetalleComprobante]        INT             NULL,
    [EnviarEmail]                 TINYINT         NULL,
    [IdOrigenTransmision]         INT             NULL,
    [IdSubdiarioOriginal]         INT             NULL,
    [FechaImportacionTransmision] DATETIME        NULL,
    [IdComprobanteOriginal]       INT             NULL,
    CONSTRAINT [PK_Subdiarios] PRIMARY KEY NONCLUSTERED ([IdSubdiario] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[Subdiarios]([FechaComprobante] ASC, [NumeroComprobante] ASC, [Haber] ASC, [IdSubdiario] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[Subdiarios]([IdCuenta] ASC, [FechaComprobante] ASC) WITH (FILLFACTOR = 90);

