CREATE TABLE [dbo].[Materiales] (
    [IdMaterial]  INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Materiales] PRIMARY KEY CLUSTERED ([IdMaterial] ASC) WITH (FILLFACTOR = 90)
);

