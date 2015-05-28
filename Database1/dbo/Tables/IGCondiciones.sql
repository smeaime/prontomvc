CREATE TABLE [dbo].[IGCondiciones] (
    [IdIGCondicion] INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion]   VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_IGCondiciones] PRIMARY KEY CLUSTERED ([IdIGCondicion] ASC) WITH (FILLFACTOR = 90)
);

