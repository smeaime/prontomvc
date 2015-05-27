CREATE TABLE [dbo].[TiposValores] (
    [IdTipoValor] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_TiposValores] PRIMARY KEY CLUSTERED ([IdTipoValor] ASC) WITH (FILLFACTOR = 90)
);

