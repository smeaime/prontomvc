CREATE TABLE [dbo].[DetalleAutorizacionesFirmantes] (
    [IdDetalleAutorizacionFirmantes] INT             IDENTITY (1, 1) NOT NULL,
    [IdDetalleAutorizacion]          INT             NULL,
    [IdAutorizacion]                 INT             NULL,
    [IdFirmante]                     INT             NULL,
    [IdRubro]                        INT             NULL,
    [IdSubrubro]                     INT             NULL,
    [ParaTaller]                     VARCHAR (2)     NULL,
    [ImporteDesde]                   NUMERIC (18, 2) NULL,
    [ImporteHasta]                   NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_DetalleAutorizacionesFirmantes] PRIMARY KEY CLUSTERED ([IdDetalleAutorizacionFirmantes] ASC) WITH (FILLFACTOR = 90)
);

