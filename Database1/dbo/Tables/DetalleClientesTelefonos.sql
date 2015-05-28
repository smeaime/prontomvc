CREATE TABLE [dbo].[DetalleClientesTelefonos] (
    [IdDetalleClienteTelefono] INT          IDENTITY (1, 1) NOT NULL,
    [IdCliente]                INT          NULL,
    [Detalle]                  VARCHAR (50) NULL,
    [Telefono]                 VARCHAR (50) NULL,
    CONSTRAINT [PK_DetalleClientesTelefonos] PRIMARY KEY CLUSTERED ([IdDetalleClienteTelefono] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleClientesTelefonos_Clientes] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente])
);

