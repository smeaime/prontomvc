CREATE TABLE [dbo].[DetalleProveedores] (
    [IdDetalleProveedor] INT           IDENTITY (1, 1) NOT NULL,
    [IdProveedor]        INT           NULL,
    [Contacto]           VARCHAR (50)  NULL,
    [Puesto]             VARCHAR (50)  NULL,
    [Telefono]           VARCHAR (50)  NULL,
    [Email]              VARCHAR (50)  NULL,
    [Acciones]           VARCHAR (500) NULL,
    CONSTRAINT [PK_DetalleProveedores] PRIMARY KEY CLUSTERED ([IdDetalleProveedor] ASC) WITH (FILLFACTOR = 90)
);

