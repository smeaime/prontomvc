CREATE TABLE [dbo].[AutorizacionesCompra] (
    [IdAutorizacionCompra]   INT         IDENTITY (1, 1) NOT NULL,
    [Numero]                 INT         NULL,
    [Fecha]                  DATETIME    NULL,
    [IdObra]                 INT         NULL,
    [IdProveedor]            INT         NULL,
    [Observaciones]          NTEXT       NULL,
    [IdRealizo]              INT         NULL,
    [IdAprobo]               INT         NULL,
    [IdUsuarioIngreso]       INT         NULL,
    [FechaIngreso]           DATETIME    NULL,
    [IdUsuarioModifico]      INT         NULL,
    [FechaModifico]          DATETIME    NULL,
    [CircuitoFirmasCompleto] VARCHAR (2) NULL,
    CONSTRAINT [PK_AutorizacionesCompra] PRIMARY KEY CLUSTERED ([IdAutorizacionCompra] ASC) WITH (FILLFACTOR = 90)
);

