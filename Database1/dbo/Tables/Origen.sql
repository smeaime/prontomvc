CREATE TABLE [dbo].[Origen] (
    [IdOrigen] INT          IDENTITY (1, 1) NOT NULL,
    [Origen]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Origen] PRIMARY KEY CLUSTERED ([IdOrigen] ASC) WITH (FILLFACTOR = 90)
);

