CREATE TABLE [dbo].[AniosNorma] (
    [IdAnioNorma] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_AniosNorma] PRIMARY KEY CLUSTERED ([IdAnioNorma] ASC) WITH (FILLFACTOR = 90)
);

