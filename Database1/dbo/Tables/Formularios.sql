CREATE TABLE [dbo].[Formularios] (
    [IdFormulario] INT          NOT NULL,
    [Descripcion]  VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Formularios] PRIMARY KEY CLUSTERED ([IdFormulario] ASC) WITH (FILLFACTOR = 90)
);

