CREATE TABLE [dbo].[DetalleAsientos] (
    [IdDetalleAsiento]              INT             IDENTITY (1, 1) NOT NULL,
    [IdAsiento]                     INT             NULL,
    [IdCuenta]                      INT             NULL,
    [IdTipoComprobante]             INT             NULL,
    [NumeroComprobante]             INT             NULL,
    [FechaComprobante]              DATETIME        NULL,
    [Libro]                         VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Signo]                         VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [TipoImporte]                   VARCHAR (1)     COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Cuit]                          VARCHAR (13)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Detalle]                       VARCHAR (50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Debe]                          NUMERIC (18, 2) NULL,
    [Haber]                         NUMERIC (18, 2) NULL,
    [IdObra]                        INT             NULL,
    [IdCuentaGasto]                 INT             NULL,
    [IdMoneda]                      INT             NULL,
    [CotizacionMoneda]              NUMERIC (18, 4) NULL,
    [IdCuentaBancaria]              INT             NULL,
    [IdCaja]                        INT             NULL,
    [IdMonedaDestino]               INT             NULL,
    [CotizacionMonedaDestino]       NUMERIC (18, 4) NULL,
    [ImporteEnMonedaDestino]        NUMERIC (18, 2) NULL,
    [PorcentajeIVA]                 NUMERIC (6, 2)  NULL,
    [RegistrarEnAnalitico]          VARCHAR (2)     NULL,
    [Item]                          INT             NULL,
    [IdValor]                       INT             NULL,
    [IdProvinciaDestino]            INT             NULL,
    [IdDetalleComprobanteProveedor] INT             NULL,
    CONSTRAINT [PK_DetalleAsientos] PRIMARY KEY NONCLUSTERED ([IdDetalleAsiento] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleAsientos_Asientos] FOREIGN KEY ([IdAsiento]) REFERENCES [dbo].[Asientos] ([IdAsiento])
);


GO
CREATE NONCLUSTERED INDEX [Indice1]
    ON [dbo].[DetalleAsientos]([IdCuenta] ASC, [FechaComprobante] ASC, [IdDetalleAsiento] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice2]
    ON [dbo].[DetalleAsientos]([FechaComprobante] ASC, [IdCuenta] ASC, [IdDetalleAsiento] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Indice3]
    ON [dbo].[DetalleAsientos]([IdValor] ASC) WITH (FILLFACTOR = 90);

