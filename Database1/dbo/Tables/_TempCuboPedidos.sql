CREATE TABLE [dbo].[_TempCuboPedidos] (
    [IdCuboPedidos] INT             IDENTITY (1, 1) NOT NULL,
    [Proveedor]     VARCHAR (50)    NULL,
    [Obra]          VARCHAR (70)    NULL,
    [Fecha]         DATETIME        NULL,
    [Detalle]       VARCHAR (150)   NULL,
    [Articulo]      VARCHAR (300)   NULL,
    [Importe]       NUMERIC (18, 2) NULL,
    CONSTRAINT [PK__TempCuboPedidos] PRIMARY KEY CLUSTERED ([IdCuboPedidos] ASC) WITH (FILLFACTOR = 90)
);

