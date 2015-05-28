CREATE TABLE [dbo].[Rangos] (
    [IdRango]     INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    CONSTRAINT [PK_Rangos] PRIMARY KEY CLUSTERED ([IdRango] ASC) WITH (FILLFACTOR = 90)
);

