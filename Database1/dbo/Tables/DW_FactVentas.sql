CREATE TABLE [dbo].[DW_FactVentas] (
    [IdVentas]         INT             IDENTITY (1, 1) NOT NULL,
    [IdCliente]        INT             NULL,
    [Fecha]            INT             NULL,
    [IdCodigoIva]      TINYINT         NULL,
    [IdVendedor]       INT             NULL,
    [IdObra]           INT             NULL,
    [Importe]          NUMERIC (18, 2) NULL,
    [ClaveComprobante] NUMERIC (16)    NULL,
    CONSTRAINT [PK_DW_FactVentas] PRIMARY KEY CLUSTERED ([IdVentas] ASC) WITH (FILLFACTOR = 90)
);

