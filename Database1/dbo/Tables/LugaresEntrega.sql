CREATE TABLE [dbo].[LugaresEntrega] (
    [IdLugarEntrega] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]    VARCHAR (50) NULL,
    [Detalle]        NTEXT        NULL,
    CONSTRAINT [PK_LugaresEntrega] PRIMARY KEY CLUSTERED ([IdLugarEntrega] ASC) WITH (FILLFACTOR = 90)
);

