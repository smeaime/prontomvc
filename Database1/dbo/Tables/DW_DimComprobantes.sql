CREATE TABLE [dbo].[DW_DimComprobantes] (
    [ClaveComprobante]  NUMERIC (16) NOT NULL,
    [Comprobante]       VARCHAR (25) NULL,
    [Partida]           VARCHAR (20) NULL,
    [NumeroCaja]        INT          NULL,
    [IdArticulo]        INT          NULL,
    [IdUnidad]          INT          NULL,
    [IdUbicacion]       INT          NULL,
    [IdObra]            INT          NULL,
    [IdColor]           INT          NULL,
    [Fecha]             INT          NULL,
    [IdCliente]         INT          NULL,
    [IdProveedor]       INT          NULL,
    [IdVendedor]        INT          NULL,
    [IdTipoComprobante] INT          NULL,
    [IdComprobante]     INT          NULL,
    CONSTRAINT [PK_DW_DimComprobantes] PRIMARY KEY CLUSTERED ([ClaveComprobante] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [IdArticulo]
    ON [dbo].[DW_DimComprobantes]([IdArticulo] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IdObra]
    ON [dbo].[DW_DimComprobantes]([IdObra] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Fecha]
    ON [dbo].[DW_DimComprobantes]([Fecha] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IdCliente]
    ON [dbo].[DW_DimComprobantes]([IdCliente] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IdProveedor]
    ON [dbo].[DW_DimComprobantes]([IdProveedor] ASC) WITH (FILLFACTOR = 90);

