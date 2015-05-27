CREATE TABLE [dbo].[Titulos] (
    [IdTitulo] INT          IDENTITY (1, 1) NOT NULL,
    [Titulo]   VARCHAR (50) NULL,
    CONSTRAINT [PK_Titulos] PRIMARY KEY CLUSTERED ([IdTitulo] ASC) WITH (FILLFACTOR = 90)
);

