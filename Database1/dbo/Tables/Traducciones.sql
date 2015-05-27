CREATE TABLE [dbo].[Traducciones] (
    [IdTraduccion]            INT           IDENTITY (1, 1) NOT NULL,
    [Descripcion_esp]         VARCHAR (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion_ing]         VARCHAR (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [Descripcion_por]         VARCHAR (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
    [FechaAlta]               DATETIME      NULL,
    [FechaUltimaModificacion] DATETIME      NULL,
    CONSTRAINT [PK_Traducciones] PRIMARY KEY CLUSTERED ([IdTraduccion] ASC) WITH (FILLFACTOR = 90)
);

