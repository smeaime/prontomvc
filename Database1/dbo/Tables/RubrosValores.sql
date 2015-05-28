CREATE TABLE [dbo].[RubrosValores] (
    [IdRubroValor] INT          IDENTITY (1, 1) NOT NULL,
    [Codigo]       VARCHAR (5)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion]  VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_RubrosValores] PRIMARY KEY CLUSTERED ([IdRubroValor] ASC) WITH (FILLFACTOR = 90)
);

