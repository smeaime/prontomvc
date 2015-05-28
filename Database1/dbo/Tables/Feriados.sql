CREATE TABLE [dbo].[Feriados] (
    [IdFeriado]   INT          IDENTITY (1, 1) NOT NULL,
    [Descripcion] VARCHAR (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Fecha]       DATETIME     NULL,
    CONSTRAINT [PK_Feriados] PRIMARY KEY CLUSTERED ([IdFeriado] ASC) WITH (FILLFACTOR = 90)
);

