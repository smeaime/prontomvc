CREATE TABLE [dbo].[DetalleClientesDirecciones] (
    [IdDetalleClienteDireccion] INT          IDENTITY (1, 1) NOT NULL,
    [IdCliente]                 INT          NULL,
    [Direccion]                 VARCHAR (50) NULL,
    [IdLocalidad]               INT          NULL,
    [IdProvincia]               INT          NULL,
    [IdPais]                    INT          NULL,
    CONSTRAINT [PK_DetalleClientesDirecciones] PRIMARY KEY CLUSTERED ([IdDetalleClienteDireccion] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleClientesDirecciones_Clientes] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente])
);

