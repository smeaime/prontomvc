CREATE TABLE [dbo].[Estados Proveedores] (
    [IdEstado]    INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Activo]      VARCHAR (2)  NULL,
    CONSTRAINT [PK_Estados Proveedores] PRIMARY KEY CLUSTERED ([IdEstado] ASC) WITH (FILLFACTOR = 90)
);

