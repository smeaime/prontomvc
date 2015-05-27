CREATE TABLE [dbo].[DetalleClientes] (
    [IdDetalleCliente] INT           IDENTITY (1, 1) NOT NULL,
    [IdCliente]        INT           NULL,
    [Contacto]         VARCHAR (50)  NULL,
    [Puesto]           VARCHAR (50)  NULL,
    [Telefono]         VARCHAR (50)  NULL,
    [Email]            VARCHAR (200) NULL,
    [Acciones]         VARCHAR (500) NULL,
    CONSTRAINT [PK_DetalleClientes] PRIMARY KEY CLUSTERED ([IdDetalleCliente] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_DetalleClientes_Clientes] FOREIGN KEY ([IdCliente]) REFERENCES [dbo].[Clientes] ([IdCliente])
);

