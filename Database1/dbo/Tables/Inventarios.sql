CREATE TABLE [dbo].[Inventarios] (
    [IdInventario]     INT          IDENTITY (1, 1) NOT NULL,
    [CodigoInventario] TINYINT      NULL,
    [Descripcion]      VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Inventarios] PRIMARY KEY CLUSTERED ([IdInventario] ASC) WITH (FILLFACTOR = 90)
);

