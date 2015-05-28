CREATE TABLE [dbo].[DetalleClientesLugaresEntrega] (
    [IdDetalleClienteLugarEntrega] INT          IDENTITY (1, 1) NOT NULL,
    [IdCliente]                    INT          NULL,
    [DireccionEntrega]             VARCHAR (50) NULL,
    [IdLocalidadEntrega]           INT          NULL,
    [IdProvinciaEntrega]           INT          NULL,
    CONSTRAINT [PK_DetalleClientesLugaresEntrega] PRIMARY KEY CLUSTERED ([IdDetalleClienteLugarEntrega] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleLugaresEntrega_Clientes] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente])
);

