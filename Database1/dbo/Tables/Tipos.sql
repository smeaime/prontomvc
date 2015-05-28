CREATE TABLE [dbo].[Tipos] (
    [IdTipo]      INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura] VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Codigo]      INT          NULL,
    [Grupo]       INT          NULL,
    CONSTRAINT [PK_Tipos] PRIMARY KEY CLUSTERED ([IdTipo] ASC) WITH (FILLFACTOR = 90)
);

