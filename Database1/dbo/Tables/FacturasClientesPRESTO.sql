CREATE TABLE [dbo].[FacturasClientesPRESTO] (
    [IdFacturaClientePRESTO] INT             IDENTITY (1, 1) NOT NULL,
    [IdCliente]              INT             NULL,
    [FechaIngreso]           DATETIME        NULL,
    [NumeroFacturaPRESTO]    VARCHAR (20)    NULL,
    [ImporteTotal]           NUMERIC (18, 2) NULL,
    [Confirmado]             VARCHAR (2)     NULL,
    [FechaConfirmacion]      DATETIME        NULL,
    [IdUsuarioConfirmo]      INT             NULL,
    CONSTRAINT [PK_FacturasClientesPRESTO] PRIMARY KEY CLUSTERED ([IdFacturaClientePRESTO] ASC) WITH (FILLFACTOR = 90)
);

