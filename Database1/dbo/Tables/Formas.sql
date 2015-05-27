CREATE TABLE [dbo].[Formas] (
    [IdForma]     INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Abreviatura] VARCHAR (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Formas] PRIMARY KEY CLUSTERED ([IdForma] ASC) WITH (FILLFACTOR = 90)
);

