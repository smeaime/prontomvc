CREATE TABLE [dbo].[CategoriasCredito] (
    [IdCategoriaCredito] INT             IDENTITY (1, 1) NOT NULL,
    [Descripcion]        VARCHAR (50)    NULL,
    [Codigo]             INT             NULL,
    [Importe]            NUMERIC (18, 2) NULL,
    CONSTRAINT [PK_CategoriasCredito] PRIMARY KEY CLUSTERED ([IdCategoriaCredito] ASC) WITH (FILLFACTOR = 90)
);

