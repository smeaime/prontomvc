CREATE TABLE [dbo].[Marcas] (
    [IdMarca]     INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Codigo]      INT          NULL,
    CONSTRAINT [PK_Marcas] PRIMARY KEY CLUSTERED ([IdMarca] ASC) WITH (FILLFACTOR = 90)
);

